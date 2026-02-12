use super::DmxOutput;
use crate::buffer::DmxBuffer;
use std::convert::TryFrom;
use std::net::{SocketAddr, ToSocketAddrs, UdpSocket};
use mizer_connection_contracts::{IConnection, TransmissionStateSender};

pub struct ArtnetOutput {
    socket: UdpSocket,
    pub host: String,
    pub port: u16,
    transmission_sender: TransmissionStateSender,
}

impl IConnection for ArtnetOutput {
    type Config = (String, Option<u16>);
    const TYPE: &'static str = "dmx";

    fn create((host, port): Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self> {
        let port = port.unwrap_or(6454);
        let socket = UdpSocket::bind(("0.0.0.0", 0))?;
        socket.set_nonblocking(true)?;
        socket.set_broadcast(true)?;

        Ok(ArtnetOutput { socket, host, port, transmission_sender })
    }
}

impl ArtnetOutput {
    pub(crate) fn reconfigure(&mut self, host: String, port: Option<u16>) -> (String, u16) {
        let mut old_host = host;
        let mut old_port = port.unwrap_or(6454);
        std::mem::swap(&mut self.host, &mut old_host);
        std::mem::swap(&mut self.port, &mut old_port);

        (old_host, old_port)
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

    fn flush(&self, buffer: &DmxBuffer) {
        profiling::scope!("ArtnetOutput::flush");
        let broadcast_addr = match self.parse_addr() {
            Ok(addr) => addr,
            Err(err) => {
                tracing::error!("Unable to parse artnet address: {:?}", err);
                return;
            }
        };

        for (universe, buffer) in buffer.iter() {
            let msg = artnet_protocol::Output {
                port_address: artnet_protocol::PortAddress::try_from(universe - 1).unwrap(),
                data: buffer.into_iter().collect::<Vec<_>>().into(),
                ..artnet_protocol::Output::default()
            };

            let msg = artnet_protocol::ArtCommand::Output(msg)
                .write_to_buffer()
                .unwrap();

            if let Err(err) = self.socket.send_to(&msg, broadcast_addr) {
                tracing::error!("Unable to send to artnet server {:?}", err);
            }else {
                self.transmission_sender.sent_packet();
            }
        }
    }
}
