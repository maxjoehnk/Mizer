use crate::api::*;
use crate::swap::{Swap, SwapReadGuard};
use serde::Serialize;
use std::fmt::Debug;

pub fn channel<T: Clone>() -> (MemorySender<T>, MemoryReceiver<T>) {
    let swap = Swap::new();
    let sender = MemorySender { swap: swap.clone() };
    let receiver = MemoryReceiver { swap };

    (sender, receiver)
}

pub struct MemorySender<T> {
    swap: Swap<T>
}

impl<Item> NodePortSender<Item> for MemorySender<NodePortPayload<Item>>
    where Item: Serialize + Debug + Clone + PartialEq {

    fn send(&self, value: NodePortPayload<Item>) -> anyhow::Result<()> {
        self.swap.store(value);
        Ok(())
    }
}

pub struct MemoryReceiver<T> {
    swap: Swap<T>
}

impl<'a, Item> NodePortReceiver<'a, Item> for MemoryReceiver<NodePortPayload<Item>>
    where Item: Serialize + Debug + Clone + PartialEq + 'a {
    type Guard = SwapReadGuard<'a, NodePortPayload<Item>>;

    fn recv(&'a self) -> Option<Self::Guard> {
        self.swap.get()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::api::*;
    use std::time::{Instant, Duration};
    use std::ops::Deref;

    #[test]
    fn it_should_transmit() {
        let (sender, receiver) = channel();
        let mut payload = NodePortPayload::new();
        payload.set_channel("channel".to_string(), 255u8);
        sender.send(payload.clone()).unwrap();

        let result = receiver.recv();

        assert_eq!(result.unwrap().deref(), &payload);
    }
}
