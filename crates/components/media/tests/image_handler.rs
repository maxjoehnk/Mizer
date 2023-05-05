use std::path::PathBuf;

use test_case::test_case;

use mizer_media::media_handlers::{ImageHandler, MediaHandler};

#[test_case("file_example_JPG_100kB.jpg", "image/jpeg", 1050, 700)]
#[test_case("file_example_PNG_500kB.png", "image/png", 850, 566)]
fn image_handler_should_read_dimensions(
    filename: &str,
    content_type: &str,
    width: u64,
    height: u64,
) {
    let path = PathBuf::from(format!(
        "{}/tests/files/{filename}",
        env!("CARGO_MANIFEST_DIR")
    ));
    let handler = ImageHandler;

    let metadata = handler.read_metadata(path, content_type).unwrap();

    assert_eq!(Some((width, height)), metadata.dimensions);
}
