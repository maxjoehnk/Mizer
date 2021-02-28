use mizer_node::*;
use mizer_clock::ClockFrame;
use mizer_ports::{PortId, NodePortSender, NodePortReceiver, PortValue};
use mizer_ports::memory::{MemorySender, MemoryReceiver};
use mizer_processing::Injector;

use crate::ports::{NodeSenders, NodeReceivers};

pub struct PipelineContext<'a> {
    pub(crate) frame: ClockFrame,
    pub(crate) senders: Option<&'a NodeSenders>,
    pub(crate) receivers: Option<&'a NodeReceivers>,
    pub(crate) injector: &'a Injector,
}

impl<'a> NodeContext for PipelineContext<'a> {
    fn clock(&self) -> ClockFrame {
        self.frame
    }

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V) {
        let port = port.into();
        let dbg_msg = format!("Trying to write to non existent port {}", &port);
        if let Some((port, _)) = self.senders.and_then(|senders| senders.get(port)) {
            let port = port.downcast_ref::<MemorySender<V>>().expect("can't downcast sender to proper type");
            if let Err(e) = port.send(value) {
                log::error!("Sending data via port failed: {:?}", e);
            }
        }else {
            log::debug!("{}", dbg_msg);
        }
    }

    fn read_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        let port = port.into();
        self.receivers
            .and_then(|receivers| receivers.get(port))
            .and_then(|(port, _)| port.downcast_ref::<MemoryReceiver<V>>())
            // TODO: return reference to data
            .and_then(|port| port.recv().map(|value| value.clone()))
    }

    fn input_port<P: Into<PortId>>(&self, port: P) -> &PortMetadata {
        let port = port.into();
        let (_, metadata) = self.receivers.and_then(|ports| ports.get(port)).unwrap();

        metadata
    }

    fn output_port<P: Into<PortId>>(&self, port: P) -> &PortMetadata {
        let port = port.into();
        let (_, metadata) = self.senders.and_then(|ports| ports.get(port)).unwrap();

        metadata
    }

    fn input_ports(&self) -> Vec<PortId> {
        self.receivers
            .map(|receivers| receivers.ports())
            .unwrap_or_default()
    }

    fn inject<T: 'static>(&self) -> Option<&T> {
        self.injector.get::<T>()
    }
}
