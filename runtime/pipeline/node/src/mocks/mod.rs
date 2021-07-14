use crate::{NodeContext, PreviewContext, ClockFrame, PortId, PortMetadata};
use mizer_ports::PortValue;
use std::any::Any;
use std::cell::RefCell;
use self::write_port::WritePortFunction;
use self::read_port::ReadPortFunction;
use self::clock::ClockFunction;

mod write_port;
mod read_port;
mod clock;

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

    fn read_ports<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Vec<Option<V>> {
        todo!()
    }

    fn input_port<P: Into<PortId>>(&self, port: P) -> PortMetadata {
        todo!()
    }

    fn output_port<P: Into<PortId>>(&self, port: P) -> &PortMetadata {
        todo!()
    }

    fn input_port_count<P: Into<PortId>>(&self, port: P) -> usize {
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
