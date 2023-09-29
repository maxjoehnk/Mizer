use std::net::{Ipv4Addr, ToSocketAddrs};
use std::sync::Arc;
use std::thread;
use std::thread::JoinHandle;

use artnet_protocol::{ArtCommand, Output, Poll};
use dashmap::DashMap;
use flume::{Receiver, Sender};
use tokio::net::UdpSocket;

use super::DmxInput;

#[derive(Debug)]
pub struct ArtnetInput {
    pub config: ArtnetInputConfig,
    thread_handle: ThreadHandle,
}

#[derive(Debug, Clone)]
pub struct ArtnetInputConfig {
    pub name: String,
    pub host: Ipv4Addr,
    pub port: u16,
}

impl ArtnetInputConfig {
    pub fn new(host: Ipv4Addr, port: Option<u16>, name: String) -> Self {
        Self {
            host,
            port: port.unwrap_or(6454),
            name,
        }
    }
}

impl ArtnetInput {
    pub fn new(host: Ipv4Addr, port: Option<u16>, name: String) -> anyhow::Result<Self> {
        let config = ArtnetInputConfig::new(host, port, name);
        let thread_handle = ArtnetInputThread::spawn(config.clone())?;

        Ok(Self {
            config,
            thread_handle,
        })
    }

    pub fn reconfigure(
        &mut self,
        mut config: ArtnetInputConfig,
    ) -> anyhow::Result<ArtnetInputConfig> {
        self.thread_handle.reconfigure(config.clone())?;
        std::mem::swap(&mut self.config, &mut config);

        Ok(config)
    }
}

impl DmxInput for ArtnetInput {
    fn name(&self) -> String {
        self.config.name.clone()
    }

    fn read_single(&self, universe: u16, channel: u16) -> Option<u8> {
        self.thread_handle
            .buffer
            .get(&universe)
            .map(|channels| channels[channel.saturating_sub(1) as usize])
    }

    fn read_bulk(&self, universe: u16) -> Option<Vec<u8>> {
        self.thread_handle
            .buffer
            .get(&universe)
            .map(|channels| channels.to_vec())
    }
}

#[derive(Debug)]
struct ThreadHandle {
    thread: JoinHandle<()>,
    buffer: Arc<DashMap<u16, [u8; 512]>>,
    sender: Sender<ThreadMessage>,
}

impl ThreadHandle {
    fn exit(self) -> anyhow::Result<()> {
        self.sender.send(ThreadMessage::Exit)?;

        Ok(())
    }

    fn reconfigure(&self, config: ArtnetInputConfig) -> anyhow::Result<()> {
        self.sender.try_send(ThreadMessage::Reconfigure(config))?;

        Ok(())
    }
}

struct ArtnetInputThread {
    config: ArtnetInputConfig,
    buffer: Arc<DashMap<u16, [u8; 512]>>,
    receiver: Receiver<ThreadMessage>,
}

impl ArtnetInputThread {
    fn spawn(config: ArtnetInputConfig) -> anyhow::Result<ThreadHandle> {
        let buffer = DashMap::new();
        let buffer = Arc::new(buffer);
        let (sender, receiver) = flume::bounded(20);
        let send_buffer = Arc::clone(&buffer);
        let handle = thread::Builder::new()
            .name("ArtnetInputThread".into())
            .spawn(move || {
                // TODO: handle crashes
                if let Err(err) = Self::start(config, send_buffer, receiver) {
                    tracing::error!(err = %err, "ArtnetInputThread crashed");
                }
            })?;

        Ok(ThreadHandle {
            thread: handle,
            buffer,
            sender,
        })
    }

    fn start(
        config: ArtnetInputConfig,
        buffer: Arc<DashMap<u16, [u8; 512]>>,
        receiver: Receiver<ThreadMessage>,
    ) -> anyhow::Result<()> {
        let runtime = tokio::runtime::Builder::new_current_thread()
            .enable_io()
            .build()?;

        let runner = Self {
            config,
            buffer,
            receiver,
        };

        runtime.block_on(runner.run())
    }

    async fn run(self) -> anyhow::Result<()> {
        tracing::debug!("Starting artnet input thread");
        let socket = UdpSocket::bind((self.config.host, self.config.port)).await?;
        socket.set_broadcast(true)?;
        loop {
            socket.readable().await?;
            let mut buffer = Vec::with_capacity(1024);
            tracing::trace!("Waiting for artnet message");
            match socket.try_recv_buf(&mut buffer) {
                Err(err) if err.kind() == std::io::ErrorKind::WouldBlock => continue,
                Err(err) => tracing::error!(err = %err, "Error receiving artnet message"),
                Ok(bytes) => match ArtCommand::from_buffer(&buffer[0..bytes]) {
                    Err(err) => tracing::error!(err = %err, "Unable to decode artnet message"),
                    Ok(ArtCommand::Output(msg)) => {
                        if let Err(err) = self.output(msg).await {
                            tracing::error!(err = %err, "Unable to handle output message");
                        }
                    }
                    Ok(ArtCommand::Poll(poll)) => {
                        if let Err(err) = self.poll(&socket, poll).await {
                            tracing::error!(err = %err, "Unable to respond to poll request");
                        }
                    }
                    Ok(msg) => tracing::debug!("Ignoring unimplemented message {msg:?}"),
                },
            }
        }
    }

    async fn output(&self, mut msg: Output) -> anyhow::Result<()> {
        tracing::trace!(?msg, "Received artnet output message");
        // TODO: check for sequence
        let universe: u16 = msg.port_address.into();
        let mut universe = self.buffer.entry(universe).or_insert([0; 512]);
        msg.data.as_mut().resize(512, 0);
        universe.copy_from_slice(msg.data.as_ref());

        Ok(())
    }

    async fn poll(&self, socket: &UdpSocket, _poll: Poll) -> anyhow::Result<()> {
        if let Some(broadcast_addr) = ("255.255.255.255", 6454).to_socket_addrs()?.next() {
            let mut name = self.config.name.clone().into_bytes();
            name.resize(64, 0);
            let short_name = name[0..18].try_into()?;
            let long_name = name[0..64].try_into()?;
            let msg = artnet_protocol::PollReply {
                port: self.config.port,
                address: self.config.host,
                version: [0; 2],
                port_address: [0; 2],
                oem: [0; 2],
                ubea_version: 0,
                status_1: 0,
                esta_code: 0,
                short_name,
                long_name,
                node_report: [0; 64],
                num_ports: [0; 2],
                port_types: [0; 4],
                good_input: [0; 4],
                good_output: [0; 4],
                swin: [0; 4],
                swout: [0; 4],
                sw_video: 0,
                sw_macro: 0,
                sw_remote: 0,
                spare: [0; 3],
                style: 0,
                mac: [0; 6],
                bind_ip: [0; 4],
                bind_index: 0,
                status_2: 0,
                filler: [0; 26],
            };
            let msg = ArtCommand::PollReply(Box::new(msg)).write_to_buffer()?;
            socket.send_to(&msg, broadcast_addr).await?;
        }

        Ok(())
    }
}

#[derive(Debug, Clone)]
enum ThreadMessage {
    Exit,
    Reconfigure(ArtnetInputConfig),
}
