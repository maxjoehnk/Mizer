use std::any::{type_name, Any};
use std::cell::RefCell;
use std::collections::HashMap;
use std::ops::Deref;

use mizer_node::{NodePath, PortMetadata};
use mizer_ports::memory::{MemoryReceiver, MemorySender};
use mizer_ports::{NodePortReceiver, PortId, PortValue};

#[derive(Default, Debug)]
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

    pub fn get(&self, port: &PortId) -> Option<&(Box<dyn Any>, PortMetadata)> {
        self.0.get(port)
    }
}

#[derive(Default, Debug)]
pub struct NodeReceivers(HashMap<PortId, AnyPortReceiver>);

impl NodeReceivers {
    pub fn add<T: PortValue + 'static>(
        &mut self,
        port_id: PortId,
        sender: MemoryReceiver<T>,
        source: (NodePath, PortId),
        source_meta: PortMetadata,
    ) {
        if let Some(receiver) = self.0.get_mut(&port_id) {
            assert_eq!(
                receiver.metadata.port_type, source_meta.port_type,
                "port type missmatch"
            );
            receiver.add_transport(sender, source);
        } else {
            log::warn!("trying to add transport to unknown port '{}'", port_id);
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

    pub fn remove<V: PortValue + 'static>(&mut self, port_id: &PortId, source: (NodePath, PortId)) {
        if let Some(receiver) = self.0.get_mut(port_id) {
            receiver.remove_transport::<V>(source);
        }
    }
}

#[derive(Debug)]
pub struct AnyPortReceiver {
    pub metadata: PortMetadata,
    pub(crate) port: AnyPortReceiverPort,
}

type SourcePort = (NodePath, PortId);

#[derive(Debug)]
pub enum AnyPortReceiverPort {
    Single(Box<dyn Any>),
    Multiple(RefCell<Vec<Box<dyn Any>>>),
}

impl AnyPortReceiver {
    pub fn new<V: PortValue + 'static>(meta: PortMetadata) -> Self {
        let recv = NodeReceiver::<V>::default();
        let port = if meta.multiple == Some(true) {
            AnyPortReceiverPort::Multiple(Default::default())
        } else {
            AnyPortReceiverPort::Single(Box::new(recv))
        };

        AnyPortReceiver {
            metadata: meta,
            port,
        }
    }

    pub fn read<V: PortValue + 'static>(&self) -> Option<V> {
        self.receiver::<V>().and_then(|recv| recv.read())
    }

    pub fn read_changes<V: PortValue + 'static>(&self) -> Option<V> {
        self.receiver::<V>().and_then(|recv| {
            let value = recv.read();
            let mut last_value = recv.last_value.borrow_mut();
            if last_value.deref() == &value {
                return None;
            }
            if let Some(value) = value {
                *last_value = Some(value.clone());
                Some(value)
            } else {
                None
            }
        })
    }

    pub fn read_multiple<V: PortValue + 'static>(&self) -> Vec<Option<V>> {
        if let AnyPortReceiverPort::Multiple(ports) = &self.port {
            let ports = ports.borrow();
            let mut values = Vec::new();
            for port in ports.iter() {
                let recv: &NodeReceiver<V> = port.downcast_ref().unwrap();
                let value = recv.read();

                values.push(value);
            }
            values
        } else {
            Default::default()
        }
    }

    pub fn read_multiple_changes<V: PortValue + 'static>(&self) -> Vec<Option<V>> {
        if let AnyPortReceiverPort::Multiple(ports) = &self.port {
            let ports = ports.borrow();
            let mut values = Vec::new();
            for port in ports.iter() {
                let recv: &NodeReceiver<V> = port.downcast_ref().unwrap();
                let value = recv.read();

                let mut last_value = recv.last_value.borrow_mut();
                let value = if last_value.deref() == &value {
                    None
                } else if let Some(value) = value {
                    *last_value = Some(value.clone());
                    Some(value)
                } else {
                    None
                };
                values.push(value);
            }
            values
        } else {
            Default::default()
        }
    }

    pub fn add_transport<V: PortValue + 'static>(
        &self,
        transport: MemoryReceiver<V>,
        source: SourcePort,
    ) {
        match self.metadata.multiple {
            Some(true) => {
                self.push_receiver(transport, source);
            }
            _ => {
                if let Some(receiver) = self.receiver::<V>() {
                    let mut transport_store = receiver.transport.borrow_mut();
                    transport_store.replace(transport);
                    let mut source_store = receiver.source.borrow_mut();
                    source_store.replace(source);
                } else {
                    tracing::error!(
                        "Tried to add transport with invalid port value: {}",
                        type_name::<V>()
                    );
                    panic!(
                        "Tried to add transport with invalid port value: {}",
                        type_name::<V>()
                    );
                }
            }
        }
    }

    pub fn remove_transport<V: PortValue + 'static>(&self, source: SourcePort) {
        match self.metadata.multiple {
            Some(true) => {
                if let AnyPortReceiverPort::Multiple(port) = &self.port {
                    let mut ports = port.borrow_mut();
                    let source = Some(source);
                    if let Some(position) = ports.iter().position(|port| {
                        let recv: &NodeReceiver<V> = port.downcast_ref().unwrap();
                        let recv_source = recv.source.borrow();

                        recv_source.deref() == &source
                    }) {
                        ports.remove(position);
                    } else {
                        tracing::error!(
                            "Tried to remove transport which was not added before: {}",
                            type_name::<V>()
                        );
                    }
                }
            }
            _ => {
                if let Some(receiver) = self.receiver::<V>() {
                    let source_store = receiver.source.borrow_mut();
                    if Some(source) == source_store.clone() {
                        tracing::debug!("Removing single transport");
                        let mut transport_store = receiver.transport.borrow_mut();
                        transport_store.take();
                    } else {
                        tracing::error!(
                            "Tried to remove transport which was not added before: {}",
                            type_name::<V>()
                        );
                    }
                } else {
                    tracing::error!(
                        "Tried to remove transport with invalid port value: {}",
                        type_name::<V>()
                    );
                }
            }
        }
    }

    fn push_receiver<V: PortValue + 'static>(
        &self,
        transport: MemoryReceiver<V>,
        source: SourcePort,
    ) {
        if let AnyPortReceiverPort::Multiple(port) = &self.port {
            let recv = NodeReceiver::<V>::default();
            recv.source.replace(Some(source));
            recv.transport.replace(Some(transport));
            let mut port = port.borrow_mut();
            port.push(Box::new(recv));
        }
    }

    pub fn set_value<V: PortValue + 'static>(&self, value: V) {
        let receiver = self
            .receiver::<V>()
            .expect("Tried to add transport with invalid port value");
        let mut value_store = receiver.value.borrow_mut();
        value_store.replace(value);
    }

    fn receiver<V: PortValue + 'static>(&self) -> Option<&NodeReceiver<V>> {
        match &self.port {
            AnyPortReceiverPort::Single(port) => port.downcast_ref(),
            _ => None,
        }
    }
}

pub struct NodeReceiver<V: PortValue + 'static> {
    /// Used for communication inside the pipeline
    transport: RefCell<Option<MemoryReceiver<V>>>,
    /// Used to set values from outside the pipeline
    value: RefCell<Option<V>>,
    last_value: RefCell<Option<V>>,
    source: RefCell<Option<SourcePort>>,
}

impl<V: PortValue + 'static> Default for NodeReceiver<V> {
    fn default() -> Self {
        Self {
            transport: Default::default(),
            value: Default::default(),
            last_value: Default::default(),
            source: Default::default(),
        }
    }
}

impl<V: PortValue + 'static> NodeReceiver<V> {
    fn read(&self) -> Option<V> {
        let mut value_store = self.value.borrow_mut();
        let value = value_store.take();

        value.or_else(|| {
            self.transport
                .borrow()
                .as_ref()
                // TODO: return reference to data
                .and_then(|port| port.recv().and_then(|value| value.clone()))
        })
    }
}
