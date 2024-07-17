use std::fs::File;
use std::path::Path;

use anyhow::Context;
use id3::{Tag, TagLike};
use symphonia::core::formats::{FormatOptions, FormatReader};
use symphonia::core::io::{MediaSourceStream, ReadOnlySource};
use symphonia::core::meta::MetadataOptions;
use symphonia::core::probe::Hint;

use crate::documents::{MediaMetadata, MediaType};
use crate::media_handlers::{MediaHandler};

#[derive(Clone)]
pub struct AudioHandler;

impl MediaHandler for AudioHandler {
    const MEDIA_TYPE: MediaType = MediaType::Audio;

    fn supported(content_type: &str) -> bool {
        content_type.starts_with("audio")
    }

    fn read_metadata<P: AsRef<Path>>(
        &self,
        file: P,
        _content_type: &str,
    ) -> anyhow::Result<MediaMetadata> {
        let mut metadata = self.read_tag_metadata(&file).unwrap_or_default();
        let probe_result = self.probe_file(&file)?;
        metadata.duration = Self::get_duration(&probe_result.format).or(metadata.duration);
        metadata.sample_rate = Self::get_sample_rate(&probe_result.format);
        metadata.audio_channels = Self::get_channel_count(&probe_result.format);

        Ok(metadata)
    }
}

impl AudioHandler {
    fn probe_file<P: AsRef<Path>>(&self, file: P) -> anyhow::Result<symphonia::core::probe::ProbeResult> {
        let mut hint = Hint::new();
        if let Some(extension) = file.as_ref().extension().and_then(|e| e.to_str()) {
            hint.with_extension(extension);
        }
        let file = File::open(file)?;
        let source = Box::new(ReadOnlySource::new(file));
        let mss = MediaSourceStream::new(source, Default::default());

        let format_opts = FormatOptions::default();
        let metadata_opts = MetadataOptions::default();
        let probed =
            symphonia::default::get_probe().format(&hint, mss, &format_opts, &metadata_opts)?;
        
        Ok(probed)
    }
    
    fn get_duration(format: &Box<dyn FormatReader>) -> Option<u64> {
        let track = format.default_track()?;
        let timebase = track.codec_params.time_base?;
        let n_frames = track.codec_params.n_frames?;
        let time = timebase.calc_time(n_frames);

        Some(time.seconds)
    }

    fn get_sample_rate(format: &Box<dyn FormatReader>) -> Option<u32> {
        let track = format.default_track()?;

        track.codec_params.sample_rate
    }

    fn get_channel_count(format: &Box<dyn FormatReader>) -> Option<u32> {
        let track = format.default_track()?;

        Some(track.codec_params.channels?.count() as u32)
    }

    fn read_tag_metadata<P: AsRef<Path>>(&self, file: P) -> anyhow::Result<MediaMetadata> {
        let tag = Tag::read_from_path(file).context("Unable to read id3 tag")?;
        let name = tag.title().map(|a| a.to_string());
        let album = tag.album().map(|a| a.to_string());
        let artist = tag.artist().map(|a| a.to_string());
        let duration = tag.duration().map(|d| d as u64);

        Ok(MediaMetadata {
            name,
            album,
            artist,
            duration,
            ..Default::default()
        })
    }
}
