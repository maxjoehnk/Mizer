use std::collections::HashMap;
use std::net::{SocketAddrV4, UdpSocket};
use std::sync::Mutex;
use std::thread;

use crossbeam_channel::{unbounded, Receiver};
use lazy_static::lazy_static;
use rosc::{OscMessage, OscPacket, OscType};
use serde::{Deserialize, Serialize};

use mizer_node::*;

lazy_static! {
    static ref OSC_THREADS: Mutex<HashMap<SocketAddrV4, Receiver<OscPacket>>> =
        Mutex::new(HashMap::new());
}

fn spawn_osc_thread(addr: SocketAddrV4) -> Receiver<OscPacket> {
    let (tx, rx) = unbounded();
    thread::spawn(move || {
        let socket = UdpSocket::bind(addr).unwrap();
        let mut buffer = [0u8; rosc::decoder::MTU];
        loop {
            match socket.recv_from(&mut buffer) {
                Ok((size, _)) => {
                    let msg = rosc::decoder::decode(&buffer[..size]).unwrap();
                    tx.send(msg);
                }
                Err(e) => println!("{:?}", e),
            }
        }
    });
    {
        let mut threads = OSC_THREADS.lock().unwrap();
        threads.insert(addr, rx.clone());
    }
    rx
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct OscInputNode {
    #[serde(default = "default_host")]
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    pub path: String,
}

fn default_host() -> String {
    "0.0.0.0".into()
}

fn default_port() -> u16 {
    6000
}

pub struct OscInputState {
    pub rx: Receiver<OscPacket>,
}

impl PipelineNode for OscInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "OscInputNode".into(),
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        (port == "value").then(|| PortMetadata {
            port_type: PortType::Single,
            direction: PortDirection::Output,
            ..Default::default()
        })
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![("value".into(), PortMetadata {
            port_type: PortType::Single,
            direction: PortDirection::Output,
            ..Default::default()
        })]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OscInput
    }
}

impl ProcessingNode for OscInputNode {
    type State = OscInputState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        while let Ok(packet) = state.rx.try_recv() {
            self.handle_packet(packet, context);
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        OscInputState::new(&self.host, self.port)
    }
}

impl OscInputNode {
    fn handle_packet(&self, packet: OscPacket, context: &impl NodeContext) {
        match packet {
            OscPacket::Message(msg) => {
                self.handle_msg(msg, context);
            }
            OscPacket::Bundle(bundle) => {
                for packet in bundle.content {
                    self.handle_packet(packet, context);
                }
            }
        }
    }

    fn handle_msg(&self, msg: OscMessage, context: &impl NodeContext) {
        log::trace!("{:?}", msg);
        if msg.addr == self.path {
            match &msg.args[0] {
                OscType::Float(float) => {
                    let value = *float as f64;
                    context.write_port("value", value);
                }
                _ => {}
            }
        }
    }
}

impl OscInputState {
    fn new(host: &str, port: u16) -> Self {
        let addr = host.parse().unwrap();
        let addr = SocketAddrV4::new(addr, port);
        let rx = {
            let threads = OSC_THREADS.lock().unwrap();
            threads.get(&addr).cloned()
        };
        let rx = rx.unwrap_or_else(|| spawn_osc_thread(addr));
        Self { rx }
    }
}
