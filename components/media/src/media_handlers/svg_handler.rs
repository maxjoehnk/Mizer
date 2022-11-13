use crate::file_storage::FileStorage;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};
use std::io::{Read, Write};
use std::path::Path;
use tiny_skia::Pixmap;
use usvg::{NodeExt, Options};

pub struct SvgHandler;

impl MediaHandler for SvgHandler {
    fn supported(content_type: &str) -> bool {
        content_type == "text/xml"
    }

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        path: P,
        storage: &FileStorage,
        _content_type: &str,
    ) -> anyhow::Result<()> {
        let mut file = std::fs::File::open(&path)?;
        let mut buffer = Vec::new();
        file.read_to_end(&mut buffer)?;
        let tree = usvg::Tree::from_data(&buffer, &Options::default().to_ref())?;
        let mut pixmap = Pixmap::new(THUMBNAIL_SIZE, THUMBNAIL_SIZE).unwrap();
        let pixel_buffer = pixmap.as_mut();
        let bounding_box = tree.root.calculate_bbox().unwrap();
        let size = if bounding_box.width() > bounding_box.height() {
            usvg::FitTo::Width(THUMBNAIL_SIZE)
        } else {
            usvg::FitTo::Height(THUMBNAIL_SIZE)
        };
        resvg::render(&tree, size, Default::default(), pixel_buffer);
        let buffer = pixmap.encode_png()?;
        let thumbnail_path = storage.get_thumbnail_path(&path);
        let mut file = std::fs::File::create(thumbnail_path)?;
        file.write_all(&buffer)?;
        Ok(())
    }
}
