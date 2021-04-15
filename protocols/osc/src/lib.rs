use std::collections::HashMap;
use std::net::{SocketAddrV4, UdpSocket};
use std::sync::Mutex;
use std::thread;

use crossbeam_channel::{unbounded, Receiver, Sender};
use lazy_static::lazy_static;
pub use rosc::{OscMessage, OscPacket, OscType, OscColor};

lazy_static! {
    static ref OSC_INPUT_THREADS: Mutex<HashMap<SocketAddrV4, Receiver<OscPacket>>> =
        Mutex::new(HashMap::new());
    static ref OSC_OUTPUT_THREADS: Mutex<HashMap<SocketAddrV4, Sender<OscPacket>>> =
        Mutex::new(HashMap::new());
}

fn spawn_osc_input_thread(addr: SocketAddrV4) -> Receiver<OscPacket> {
    let (tx, rx) = unbounded();
    thread::spawn(move || {
        let socket = UdpSocket::bind(addr).unwrap();
        let mut buffer = [0u8; rosc::decoder::MTU];
        loop {
            match socket.recv_from(&mut buffer) {
                Ok((size, _)) => {
                    let msg = rosc::decoder::decode(&buffer[..size]).unwrap();
                    if let Err(error) = tx.send(msg) {
                        log::error!("Error sending osc packet to handler: {:?}", error);
                    }
                }
                Err(e) => println!("{:?}", e),
            }
        }
    });
    {
        let mut threads = OSC_INPUT_THREADS.lock().unwrap();
        threads.insert(addr, rx.clone());
    }
    rx
}

fn spawn_osc_output_thread(addr: SocketAddrV4) -> Sender<OscPacket> {
    let (tx, rx) = unbounded();
    thread::spawn(move || {
        let socket = UdpSocket::bind("0.0.0.0:0").expect("can't create udp socket");
        socket
            .set_broadcast(true)
            .expect("Can't enable broadcast support");
        loop {
            match rx.recv() {
                Ok(msg) => {
                    let packet = rosc::encoder::encode(&msg).unwrap();
                    socket.send_to(&packet, addr).unwrap();
                }
                Err(e) => {
                    log::error!("Error transmitting osc packet: {:?}", e);
                }
            }
        }
    });
    {
        let mut threads = OSC_OUTPUT_THREADS.lock().unwrap();
        threads.insert(addr, tx.clone());
    }
    tx
}

pub struct OscInput {
    rx: Receiver<OscPacket>,
}

impl OscInput {
    pub fn new(host: &str, port: u16) -> anyhow::Result<Self> {
        let addr = host.parse()?;
        let addr = SocketAddrV4::new(addr, port);
        let rx = {
            let threads = OSC_INPUT_THREADS.lock().unwrap();
            threads.get(&addr).cloned()
        };
        let rx = rx.unwrap_or_else(|| spawn_osc_input_thread(addr));
        Ok(Self { rx })
    }

    pub fn try_recv(&self) -> Option<OscPacket> {
        self.rx.try_recv().ok()
    }
}

pub struct OscOutput {
    tx: Sender<OscPacket>,
}

impl OscOutput {
    pub fn new(host: &str, port: u16) -> anyhow::Result<Self> {
        let addr = host.parse()?;
        let addr = SocketAddrV4::new(addr, port);
        let tx = {
            let threads = OSC_OUTPUT_THREADS.lock().unwrap();
            threads.get(&addr).cloned()
        };
        let tx = tx.unwrap_or_else(|| spawn_osc_output_thread(addr));
        Ok(Self { tx })
    }

    pub fn send(&self, packet: OscPacket) -> anyhow::Result<()> {
        self.tx.send(packet)?;
        Ok(())
    }
}
