use enum_dispatch::enum_dispatch;
use std::collections::HashMap;

pub use self::artnet::ArtnetOutput;
pub use self::sacn::SacnOutput;

mod artnet;
mod sacn;

#[enum_dispatch(DmxOutputConnection)]
pub trait DmxOutput {
    fn name(&self) -> String;
    fn write_single(&self, universe: u16, channel: u16, value: u8);
    fn write_bulk(&self, universe: u16, channel: u16, values: &[u8]);
    fn flush(&self);
    fn read_buffer(&self) -> HashMap<u16, [u8; 512]>;
}

#[enum_dispatch]
pub enum DmxOutputConnection {
    Artnet(ArtnetOutput),
    Sacn(SacnOutput),
}
