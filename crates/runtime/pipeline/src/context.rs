use mizer_clock::{Clock, ClockFrame, ClockState};
use mizer_node::*;
use mizer_ports::memory::MemorySender;
use mizer_ports::{NodePortSender, PortId, PortValue};
use mizer_processing::Injector;

use crate::ports::{AnyPortReceiverPort, NodeReceivers, NodeSenders};
use mizer_util::StructuredData;
use pinboard::NonEmptyPinboard;
use ringbuffer::{ConstGenericRingBuffer, RingBufferExt, RingBufferWrite};
use std::cell::RefCell;
use std::collections::HashMap;
use std::fmt::{Debug, Formatter};
use std::sync::Arc;

pub struct PipelineContext<'a> {
    pub(crate) frame: ClockFrame,
    pub(crate) senders: Option<&'a NodeSenders>,
    pub(crate) receivers: Option<&'a NodeReceivers>,
    pub(crate) injector: &'a Injector,
    pub(crate) preview: RefCell<&'a mut NodePreviewState>,
    pub(crate) clock: RefCell<&'a mut dyn Clock>,
    pub(crate) node_metadata: RefCell<&'a mut NodeMetadata>,
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

#[derive(Debug, Clone, Default)]
pub struct NodeMetadata {
    pub ports: HashMap<PortId, RuntimePortMetadata>,
}

#[derive(Debug, Clone, Default)]
pub struct RuntimePortMetadata {
    pub pushed_value: bool,
}

#[derive(Debug)]
pub enum NodePreviewState {
    History(
        ConstGenericRingBuffer<f64, HISTORY_PREVIEW_SIZE>,
        Arc<NonEmptyPinboard<Vec<f64>>>,
    ),
    Data(Arc<NonEmptyPinboard<Option<StructuredData>>>),
    None,
}

impl NodePreviewState {
    fn push_history_value(&mut self, value: f64) {
        if let Self::History(history, history_snapshot) = self {
            history.push(value);
            history_snapshot.set(history.to_vec());
        }
    }

    fn push_data_value(&mut self, value: StructuredData) {
        if let Self::Data(snapshot) = self {
            snapshot.set(Some(value));
        }
    }
}

impl<'a> NodeContext for PipelineContext<'a> {
    fn clock(&self) -> ClockFrame {
        self.frame
    }

    fn write_clock_tempo(&self, new_speed: f64) {
        let mut clock = self.clock.borrow_mut();
        let speed = clock.speed_mut();
        *speed = new_speed;
    }

    fn write_clock_state(&self, state: ClockState) {
        let mut clock = self.clock.borrow_mut();
        clock.set_state(state);
    }

    fn clock_state(&self) -> ClockState {
        self.clock.borrow().state()
    }

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V) {
        profiling::scope!("PipelineContext::write_port");
        let port = port.into();
        let dbg_msg = format!("Trying to write to non existent port {}", &port);
        let mut pushed_value = false;
        if let Some((port, _)) = self.senders.and_then(|senders| senders.get(&port)) {
            let port = port
                .downcast_ref::<MemorySender<V>>()
                .expect("can't downcast sender to proper type");
            pushed_value = true;
            if let Err(e) = port.send(value) {
                log::error!("Sending data via port failed: {:?}", e);
            }
        } else {
            log::trace!("{}", dbg_msg);
        }
        self.node_metadata
            .borrow_mut()
            .ports
            .insert(port, RuntimePortMetadata { pushed_value });
    }

    fn read_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        profiling::scope!("PipelineContext::read_port");
        let port = port.into();
        self.receivers
            .and_then(|receivers| receivers.get(&port))
            .and_then(|receiver| receiver.read())
    }

    fn read_port_changes<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        profiling::scope!("PipelineContext::read_port_changes");
        let port = port.into();
        self.receivers
            .and_then(|receivers| receivers.get(&port))
            .and_then(|receiver| receiver.read_changes())
    }

    fn read_ports<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Vec<Option<V>> {
        profiling::scope!("PipelineContext::read_ports");
        let port = port.into();
        self.receivers
            .and_then(|receivers| receivers.get(&port))
            .map(|receiver| receiver.read_multiple())
            .unwrap_or_default()
    }

    fn read_changed_ports<P: Into<PortId>, V: PortValue + 'static>(
        &self,
        port: P,
    ) -> Vec<Option<V>> {
        profiling::scope!("PipelineContext::read_changed_ports");
        let port = port.into();
        self.receivers
            .and_then(|receivers| receivers.get(&port))
            .map(|receiver| receiver.read_multiple_changes())
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

    fn output_port<P: Into<PortId>>(&self, port: P) -> Option<&PortMetadata> {
        let port = port.into();
        self.senders
            .and_then(|ports| ports.get(&port))
            .map(|(_, metadata)| metadata)
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
        profiling::scope!("PipelineContext::push_history_value");
        self.preview.borrow_mut().push_history_value(value);
    }

    fn write_data_preview(&self, data: StructuredData) {
        profiling::scope!("PipelineContext::write_data_preview");
        self.preview.borrow_mut().push_data_value(data);
    }
}
