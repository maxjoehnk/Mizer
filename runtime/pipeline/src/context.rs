use mizer_clock::ClockFrame;
use mizer_node::*;
use mizer_ports::memory::MemorySender;
use mizer_ports::{NodePortSender, PortId, PortValue};
use mizer_processing::Injector;

use crate::ports::{AnyPortReceiverPort, NodeReceivers, NodeSenders};
use pinboard::NonEmptyPinboard;
use ringbuffer::{ConstGenericRingBuffer, RingBufferExt, RingBufferWrite};
use std::cell::RefCell;
use std::fmt::{Debug, Formatter};
use std::sync::Arc;

pub struct PipelineContext<'a> {
    pub(crate) frame: ClockFrame,
    pub(crate) senders: Option<&'a NodeSenders>,
    pub(crate) receivers: Option<&'a NodeReceivers>,
    pub(crate) injector: &'a Injector,
    pub(crate) preview: RefCell<&'a mut NodePreviewState>,
}

impl<'a> Debug for PipelineContext<'a> {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("PipelineContext")
            .field("frame", &self.frame)
            .field("senders", &self.senders)
            .field("receivers", &self.receivers)
            .finish()
    }
}

#[derive(Debug)]
pub enum NodePreviewState {
    History(
        ConstGenericRingBuffer<f64, HISTORY_PREVIEW_SIZE>,
        Arc<NonEmptyPinboard<Vec<f64>>>,
    ),
    None,
}

impl NodePreviewState {
    fn push_history_value(&mut self, value: f64) {
        if let Self::History(history, history_snapshot) = self {
            history.push(value);
            history_snapshot.set(history.to_vec());
        }
    }
}

impl<'a> NodeContext for PipelineContext<'a> {
    fn clock(&self) -> ClockFrame {
        self.frame
    }

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V) {
        let port = port.into();
        let dbg_msg = format!("Trying to write to non existent port {}", &port);
        if let Some((port, _)) = self.senders.and_then(|senders| senders.get(port)) {
            let port = port
                .downcast_ref::<MemorySender<V>>()
                .expect("can't downcast sender to proper type");
            if let Err(e) = port.send(value) {
                log::error!("Sending data via port failed: {:?}", e);
            }
        } else {
            log::trace!("{}", dbg_msg);
        }
    }

    fn read_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        let port = port.into();
        self.receivers
            .and_then(|receivers| receivers.get(&port))
            .and_then(|receiver| receiver.read())
    }

    fn read_port_changes<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        let port = port.into();
        self.receivers
            .and_then(|receivers| receivers.get(&port))
            .and_then(|receiver| receiver.read_changes())
    }

    fn read_ports<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Vec<Option<V>> {
        let port = port.into();
        self.receivers
            .and_then(|receivers| receivers.get(&port))
            .map(|receiver| receiver.read_multiple())
            .unwrap_or_default()
    }

    // TODO: return as ref again?
    fn input_port<P: Into<PortId>>(&self, port: P) -> PortMetadata {
        let port = port.into();
        self.receivers
            .and_then(|ports| ports.get(&port))
            .map(|recv| recv.metadata)
            .unwrap()
    }

    fn output_port<P: Into<PortId>>(&self, port: P) -> &PortMetadata {
        let port = port.into();
        let (_, metadata) = self.senders.and_then(|ports| ports.get(port)).unwrap();

        metadata
    }

    fn input_port_count<P: Into<PortId>>(&self, port: P) -> usize {
        let port = port.into();
        self.receivers
            .and_then(|recv| recv.get(&port))
            .map(|recv| match &recv.port {
                AnyPortReceiverPort::Single(_) => 1,
                AnyPortReceiverPort::Multiple(ports) => ports.borrow().len(),
            })
            .unwrap_or_default()
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

impl<'a> PreviewContext for PipelineContext<'a> {
    fn push_history_value(&self, value: f64) {
        self.preview.borrow_mut().push_history_value(value);
    }
}
