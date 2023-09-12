use std::net::Ipv4Addr;
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

#[derive(Debug, Clone, Copy)]
pub struct ArtnetInputConfig {
    pub host: Ipv4Addr,
    pub port: u16,
}

impl ArtnetInputConfig {
    pub fn new(host: Ipv4Addr, port: Option<u16>) -> Self {
        Self {
            host,
            port: port.unwrap_or(6454),
        }
    }
}

impl ArtnetInput {
    pub fn new(host: Ipv4Addr, port: Option<u16>) -> anyhow::Result<Self> {
        let config = ArtnetInputConfig::new(host, port);
        let thread_handle = ArtnetInputThread::spawn(config)?;

        Ok(Self {
            config,
            thread_handle,
        })
    }

    pub fn reconfigure(
        &mut self,
        mut config: ArtnetInputConfig,
    ) -> anyhow::Result<ArtnetInputConfig> {
        self.thread_handle.reconfigure(config)?;
        std::mem::swap(&mut self.config, &mut config);

        Ok(config)
    }
}

impl DmxInput for ArtnetInput {
    fn name(&self) -> String {
        format!("Artnet ({:?}:{})", self.config.host, self.config.port)
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
        // let universe = msg.port_address.into(); // TODO: implement in fork
        let universe = 1;
        let mut universe = self.buffer.entry(universe).or_insert([0; 512]);
        msg.data.as_mut().resize(512, 0);
        universe.copy_from_slice(msg.data.as_ref());

        Ok(())
    }

    async fn poll(&self, socket: &UdpSocket, poll: Poll) -> anyhow::Result<()> {
        Ok(())
        // let msg = artnet_protocol::PollReply {
        //     port: self.config.port,
        //     address: self.config.host,
        // };
        // let msg = ArtCommand::PollReply(Box::new(msg)).write_to_buffer()?;
        // socket.send_to(&msg, broadcast_addr).await?;
    }
}

#[derive(Debug, Clone)]
enum ThreadMessage {
    Exit,
    Reconfigure(ArtnetInputConfig),
}
