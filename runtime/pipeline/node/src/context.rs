use crate::{PortMetadata, PreviewContext};
pub use mizer_clock::ClockFrame;
use mizer_ports::{PortId, PortValue};

pub trait NodeContext: PreviewContext {
    fn clock(&self) -> ClockFrame;

    fn write_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P, value: V);

    fn read_port<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V>;
    fn read_port_changes<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Option<V>;

    fn read_ports<P: Into<PortId>, V: PortValue + 'static>(&self, port: P) -> Vec<Option<V>>;
    fn read_changed_ports<P: Into<PortId>, V: PortValue + 'static>(
        &self,
        port: P,
    ) -> Vec<Option<V>>;

    fn input_port<P: Into<PortId>>(&self, port: P) -> PortMetadata;
    fn output_port<P: Into<PortId>>(&self, port: P) -> &PortMetadata;
    fn input_port_count<P: Into<PortId>>(&self, port: P) -> usize;

    fn input_ports(&self) -> Vec<PortId>;

    fn inject<T: 'static>(&self) -> Option<&T>;
}
