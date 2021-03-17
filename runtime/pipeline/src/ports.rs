use mizer_node::PortMetadata;
use mizer_ports::memory::{MemoryReceiver, MemorySender};
use mizer_ports::{PortId, PortValue, NodePortReceiver};
use std::any::Any;
use std::collections::HashMap;
use std::cell::RefCell;

#[derive(Default)]
pub struct NodeSenders(HashMap<PortId, (Box<dyn Any>, PortMetadata)>);

impl NodeSenders {
    pub fn add<T: PortValue + 'static>(
        &mut self,
        port_id: PortId,
        sender: MemorySender<T>,
        target_meta: PortMetadata,
    ) {
        let tx = Box::new(sender);
        self.0.insert(port_id, (tx, target_meta));
    }

    pub fn get(&self, port: PortId) -> Option<&(Box<dyn Any>, PortMetadata)> {
        self.0.get(&port)
    }
}

#[derive(Default)]
pub struct NodeReceivers(HashMap<PortId, AnyPortReceiver>);

impl NodeReceivers {
    pub fn add<T: PortValue + 'static>(
        &mut self,
        port_id: PortId,
        sender: MemoryReceiver<T>,
        source_meta: PortMetadata,
    ) {
        if let Some(receiver) = self.0.get_mut(&port_id) {
            assert_eq!(receiver.metadata.port_type, source_meta.port_type, "port type missmatch");
            receiver.set_transport(sender);
        }else {
            log::warn!("trying to add transport to unknown port");
        }
    }

    pub fn register<T: PortValue + 'static>(&mut self, port_id: PortId, source_meta: PortMetadata) {
        let receiver = AnyPortReceiver::new::<T>(source_meta);
        self.0.insert(port_id, receiver);
    }

    pub fn get(&self, port: &PortId) -> Option<&AnyPortReceiver> {
        self.0.get(port)
    }

    pub fn ports(&self) -> Vec<PortId> {
        self.0.keys().cloned().collect()
    }
}

pub struct AnyPortReceiver {
    pub metadata: PortMetadata,
    port: Box<dyn Any>,
}

impl AnyPortReceiver {
    pub fn new<V: PortValue + 'static>(meta: PortMetadata) -> Self {
        let recv = NodeReceiver::<V>::default();

        AnyPortReceiver {
            metadata: meta,
            port: Box::new(recv),
        }
    }

    pub fn read<V: PortValue + 'static>(&self) -> Option<V> {
        self.receiver::<V>()
            .and_then(|recv| {
                let mut value_store = recv.value.borrow_mut();
                let value = value_store.take();

                value.or_else(|| {
                    recv.transport.borrow().as_ref()
                        // TODO: return reference to data
                        .and_then(|port| port.recv().map(|value| value.clone()))
                })
            })
    }

    pub fn set_transport<V: PortValue + 'static>(&self, transport: MemoryReceiver<V>) {
        let receiver = self.receiver::<V>().expect("Tried to add transport with invalid port value");
        let mut transport_store = receiver.transport.borrow_mut();
        transport_store.replace(transport.into());
    }

    pub fn set_value<V: PortValue + 'static>(&self, value: V) {
        let receiver = self.receiver::<V>().expect("Tried to add transport with invalid port value");
        let mut value_store = receiver.value.borrow_mut();
        value_store.replace(value);
    }

    fn receiver<V: PortValue + 'static>(&self) -> Option<&NodeReceiver<V>> {
        self.port.downcast_ref()
    }
}

pub struct NodeReceiver<V: PortValue + 'static> {
    transport: RefCell<Option<MemoryReceiver<V>>>,
    value: RefCell<Option<V>>,
}

impl<V: PortValue + 'static> Default for NodeReceiver<V> {
    fn default() -> Self {
        NodeReceiver {
            transport: RefCell::new(None),
            value: RefCell::new(None),
        }
    }
}
