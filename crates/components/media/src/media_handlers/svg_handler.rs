use std::io::{Read, Write};
use std::path::{Path, PathBuf};

use resvg::tiny_skia::{self, Pixmap};
use resvg::usvg::{self, Options, TreeParsing};

use crate::documents::MediaType;
use crate::file_storage::FileStorage;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};

#[derive(Clone)]
pub struct SvgHandler;

impl MediaHandler for SvgHandler {
    const MEDIA_TYPE: MediaType = MediaType::Vector;

    fn supported(content_type: &str) -> bool {
        content_type == "text/xml" || content_type == "image/svg+xml"
    }

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        path: P,
        storage: &FileStorage,
        _content_type: &str,
    ) -> anyhow::Result<()> {
        let tree = Self::read_svg(&path)?;
        let buffer = Self::generate_thumbnail(tree)?;

        let thumbnail_path = storage.get_thumbnail_path(&path);
        Self::write_thumbnail(&buffer, thumbnail_path)?;
        Ok(())
    }
}

impl SvgHandler {
    fn read_svg<P: AsRef<Path>>(path: &P) -> anyhow::Result<resvg::Tree> {
        let mut file = std::fs::File::open(path)?;
        let mut buffer = Vec::new();
        file.read_to_end(&mut buffer)?;
        let tree = usvg::Tree::from_data(&buffer, &Options::default())?;
        let tree = resvg::Tree::from_usvg(&tree);

        Ok(tree)
    }

    fn get_thumbnail_transform(
        tree: &resvg::Tree,
    ) -> anyhow::Result<(tiny_skia::IntSize, tiny_skia::Transform)> {
        let size = if tree.size.width() > tree.size.height() {
            tree.size.to_int_size().scale_to_width(THUMBNAIL_SIZE)
        } else {
            tree.size.to_int_size().scale_to_height(THUMBNAIL_SIZE)
        }
        .ok_or_else(|| anyhow::anyhow!("Failed to calculate thumbnail size"))?;

        let transform = tiny_skia::Transform::from_scale(
            size.width() as f32 / tree.size.width(),
            size.height() as f32 / tree.size.height(),
        );
        Ok((size, transform))
    }

    fn write_thumbnail(buffer: &[u8], thumbnail_path: PathBuf) -> anyhow::Result<()> {
        let mut file = std::fs::File::create(thumbnail_path)?;
        file.write_all(buffer)?;

        Ok(())
    }

    fn generate_thumbnail(tree: resvg::Tree) -> anyhow::Result<Vec<u8>> {
        let (size, transform) = Self::get_thumbnail_transform(&tree)?;

        let mut pixmap = Pixmap::new(size.width(), size.height()).unwrap();
        tree.render(transform, &mut pixmap.as_mut());
        let buffer = pixmap.encode_png()?;

        Ok(buffer)
    }
}
