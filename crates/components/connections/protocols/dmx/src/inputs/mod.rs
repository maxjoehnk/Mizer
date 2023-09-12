pub use self::artnet::{ArtnetInput, ArtnetInputConfig};
use enum_dispatch::enum_dispatch;

mod artnet;

#[enum_dispatch(DmxInputConnection)]
pub trait DmxInput {
    fn name(&self) -> String;
    fn read_single(&self, universe: u16, channel: u16) -> Option<u8>;
    fn read_bulk(&self, universe: u16) -> Option<Vec<u8>>;
}

#[enum_dispatch]
pub enum DmxInputConnection {
    Artnet(ArtnetInput),
}
