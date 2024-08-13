use crate::buffer::DmxBuffer;
use enum_dispatch::enum_dispatch;

pub use self::artnet::ArtnetOutput;
pub use self::sacn::SacnOutput;

mod artnet;
mod sacn;

#[enum_dispatch(DmxOutputConnection)]
pub trait DmxOutput {
    fn name(&self) -> String;
    fn flush(&self, buffer: &DmxBuffer);
}

#[enum_dispatch]
pub enum DmxOutputConnection {
    Artnet(ArtnetOutput),
    Sacn(SacnOutput),
}

pub trait DmxWriter: Sync + Send {
    fn write_single(&self, universe: u16, channel: u16, value: u8);
    fn write_bulk(&self, universe: u16, channel: u16, values: &[u8]);
}
