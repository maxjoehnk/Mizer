use std::borrow::Cow;

pub trait TextureProvider {
    fn width(&self) -> u32;
    fn height(&self) -> u32;
    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>>;
}
