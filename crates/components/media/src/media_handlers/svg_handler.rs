use crate::documents::MediaType;
use crate::file_storage::FileStorage;
use crate::media_handlers::{MediaHandler, THUMBNAIL_SIZE};
use resvg::tiny_skia::{self, Pixmap};
use resvg::usvg::{self, NodeExt, Options, TreeParsing};
use std::io::{Read, Write};
use std::path::Path;

#[derive(Clone)]
pub struct SvgHandler;

impl MediaHandler for SvgHandler {
    const MEDIA_TYPE: MediaType = MediaType::Vector;

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
        let tree = usvg::Tree::from_data(&buffer, &Options::default())?;
        let mut pixmap = Pixmap::new(THUMBNAIL_SIZE, THUMBNAIL_SIZE).unwrap();
        let mut pixel_buffer = pixmap.as_mut();
        let bounding_box = tree.root.calculate_bbox().unwrap();
        let scale = if bounding_box.width() > bounding_box.height() {
            (THUMBNAIL_SIZE as f32) / bounding_box.width()
        } else {
            (THUMBNAIL_SIZE as f32) / bounding_box.height()
        };
        let tree = resvg::Tree::from_usvg(&tree);
        tree.render(
            tiny_skia::Transform::from_scale(scale, scale),
            &mut pixel_buffer,
        );
        let buffer = pixmap.encode_png()?;
        let thumbnail_path = storage.get_thumbnail_path(&path);
        let mut file = std::fs::File::create(thumbnail_path)?;
        file.write_all(&buffer)?;
        Ok(())
    }
}
