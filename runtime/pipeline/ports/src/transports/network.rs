use crate::api::*;
use crate::swap::{Swap, SwapReadGuard};
use serde::de::DeserializeOwned;
use serde::Serialize;
use std::net::{ToSocketAddrs, UdpSocket};
use std::thread;

pub struct NetworkReceiver<Item>
where
    Item: PortValue + DeserializeOwned,
{
    swap: Swap<Item>,
}

impl<Item: PortValue + DeserializeOwned> NetworkReceiver<Item>
where
    Item: 'static,
{
    /// Creates a new receiver listening on the returned port
    pub fn new() -> anyhow::Result<(Self, u16)> {
        let socket = UdpSocket::bind(("0.0.0.0", 0))?;
        let addr = socket.local_addr()?;
        let swap = Swap::new();

        let recv = NetworkReceiver { swap: swap.clone() };

        thread::spawn(move || {
            let mut buffer = [0u8; 2048];
            loop {
                let length = socket.recv(&mut buffer).unwrap();
                let payload = bincode::deserialize::<Item>(&buffer[..length]).unwrap();

                swap.store(payload);
            }
        });

        Ok((recv, addr.port()))
    }
}

impl<'a, Item: 'a> NodePortReceiver<'a, Item> for NetworkReceiver<Item>
where
    Item: PortValue + DeserializeOwned,
{
    type Guard = SwapReadGuard<'a, Item>;

    fn recv(&'a self) -> Option<Self::Guard> {
        self.swap.get()
    }
}

pub struct NetworkSender {
    socket: UdpSocket,
}

impl NetworkSender {
    /// Creates a new sender pushing events to the given address
    pub fn new<A: ToSocketAddrs>(addr: A) -> anyhow::Result<Self> {
        let socket = UdpSocket::bind(("0.0.0.0", 0))?;
        socket.connect(addr)?;

        Ok(NetworkSender { socket })
    }
}

impl<Item> NodePortSender<Item> for NetworkSender
where
    Item: PortValue + Serialize,
{
    fn send(&self, port: Item) -> anyhow::Result<()> {
        let buffer = bincode::serialize(&port).unwrap();
        let expected_bytes = buffer.len();
        let bytes = self.socket.send(&buffer).unwrap();
        assert_eq!(expected_bytes, bytes);
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::ops::Deref;
    use std::time::{Duration, Instant};

    #[test]
    fn it_should_connect() {
        let (_receiver, port) = NetworkReceiver::<u8>::new().unwrap();
        let _sender = NetworkSender::new(("localhost", port)).unwrap();
    }

    #[test]
    fn it_should_transmit() {
        let (receiver, port) = NetworkReceiver::<u8>::new().unwrap();
        let sender = NetworkSender::new(("localhost", port)).unwrap();
        let payload = 255u8;
        sender.send(payload).unwrap();

        let mut result = None;
        let start = Instant::now();
        while Instant::now().duration_since(start) < Duration::from_secs(5) {
            if let Some(guard) = receiver.recv() {
                result = Some(guard);
                break;
            }
        }

        assert_eq!(result.unwrap().deref(), &payload);
    }
}
