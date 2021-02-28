use crate::file_storage::FileStorage;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};
use std::io::Write;
use std::path::Path;
use tiny_skia::Pixmap;
use usvg::NodeExt;

pub struct SvgHandler;

impl MediaHandler for SvgHandler {
    fn supported(content_type: &str) -> bool {
        content_type == "text/xml"
    }

    fn generate_thumbnail<P: AsRef<Path>>(
        &self,
        file: P,
        storage: &FileStorage,
        content_type: &str,
    ) -> anyhow::Result<()> {
        let tree = usvg::Tree::from_file(&file, &Default::default())?;
        let mut pixmap = Pixmap::new(THUMBNAIL_SIZE, THUMBNAIL_SIZE).unwrap();
        let pixel_buffer = pixmap.as_mut();
        let bounding_box = tree.root().calculate_bbox().unwrap();
        let size = if bounding_box.width() > bounding_box.height() {
            usvg::FitTo::Width(THUMBNAIL_SIZE)
        } else {
            usvg::FitTo::Height(THUMBNAIL_SIZE)
        };
        resvg::render(&tree, size, pixel_buffer);
        let buffer = pixmap.encode_png()?;
        let thumbnail_path = storage.get_thumbnail_path(file);
        let mut file = std::fs::File::create(thumbnail_path)?;
        file.write_all(&buffer)?;
        Ok(())
    }
}
