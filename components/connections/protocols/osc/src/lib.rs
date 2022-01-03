use std::collections::HashMap;
use std::net::{SocketAddrV4, UdpSocket};
use std::sync::{Arc, Mutex, RwLock};
use std::thread;

use crossbeam_channel::{unbounded, Receiver, Sender};
use event_feed::{Feed, Reader};
use lazy_static::lazy_static;
pub use rosc::{OscColor, OscMessage, OscPacket, OscType};

#[derive(Clone)]
#[repr(transparent)]
struct OscInputStream(Arc<RwLock<Feed<OscPacket>>>);

impl OscInputStream {
    fn new() -> Self {
        let feed = Feed::new();
        let feed = Arc::new(RwLock::new(feed));

        Self(feed)
    }

    fn send(&self, msg: OscPacket) -> anyhow::Result<()> {
        let feed = self.0.read().map_err(|err| anyhow::anyhow!("OscInputStream RWLock is poisoned"))?;
        feed.send(msg);

        Ok(())
    }

    fn subscribe(&self) -> anyhow::Result<OscInputSubscriber> {
        let mut feed = self.0.write().map_err(|err| anyhow::anyhow!("OscInputStream RWLock is poisoned"))?;
        let reader = feed.add_reader();

        Ok(OscInputSubscriber(reader))
    }
}

#[derive(Clone)]
#[repr(transparent)]
struct OscInputSubscriber(Arc<Reader<OscPacket>>);

impl OscInputSubscriber {
    fn read(&self) -> Option<OscPacket> {
        self.0.read().next()
    }
}

lazy_static! {
    static ref OSC_INPUT_THREADS: Mutex<HashMap<SocketAddrV4, OscInputStream>> =
        Mutex::new(HashMap::new());
    static ref OSC_OUTPUT_THREADS: Mutex<HashMap<SocketAddrV4, Sender<OscPacket>>> =
        Mutex::new(HashMap::new());
}

fn spawn_osc_input_thread(addr: SocketAddrV4) -> OscInputStream {
    let feed = OscInputStream::new();
    let tx = feed.clone();
    thread::spawn(move || {
        let socket = UdpSocket::bind(addr).unwrap();
        let mut buffer = [0u8; rosc::decoder::MTU];
        loop {
            match socket.recv_from(&mut buffer) {
                Ok((size, _)) => {
                    match rosc::decoder::decode(&buffer[..size]) {
                        Ok(msg) => {
                            log::trace!("Received osc packet {:?}", msg);
                            tx.send(msg);
                        },
                        Err(err) => {
                            log::error!("Error decoding osc packet: {:?}", err);
                        }
                    }
                }
                Err(e) => println!("Error receiving osc packet: {:?}", e),
            }
        }
    });
    {
        let mut threads = OSC_INPUT_THREADS.lock().unwrap();
        threads.insert(addr, feed.clone());
    }
    feed
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
    subscriber: OscInputSubscriber,
}

impl OscInput {
    pub fn new(host: &str, port: u16) -> anyhow::Result<Self> {
        let addr = host.parse()?;
        let addr = SocketAddrV4::new(addr, port);
        let rx = {
            let threads = OSC_INPUT_THREADS.lock().unwrap();
            threads.get(&addr).cloned()
        };
        let mut feed = rx.unwrap_or_else(|| spawn_osc_input_thread(addr));
        let subscriber = feed.subscribe()?;
        Ok(Self { subscriber })
    }

    pub fn try_recv(&self) -> Option<OscPacket> {
        self.subscriber.read()
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
