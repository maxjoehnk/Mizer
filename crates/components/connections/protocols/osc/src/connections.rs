use crate::output::OscOutput;
use crate::subscription::OscSubscription;
use flume::{Receiver, Sender};
use futures::future::Either;
use futures::{future, FutureExt};
use mizer_message_bus::{MessageBus, Subscriber};
use rosc::{OscMessage, OscPacket};
use serde::{Deserialize, Serialize};
use std::fmt::{Display, Formatter};
use std::future::Future;
use std::net::{Ipv4Addr, SocketAddrV4};
use tokio::net::UdpSocket;
use mizer_connection_contracts::{ConnectionStorage, IConnection, StableConnectionId, TransmissionStateSender};

#[derive(Serialize, Deserialize, Debug, Clone, Copy, PartialEq, Eq)]
pub struct OscAddress {
    pub protocol: OscProtocol,
    pub output_host: Ipv4Addr,
    pub output_port: u16,
    pub input_port: u16,
}

impl OscAddress {
    fn output_addr(&self) -> SocketAddrV4 {
        SocketAddrV4::new(self.output_host, self.output_port)
    }

    fn input_addr(&self) -> SocketAddrV4 {
        SocketAddrV4::new(Ipv4Addr::UNSPECIFIED, self.input_port)
    }
}

impl From<OscAddress> for SocketAddrV4 {
    fn from(value: OscAddress) -> Self {
        SocketAddrV4::new(value.output_host, value.output_port)
    }
}

#[derive(Serialize, Deserialize, Debug, Clone, Copy, Eq, PartialEq)]
#[serde(rename_all = "camelCase")]
pub enum OscProtocol {
    Udp,
    Tcp,
}

impl Display for OscProtocol {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Tcp => f.write_str("osc.tcp"),
            Self::Udp => f.write_str("osc.udp"),
        }
    }
}

pub trait OscConnectionExt {
    fn get_output(&self, id: &StableConnectionId) -> Option<OscOutput>;
    fn subscribe(&self, id: &StableConnectionId) -> anyhow::Result<Option<OscSubscription>>;
}

impl OscConnectionExt for ConnectionStorage {
    fn get_output(&self, id: &StableConnectionId) -> Option<OscOutput> {
        let connection = self.get_connection_by_stable::<OscConnection>(id)?;

        Some(OscOutput::new(&connection.command_publisher))
    }

    fn subscribe(&self, id: &StableConnectionId) -> anyhow::Result<Option<OscSubscription>> {
        let Some(connection) = self.get_connection_by_stable::<OscConnection>(id) else {
            return Ok(None);
        };
        let subscriber = connection.subscribe()?;

        Ok(Some(OscSubscription {
            connection_id: id.to_string(),
            subscriber,
        }))
    }
}

pub struct OscConnection {
    pub address: OscAddress,
    command_publisher: Sender<OscClientCommand>,
    event_publisher: MessageBus<OscMessage>,
}

impl IConnection for OscConnection {
    type Config = OscAddress;
    const TYPE: &'static str = "osc";

    fn create(address: Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self> {
        let (connection, background_client) = OscConnection::new(address, transmission_sender)?;
        tokio::spawn(async {
            let client = background_client.await.unwrap();
            client.run().await;
        });

        Ok(connection)
    }
}

impl OscConnection {
    fn new(
        address: OscAddress,
        transmission_sender: TransmissionStateSender,
    ) -> anyhow::Result<(
        Self,
        impl Future<Output = anyhow::Result<OscBackgroundClient>>,
    )> {
        let (command_publisher, command_receiver) = flume::unbounded();
        let event_publisher = MessageBus::new();

        let connection = Self {
            address,
            command_publisher,
            event_publisher: event_publisher.clone(),
        };
        let background_client = async move {
            Ok(OscBackgroundClient {
                addr: address,
                input_socket: UdpSocket::bind(address.input_addr()).await?,
                output_socket: UdpSocket::bind("0.0.0.0:0").await?,
                command_receiver,
                event_publisher,
                transmission_sender,
            })
        };
        Ok((connection, background_client))
    }

    pub(crate) fn reconfigure(
        &mut self,
        address: OscAddress,
    ) -> anyhow::Result<OscAddress> {
        let mut previous_address = address;
        std::mem::swap(&mut self.address, &mut previous_address);
        self.command_publisher
            .send(OscClientCommand::Reconfigure(address))?;

        Ok(previous_address)
    }

    fn subscribe(&self) -> anyhow::Result<Subscriber<OscMessage>> {
        let subscriber = self.event_publisher.subscribe();

        Ok(subscriber)
    }
}

impl Drop for OscConnection {
    fn drop(&mut self) {
        if let Err(err) = self.command_publisher.send(OscClientCommand::Close) {
            tracing::error!("Unable to close osc client thread: {err:?}");
        }
    }
}

#[derive(Debug)]
pub(crate) enum OscClientCommand {
    Close,
    Reconfigure(OscAddress),
    Publish(OscMessage),
}

struct OscBackgroundClient {
    addr: OscAddress,
    input_socket: UdpSocket,
    output_socket: UdpSocket,
    command_receiver: Receiver<OscClientCommand>,
    event_publisher: MessageBus<OscMessage>,
    transmission_sender: TransmissionStateSender,
}

impl OscBackgroundClient {
    async fn run(mut self) {
        let mut buffer = [0u8; rosc::decoder::MTU];
        loop {
            let (cmd, event) = {
                let commands = self.command_receiver.recv_async().fuse();
                let subscriptions = self.input_socket.recv(&mut buffer).fuse();
                futures::pin_mut!(commands);
                futures::pin_mut!(subscriptions);

                match future::select(commands, subscriptions).await {
                    Either::Left((cmd, _)) => (Some(cmd), None),
                    Either::Right((Ok(buffer_size), _)) => (None, Some(buffer_size)),
                    Either::Right((Err(err), _)) => {
                        tracing::error!("Error reading from udp socket: {err:?}");

                        (None, None)
                    }
                }
            };

            if let Some(cmd) = cmd {
                match self.handle_command(cmd).await {
                    Ok(true) => break,
                    Err(err) => tracing::error!("Error handling osc background command {:?}", err),
                    _ => {}
                }
            }

            if let Some(buffer_size) = event {
                self.transmission_sender.received_packet();
                if let Err(err) = self.handle_event(&buffer[..buffer_size]) {
                    tracing::error!("Error handling osc packet {:?}", err)
                }
            }
        }
    }

    async fn handle_command(
        &mut self,
        command: Result<OscClientCommand, flume::RecvError>,
    ) -> anyhow::Result<bool> {
        let command = command?;
        tracing::trace!("handle_command {:?}", command);
        match command {
            OscClientCommand::Publish(msg) => {
                tracing::debug!("Publishing osc packet {msg:?}");
                let packet = rosc::encoder::encode(&OscPacket::Message(msg))?;
                self.output_socket
                    .send_to(&packet, self.addr.output_addr())
                    .await?;
                self.transmission_sender.sent_packet();

                Ok(false)
            }
            OscClientCommand::Reconfigure(address) => {
                self.addr = address;
                self.input_socket = UdpSocket::bind(address.input_addr()).await?;

                Ok(false)
            }
            OscClientCommand::Close => Ok(true),
        }
    }

    fn handle_event(&mut self, buffer: &[u8]) -> anyhow::Result<()> {
        let (_, packet) = rosc::decoder::decode_udp(buffer)?;
        self.handle_packet(packet);

        Ok(())
    }

    fn handle_packet(&mut self, packet: OscPacket) {
        match packet {
            OscPacket::Message(msg) => self.event_publisher.send(msg),
            OscPacket::Bundle(bundle) => {
                for packet in bundle.content {
                    self.handle_packet(packet);
                }
            }
        }
    }
}
