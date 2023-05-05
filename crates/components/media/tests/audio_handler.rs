use mizer_media::media_handlers::{AudioHandler, MediaHandler};
use std::path::PathBuf;
use test_case::test_case;

#[test_case("file_example_MP3_700KB.mp3", "audio/mp3", 27)]
#[test_case("file_example_WAV_1MG.wav", "audio/wav", 33)]
fn audio_handler_should_read_audio_duration(filename: &str, content_type: &str, expected: u64) {
    let path = PathBuf::from(format!(
        "{}/tests/files/{filename}",
        env!("CARGO_MANIFEST_DIR")
    ));
    let handler = AudioHandler;

    let metadata = handler.read_metadata(path, content_type).unwrap();

    assert_eq!(Some(expected), metadata.duration);
}
