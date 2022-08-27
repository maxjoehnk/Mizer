use self::clock::ClockFunction;
use self::read_port::ReadPortFunction;
use self::write_port::WritePortFunction;
use crate::{ClockFrame, NodeContext, PortId, PortMetadata, PreviewContext};
use mizer_ports::PortValue;
use std::cell::RefCell;

mod clock;
mod read_port;
mod write_port;

#[derive(Default)]
pub struct NodeContextMock {
    write_port_fn: WritePortFunction,
    read_port_fn: ReadPortFunction,
    clock_fn: ClockFunction,
    pub history: RefCell<Vec<f64>>,
}

impl NodeContextMock {
    pub fn new() -> Self {
        Self::default()
    }
}

impl NodeContext for NodeContextMock {
    fn clock(&self) -> ClockFrame {
        self.clock_fn.call()
    }

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V) {
        self.write_port_fn.call(port, value)
    }

    fn read_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        self.read_port_fn.call(port)
    }

    fn read_port_changes<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        self.read_port_fn.call(port)
    }

    fn read_edge<P: Into<PortId>>(&self, port: P) -> Option<bool> {
        todo!()
    }

    fn read_ports<P: Into<PortId>, V: PortValue + 'static>(&self, _: P) -> Vec<Option<V>> {
        todo!()
    }

    fn read_changed_ports<P: Into<PortId>, V: PortValue + 'static>(
        &self,
        port: P,
    ) -> Vec<Option<V>> {
        todo!()
    }

    fn input_port<P: Into<PortId>>(&self, _: P) -> PortMetadata {
        todo!()
    }

    fn output_port<P: Into<PortId>>(&self, _: P) -> &PortMetadata {
        todo!()
    }

    fn input_port_count<P: Into<PortId>>(&self, _: P) -> usize {
        todo!()
    }

    fn input_ports(&self) -> Vec<PortId> {
        todo!()
    }

    fn inject<T: 'static>(&self) -> Option<&T> {
        todo!()
    }
}

impl PreviewContext for NodeContextMock {
    fn push_history_value(&self, value: f64) {
        self.history.borrow_mut().push(value);
    }
}
