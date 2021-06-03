use crate::{PortMetadata, PreviewContext};
pub use mizer_clock::ClockFrame;
use mizer_ports::{PortId, PortValue};

pub trait NodeContext : PreviewContext {
    fn clock(&self) -> ClockFrame;

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V);

    fn read_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V>;

    fn input_port<P: Into<PortId>>(&self, port: P) -> PortMetadata;
    fn output_port<P: Into<PortId>>(&self, port: P) -> &PortMetadata;

    fn input_ports(&self) -> Vec<PortId>;

    fn inject<T: 'static>(&self) -> Option<&T>;
}
