use std::io::{Read, Write};
use std::path::{Path};

use resvg::tiny_skia::{self, Pixmap};
use resvg::usvg::{self, Options};

use crate::documents::{MediaDocument, MediaType};
use super::{THUMBNAIL_SIZE, IThumbnailGenerator};

pub struct SvgGenerator {
    fontdb: fontdb::Database,
}

impl SvgGenerator {
    #[allow(clippy::new_without_default)]
    pub fn new() -> Self {
        let mut fontdb = fontdb::Database::new();
        fontdb.load_system_fonts();

        Self {
            fontdb
        }
    }
}

impl IThumbnailGenerator for SvgGenerator {
    fn supported(&self, media: &MediaDocument) -> bool {
        media.media_type == MediaType::Vector && (
            media.content_type == "text/xml" || media.content_type == "image/svg+xml"
        )
    }

    fn generate_thumbnail(
        &self,
        media: &MediaDocument,
        thumbnail_path: &Path,
    ) -> anyhow::Result<Option<()>> {
        let tree = self.read_svg(&media.file_path)?;
        let buffer = Self::generate_thumbnail(tree)?;

        Self::write_thumbnail(&buffer, thumbnail_path)?;

        Ok(Some(()))
    }
}

impl SvgGenerator {
    fn read_svg<P: AsRef<Path>>(&self, path: &P) -> anyhow::Result<usvg::Tree> {
        let mut file = std::fs::File::open(path)?;
        let mut buffer = Vec::new();
        file.read_to_end(&mut buffer)?;
        let tree = usvg::Tree::from_data(&buffer, &Options::default(), &self.fontdb)?;

        Ok(tree)
    }

    fn generate_thumbnail(tree: usvg::Tree) -> anyhow::Result<Vec<u8>> {
        let (size, transform) = Self::get_thumbnail_transform(&tree)?;

        let mut pixmap = Pixmap::new(size.width(), size.height()).unwrap();
        resvg::render(&tree, transform, &mut pixmap.as_mut());
        let buffer = pixmap.encode_png()?;

        Ok(buffer)
    }

    fn get_thumbnail_transform(
        tree: &usvg::Tree,
    ) -> anyhow::Result<(tiny_skia::IntSize, tiny_skia::Transform)> {
        let size = if tree.size().width() > tree.size().height() {
            tree.size().to_int_size().scale_to_width(THUMBNAIL_SIZE)
        } else {
            tree.size().to_int_size().scale_to_height(THUMBNAIL_SIZE)
        }
            .ok_or_else(|| anyhow::anyhow!("Failed to calculate thumbnail size"))?;

        let transform = tiny_skia::Transform::from_scale(
            size.width() as f32 / tree.size().width(),
            size.height() as f32 / tree.size().height(),
        );
        Ok((size, transform))
    }

    fn write_thumbnail(buffer: &[u8], thumbnail_path: &Path) -> anyhow::Result<()> {
        let mut file = std::fs::File::create(thumbnail_path)?;
        file.write_all(buffer)?;

        Ok(())
    }
}
