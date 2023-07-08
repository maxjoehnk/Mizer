use crate::texture::texture_provider::TextureProvider;
use std::borrow::Cow;

pub struct StaticTexture {
    img: image::DynamicImage,
}

impl StaticTexture {
    pub fn new(image: image::DynamicImage) -> Self {
        Self { img: image }
    }
}

impl TextureProvider for StaticTexture {
    fn width(&self) -> u32 {
        self.img.width()
    }

    fn height(&self) -> u32 {
        self.img.height()
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        let data = self
            .img
            .as_rgba8()
            .map(|data| data.as_raw())
            .map(|data| Cow::Borrowed(data.as_slice()));

        Ok(data)
    }
}
