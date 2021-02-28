use mizer_node::PortMetadata;
use mizer_ports::memory::{MemoryReceiver, MemorySender};
use mizer_ports::{PortId, PortValue};
use std::any::Any;
use std::collections::HashMap;

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
pub struct NodeReceivers(HashMap<PortId, (Box<dyn Any>, PortMetadata)>);

impl NodeReceivers {
    pub fn add<T: PortValue + 'static>(
        &mut self,
        port_id: PortId,
        sender: MemoryReceiver<T>,
        source_meta: PortMetadata,
    ) {
        let rx = Box::new(sender);
        self.0.insert(port_id, (rx, source_meta));
    }

    pub fn get(&self, port: PortId) -> Option<&(Box<dyn Any>, PortMetadata)> {
        self.0.get(&port)
    }

    pub fn ports(&self) -> Vec<PortId> {
        self.0.keys().cloned().collect()
    }
}
