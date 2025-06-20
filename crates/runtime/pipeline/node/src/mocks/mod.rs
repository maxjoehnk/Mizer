use std::cell::RefCell;

use crate::{ClockFrame, NodeContext, NodePath, PortId, PortMetadata, PreviewContext};
use mizer_clock::{ClockState, Timecode};
use mizer_injector::Inject;
use mizer_ports::{Color, PortValue};
use mizer_util::StructuredData;
use mizer_wgpu::TextureView;

use self::clock::ClockFunction;
use self::read_port::ReadPortFunction;
use self::write_port::WritePortFunction;

mod clock;
mod read_port;
mod write_port;

pub struct NodeContextMock {
    write_port_fn: WritePortFunction,
    read_port_fn: ReadPortFunction,
    clock_fn: ClockFunction,
    pub history: RefCell<Vec<f64>>,
    pub path: NodePath,
}

impl NodeContextMock {
    pub fn new() -> Self {
        Self {
            write_port_fn: Default::default(),
            read_port_fn: Default::default(),
            clock_fn: Default::default(),
            history: Default::default(),
            path: NodePath(Default::default()),
        }
    }
}

impl NodeContext for NodeContextMock {
    fn clock(&self) -> ClockFrame {
        self.clock_fn.call()
    }

    fn write_clock_tempo(&self, _speed: f64) {
        todo!()
    }

    fn write_clock_state(&self, _state: ClockState) {
        todo!()
    }

    fn tap_clock(&self) {
        todo!()
    }

    fn resync_clock(&self) {
        todo!()
    }

    fn clock_state(&self) -> ClockState {
        todo!()
    }

    fn fps(&self) -> f64 {
        todo!()
    }

    fn path(&self) -> &NodePath {
        &self.path
    }

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V) {
        self.write_port_fn.call(port, value)
    }

    fn clear_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) {
        todo!()
    }

    fn read_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        self.read_port_fn.call(port)
    }

    fn read_port_changes<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V> {
        self.read_port_fn.call(port)
    }

    fn read_ports<P: Into<PortId>, V: PortValue + 'static>(&self, _: P) -> Vec<Option<V>> {
        todo!()
    }

    fn read_changed_ports<P: Into<PortId>, V: PortValue + 'static>(&self, _: P) -> Vec<Option<V>> {
        todo!()
    }

    fn input_port<P: Into<PortId>>(&self, _: P) -> PortMetadata {
        todo!()
    }

    fn output_port<P: Into<PortId>>(&self, _: P) -> Option<&PortMetadata> {
        todo!()
    }

    fn input_port_count<P: Into<PortId>>(&self, _: P) -> usize {
        todo!()
    }

    fn input_ports(&self) -> Vec<PortId> {
        todo!()
    }

    fn read_texture<P: Into<PortId>>(&self, port: P) -> Option<TextureView> {
        todo!()
    }

    fn read_textures<P: Into<PortId>>(&self, port: P) -> Vec<TextureView> {
        todo!()
    }
}

impl Inject for NodeContextMock {
    fn try_inject<T: 'static>(&self) -> Option<&T> {
        todo!()
    }
}

impl PreviewContext for NodeContextMock {
    fn push_history_value(&self, value: f64) {
        self.history.borrow_mut().push(value);
    }

    fn write_multi_preview(&self, data: Vec<f64>) {}

    fn write_data_preview(&self, _data: StructuredData) {
        todo!()
    }

    fn write_color_preview(&self, _color: Color) {}

    fn write_timecode_preview(&self, _timecode: Timecode) {}
}
