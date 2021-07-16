use std::cell::{Ref, RefCell};
use std::ops::Deref;
use std::rc::Rc;

use crate::api::*;

pub fn channel<T: Clone + Default>() -> (MemorySender<T>, MemoryReceiver<T>) {
    let swap = Rc::new(RefCell::new(T::default()));
    let sender = MemorySender { cell: swap.clone() };
    let receiver = MemoryReceiver { cell: swap };

    (sender, receiver)
}

pub struct MemorySender<Item> {
    cell: Rc<RefCell<Item>>,
}

impl<Item> MemorySender<Item> {
    pub fn add_destination(&self) -> MemoryReceiver<Item> {
        let cell = self.cell.clone();

        MemoryReceiver { cell }
    }
}

impl<Item> NodePortSender<Item> for MemorySender<Item>
where
    Item: PortValue,
{
    fn send(&self, value: Item) -> anyhow::Result<()> {
        *self.cell.borrow_mut() = value;
        Ok(())
    }
}

#[derive(Clone)]
pub struct MemoryReceiver<T> {
    cell: Rc<RefCell<T>>,
}

impl<'a, Item> NodePortReceiver<'a, Item> for MemoryReceiver<Item>
where
    Item: PortValue + 'a,
{
    type Guard = Ref<'a, Item>;

    fn recv(&'a self) -> Option<Self::Guard> {
        Some(self.cell.deref().borrow())
    }
}

impl<'a, Item: PortValue> ReceiverGuard<Item> for Ref<'a, Item> {}

#[cfg(test)]
mod tests {
    use std::ops::Deref;

    use super::*;

    #[test]
    fn it_should_transmit() {
        let (sender, receiver) = channel();
        let payload = 255u8;
        sender.send(payload).unwrap();

        let result = receiver.recv();

        assert_eq!(result.unwrap().deref(), &payload);
    }
}
