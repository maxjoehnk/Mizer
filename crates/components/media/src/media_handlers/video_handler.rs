use std::path::Path;

use ffmpeg_the_third as ffmpeg;

use crate::documents::{MediaMetadata, MediaType};
use crate::media_handlers::MediaHandler;

#[derive(Clone)]
pub struct VideoHandler;

impl MediaHandler for VideoHandler {
    const MEDIA_TYPE: MediaType = MediaType::Video;

    fn supported(content_type: &str) -> bool {
        content_type.starts_with("video")
    }

    fn read_metadata<P: AsRef<Path>>(
        &self,
        file: P,
        _content_type: &str,
    ) -> anyhow::Result<MediaMetadata> {
        let file = file.as_ref();
        let mut metadata = MediaMetadata::default();
        let input_context = ffmpeg::format::input(&file)?;
        ffmpeg::format::context::input::dump(&input_context, 0, file.to_str());
        let stream = input_context
            .streams()
            .best(ffmpeg::media::Type::Video)
            .unwrap();

        let decoder_context =
            ffmpeg::codec::context::Context::from_parameters(stream.parameters())?;
        let decoder = decoder_context.decoder().video()?;
        metadata.duration = if stream.duration() < 0 {
            None
        } else {
            let time_base: f64 = stream.time_base().into();
            let duration = stream.duration() as f64 * time_base;
            Some(duration.round() as u64)
        };

        metadata.dimensions = Some((decoder.width() as u64, decoder.height() as u64));
        metadata.framerate = Some(stream.rate().into());

        Ok(metadata)
    }
}
