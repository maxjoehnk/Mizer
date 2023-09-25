use super::DmxOutput;
use crate::buffer::DmxBuffer;
use std::collections::HashMap;
use std::convert::TryFrom;
use std::net::{SocketAddr, ToSocketAddrs, UdpSocket};

pub struct ArtnetOutput {
    socket: UdpSocket,
    pub host: String,
    pub port: u16,
    buffer: DmxBuffer,
}

impl ArtnetOutput {
    pub fn new(host: String, port: Option<u16>) -> anyhow::Result<Self> {
        let port = port.unwrap_or(6454);
        let socket = UdpSocket::bind(("0.0.0.0", 0))?;
        socket.set_nonblocking(true)?;
        socket.set_broadcast(true)?;

        Ok(ArtnetOutput {
            socket,
            host,
            port,
            buffer: DmxBuffer::default(),
        })
    }

    fn parse_addr(&self) -> anyhow::Result<SocketAddr> {
        let addr = (self.host.as_str(), self.port)
            .to_socket_addrs()?
            .next()
            .ok_or_else(|| anyhow::anyhow!("Invalid artnet address"))?;

        Ok(addr)
    }
}

impl DmxOutput for ArtnetOutput {
    fn name(&self) -> String {
        format!("Artnet ({}:{})", self.host, self.port)
    }

    fn write_single(&self, universe: u16, channel: u16, value: u8) {
        self.buffer.write_single(universe, channel, value)
    }

    fn write_bulk(&self, universe: u16, channel: u16, values: &[u8]) {
        self.buffer.write_bulk(universe, channel, values)
    }

    fn flush(&self) {
        profiling::scope!("ArtnetOutput::flush");
        let broadcast_addr = match self.parse_addr() {
            Ok(addr) => addr,
            Err(err) => {
                log::error!("Unable to parse artnet address: {:?}", err);
                return;
            }
        };

        let universe_buffer = self.buffer.buffers.lock().unwrap();
        for (universe, buffer) in universe_buffer.iter() {
            let msg = artnet_protocol::Output {
                port_address: artnet_protocol::PortAddress::try_from(*universe - 1).unwrap(),
                data: buffer.to_vec().into(),
                ..artnet_protocol::Output::default()
            };

            let msg = artnet_protocol::ArtCommand::Output(msg)
                .write_to_buffer()
                .unwrap();

            if let Err(err) = self.socket.send_to(&msg, broadcast_addr) {
                log::error!("Unable to send to artnet server {:?}", err);
            }
        }
    }

    fn read_buffer(&self) -> HashMap<u16, [u8; 512]> {
        let buffers = self.buffer.buffers.lock().unwrap();
        buffers.clone()
    }
}
