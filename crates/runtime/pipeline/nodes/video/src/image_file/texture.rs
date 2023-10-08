use std::borrow::Cow;
use std::path::PathBuf;

use image::RgbaImage;

use mizer_node::*;
use mizer_wgpu::TextureProvider;

pub struct ImageTexture {
    pub file_path: PathBuf,
    image: RgbaImage,
}

impl ImageTexture {
    pub fn new(path: PathBuf) -> anyhow::Result<Self> {
        let image = image::open(path.clone())?;
        let image = image.into_rgba8();

        Ok(Self {
            file_path: path,
            image,
        })
    }

    pub fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>) {
        ui.columns(2, |columns| {
            columns[0].label("Texture Size");
            columns[1].label(format!("{}x{}", self.width(), self.height()));
        });
    }
}

impl TextureProvider for ImageTexture {
    fn width(&self) -> u32 {
        self.image.width()
    }

    fn height(&self) -> u32 {
        self.image.height()
    }

    fn data(&mut self) -> anyhow::Result<Option<Cow<[u8]>>> {
        profiling::scope!("VideoTexture::data");
        Ok(Some(Cow::Borrowed(&self.image)))
    }
}
