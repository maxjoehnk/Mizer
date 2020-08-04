use std::{net::ToSocketAddrs, net::UdpSocket};
use std::collections::HashMap;

use mizer_node_api::*;
use std::convert::TryFrom;

pub struct ArtnetOutputNode {
    socket: UdpSocket,
    host: String,
    port: u16,
    buffer: HashMap<u16, [u8; 512]>,
    channels: Vec<DmxChannel>,
}

impl ArtnetOutputNode {
    pub fn new<S: Into<String>>(host: S, port: Option<u16>) -> Self {
        let host = host.into();
        let port = port.unwrap_or(6454);
        log::trace!("New ArtnetOutputNode({}:{})", &host, port);

        let socket = UdpSocket::bind(("127.0.0.1", 0)).unwrap();

        socket.set_broadcast(true).unwrap();

        ArtnetOutputNode {
            socket,
            host,
            port,
            buffer: HashMap::new(),
            channels: Vec::new(),
        }
    }

    fn recv(&mut self) {
        for channel in &self.channels {
            loop {
                match channel.recv() {
                    Ok(Some(value)) => {
                        if !self.buffer.contains_key(&channel.universe) {
                            self.buffer.insert(channel.universe, [0; 512]);
                        }
                        let buffer = self.buffer.get_mut(&channel.universe).unwrap();
                        buffer[channel.channel as usize] = value;
                    },
                    Ok(None) => break,
                    Err(e) => println!("{:?}", e)
                }
            }
        }
    }

    fn flush(&mut self) {
        let broadcast_addr = (self.host.as_str(), self.port)
            .to_socket_addrs()
            .unwrap()
            .next()
            .unwrap();

        for (universe, buffer) in self.buffer.iter() {
            let msg = artnet_protocol::Output {
                port_address: artnet_protocol::PortAddress::try_from(*universe).unwrap(),
                data: buffer.to_vec().into(),
                ..artnet_protocol::Output::default()
            };

            let msg = artnet_protocol::ArtCommand::Output(msg)
                .into_buffer()
                .unwrap();

            self.socket
                .send_to(&msg, broadcast_addr)
                .unwrap();
        }
    }
}

impl InputNode for ArtnetOutputNode {
    fn connect_dmx_input(&mut self, input: &str, channels: &[DmxChannel]) -> ConnectionResult {
        if input == "dmx" {
            for channel in channels {
                self.channels.push(channel.clone());
            }
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl OutputNode for ArtnetOutputNode {}

impl ProcessingNode for ArtnetOutputNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("ArtnetOutputNode")
            .with_inputs(vec![NodeInput::dmx("dmx")])
    }

    fn process(&mut self) {
        self.recv();
        self.flush();
    }
}
