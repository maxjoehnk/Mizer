use std::net::{UdpSocket, ToSocketAddrs};
use crate::buffer::DmxBuffer;
use crate::DmxOutput;
use std::collections::HashMap;
use std::convert::TryFrom;

pub struct ArtnetOutput {
    socket: UdpSocket,
    host: String,
    port: u16,
    buffer: DmxBuffer,
}

impl ArtnetOutput {
    pub fn new(host: String, port: Option<u16>) -> anyhow::Result<Self> {
        let port = port.unwrap_or(6454);
        let socket = UdpSocket::bind(("127.0.0.1", 0))?;
        socket.set_broadcast(true)?;

        Ok(ArtnetOutput {
            socket,
            host,
            port,
            buffer: DmxBuffer::default(),
        })
    }
}

impl DmxOutput for ArtnetOutput {
    fn name(&self) -> String {
        format!("Artnet ({}:{})", self.host, self.port)
    }

    fn write_single(&self, universe: u16, channel: u8, value: u8) {
        self.buffer.write_single(universe, channel, value)
    }

    fn write_bulk(&self, universe: u16, channel: u8, values: &[u8]) {
        self.buffer.write_bulk(universe, channel, values)
    }

    fn flush(&self) {
        let broadcast_addr = (self.host.as_str(), self.port)
            .to_socket_addrs()
            .unwrap()
            .next()
            .unwrap();

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

            self.socket.send_to(&msg, broadcast_addr).unwrap();
        }
    }

    fn read_buffer(&self) -> HashMap<u16, [u8; 512]> {
        let buffers = self.buffer.buffers.lock().unwrap();
        buffers.clone()
    }
}
