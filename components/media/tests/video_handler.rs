use mizer_media::media_handlers::{MediaHandler, VideoHandler};
use std::path::PathBuf;
use test_case::test_case;

#[test_case("file_example_AVI_480_750kB.avi", "video/avi", 30)]
#[test_case("file_example_MOV_640_800kB.mov", "video/quicktime", 30)]
fn video_handler_should_read_audio_duration(filename: &str, content_type: &str, expected: u64) {
    let path = PathBuf::from(format!(
        "{}/tests/files/{filename}",
        env!("CARGO_MANIFEST_DIR")
    ));
    let handler = VideoHandler;

    let metadata = handler.read_metadata(path, content_type).unwrap();

    assert_eq!(Some(expected), metadata.duration);
}

#[test_case("file_example_AVI_480_750kB.avi", "video/avi", 480, 270)]
#[test_case("file_example_MOV_640_800kB.mov", "video/quicktime", 640, 360)]
fn video_handler_should_read_dimensions(
    filename: &str,
    content_type: &str,
    width: u64,
    height: u64,
) {
    let path = PathBuf::from(format!(
        "{}/tests/files/{filename}",
        env!("CARGO_MANIFEST_DIR")
    ));
    let handler = VideoHandler;

    let metadata = handler.read_metadata(path, content_type).unwrap();

    assert_eq!(Some((width, height)), metadata.dimensions);
}

#[test_case("file_example_AVI_480_750kB.avi", "video/avi", 30.)]
#[test_case("file_example_MOV_640_800kB.mov", "video/quicktime", 30.)]
fn video_handler_should_read_framerate(filename: &str, content_type: &str, framerate: f64) {
    let path = PathBuf::from(format!(
        "{}/tests/files/{filename}",
        env!("CARGO_MANIFEST_DIR")
    ));
    let handler = VideoHandler;

    let metadata = handler.read_metadata(path, content_type).unwrap();

    assert_eq!(Some(framerate), metadata.framerate);
}
