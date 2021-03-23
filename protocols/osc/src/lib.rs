use std::collections::HashMap;
use std::net::{SocketAddrV4, UdpSocket};
use std::sync::Mutex;
use std::thread;

use crossbeam_channel::{unbounded, Receiver};
use lazy_static::lazy_static;
pub use rosc::{OscMessage, OscPacket, OscType};

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
                    if let Err(error) = tx.send(msg) {
                        log::error!("Error sending osc packet to handler: {:?}", error);
                    }
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

pub struct OscInput {
    rx: Receiver<OscPacket>,
}

impl OscInput {
    pub fn new(host: &str, port: u16) -> anyhow::Result<Self> {
        let addr = host.parse()?;
        let addr = SocketAddrV4::new(addr, port);
        let rx = {
            let threads = OSC_THREADS.lock().unwrap();
            threads.get(&addr).cloned()
        };
        let rx = rx.unwrap_or_else(|| spawn_osc_thread(addr));
        Ok(Self { rx })
    }

    pub fn try_recv(&self) -> Option<OscPacket> {
        self.rx.try_recv().ok()
    }
}
