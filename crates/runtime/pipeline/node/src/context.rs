use std::marker::PhantomData;

pub use mizer_clock::ClockFrame;
pub use mizer_clock::ClockState;
pub use mizer_injector::Inject;
use mizer_ports::port_types;
pub use mizer_ports::{PortId, PortValue};
use mizer_wgpu::TextureView;

use crate::{PortMetadata, PreviewContext};

pub const SINGLE_HIGH: f64 = 1.0;
pub const SINGLE_LOW: f64 = 0.0;

pub trait NodeContext: PreviewContext + Sized + Inject {
    fn clock(&self) -> ClockFrame;
    fn write_clock_tempo(&self, speed: f64);
    fn write_clock_state(&self, state: ClockState);
    fn tap_clock(&self);
    fn resync_clock(&self);
    fn clock_state(&self) -> ClockState;
    fn fps(&self) -> f64;

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V);
    fn clear_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P);

    fn read_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V>;
    fn read_port_changes<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V>;

    fn read_ports<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Vec<Option<V>>;
    fn read_changed_ports<P: Into<PortId>, V: PortValue + 'static>(
        &self,
        port: P,
    ) -> Vec<Option<V>>;

    fn input_port<P: Into<PortId>>(&self, port: P) -> PortMetadata;
    fn output_port<P: Into<PortId>>(&self, port: P) -> Option<&PortMetadata>;
    fn input_port_count<P: Into<PortId>>(&self, port: P) -> usize;

    fn input_ports(&self) -> Vec<PortId>;

    fn read_texture<P: Into<PortId>>(&self, port: P) -> Option<TextureView>;
    fn read_textures<P: Into<PortId>>(&self, port: P) -> Vec<TextureView>;

    fn single_input<P: Into<PortId>>(&self, port: P) -> PortReader<port_types::SINGLE, Self> {
        self.input(port)
    }
    fn color_input<P: Into<PortId>>(&self, port: P) -> PortReader<port_types::COLOR, Self> {
        self.input(port)
    }
    fn multi_input<P: Into<PortId>>(&self, port: P) -> PortReader<port_types::MULTI, Self> {
        self.input(port)
    }
    fn data_input<P: Into<PortId>>(&self, port: P) -> PortReader<port_types::DATA, Self> {
        self.input(port)
    }
    fn vector_input<P: Into<PortId>>(&self, port: P) -> PortReader<port_types::VECTOR, Self> {
        self.input(port)
    }
    fn text_input<P: Into<PortId>>(&self, port: P) -> PortReader<port_types::TEXT, Self> {
        self.input(port)
    }

    fn input<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> PortReader<V, Self> {
        PortReader {
            _value: Default::default(),
            port_id: port.into(),
            context: self,
        }
    }
}

pub struct PortReader<'a, V: PortValue + 'static, C: NodeContext> {
    port_id: PortId,
    context: &'a C,
    _value: PhantomData<V>,
}

impl<'a, V: PortValue + 'static, C: NodeContext> PortReader<'a, V, C> {
    pub fn read(&self) -> Option<V> {
        self.context.read_port(self.port_id.clone())
    }

    pub fn read_changes(&self) -> Option<V> {
        self.context.read_port_changes(self.port_id.clone())
    }

    pub fn read_multiple(&self) -> Vec<Option<V>> {
        self.context.read_ports(self.port_id.clone())
    }

    pub fn read_multiple_changes(&self) -> Vec<Option<V>> {
        self.context.read_changed_ports(self.port_id.clone())
    }

    pub fn read_link_count(&self) -> usize {
        self.context.input_port_count(self.port_id.clone())
    }

    pub fn metadata(&self) -> PortMetadata {
        self.context.input_port(self.port_id.clone())
    }
}

impl<'a, C: NodeContext> PortReader<'a, port_types::SINGLE, C> {
    pub fn is_high(&self) -> Option<bool> {
        self.read().map(|value| value.is_high())
    }
}

pub trait PortValueExt {
    fn is_high(&self) -> bool;
}

impl PortValueExt for port_types::SINGLE {
    fn is_high(&self) -> bool {
        *self > (0f64 + f64::EPSILON)
    }
}
