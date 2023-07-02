use crate::{PortMetadata, PreviewContext};
pub use mizer_clock::ClockFrame;
pub use mizer_clock::ClockState;
use mizer_ports::{PortId, PortValue};
use mizer_wgpu::TextureView;

pub trait NodeContext: PreviewContext {
    fn clock(&self) -> ClockFrame;
    fn write_clock_tempo(&self, speed: f64);
    fn write_clock_state(&self, state: ClockState);
    fn clock_state(&self) -> ClockState;

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V);

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

    fn inject<T: 'static>(&self) -> Option<&T>;

    fn read_texture<P: Into<PortId>>(&self, port: P) -> Option<TextureView>;
}
