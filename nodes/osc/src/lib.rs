use std::collections::HashMap;
use std::net::{SocketAddrV4, UdpSocket};
use std::sync::Mutex;
use std::thread;

use crossbeam_channel::{Receiver, unbounded};
use lazy_static::lazy_static;
use rosc::{OscMessage, OscPacket, OscType};

use mizer_node_api::*;

lazy_static! {
    static ref OSC_THREADS: Mutex<HashMap<SocketAddrV4, Receiver<OscPacket>>> = Mutex::new(HashMap::new());
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
                },
                Err(e) => println!("{:?}", e)
            }
        }
    });
    {
        let mut threads = OSC_THREADS.lock().unwrap();
        threads.insert(addr, rx.clone());
    }
    rx
}

pub struct OscInputNode {
    pub host: String,
    pub port: u16,
    pub path: String,
    pub rx: Receiver<OscPacket>,
    numeric_connections: Vec<NumericSender>,
}

impl OscInputNode {
    pub fn new<S: Into<String>>(host: Option<String>, port: u16, path: S) -> Self {
        let host = host.unwrap_or_else(|| "0.0.0.0".into());
        log::trace!("New OscInputNode({}:{})", &host, port);
        let addr = host.parse().unwrap();
        let addr = SocketAddrV4::new(addr, port);
        let rx = {
            let threads = OSC_THREADS.lock().unwrap();
            threads.get(&addr).cloned()
        };
        let rx = rx.unwrap_or_else(|| spawn_osc_thread(addr));
        OscInputNode {
            host,
            port,
            path: path.into(),
            rx,
            numeric_connections: Vec::new(),
        }
    }

    fn handle_packet(&mut self, packet: OscPacket) {
        match packet {
            OscPacket::Message(msg) => {
                self.handle_msg(msg);
            },
            OscPacket::Bundle(bundle) => {
                for packet in bundle.content {
                    self.handle_packet(packet);
                }
            }
        }
    }

    fn handle_msg(&mut self, msg: OscMessage) {
        log::trace!("{:?}", msg);
        if msg.addr == self.path {
            match &msg.args[0] {
                OscType::Float(float) => {
                    for tx in &self.numeric_connections {
                        tx.send(*float as f64);
                    }
                },
                _ => {}
            }
        }
    }
}

impl ProcessingNode for OscInputNode {
    fn process(&mut self) {
        while let Ok(packet) = self.rx.try_recv() {
            self.handle_packet(packet);
        }
    }
}

impl InputNode for OscInputNode {}

impl OutputNode for OscInputNode {
    fn connect_to_numeric_input(&mut self, input: &mut impl InputNode) {
        let (tx, channel) = NumericChannel::new();
        input.connect_numeric_input(channel);
        self.numeric_connections.push(tx);
    }
}
