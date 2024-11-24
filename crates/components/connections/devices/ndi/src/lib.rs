use image::{DynamicImage, ImageBuffer, Pixel};
use ndi::{FourCCVideoType, FrameType, Recv, RecvColorFormat, Source, VideoData};

pub use discovery::NdiSourceDiscovery;

mod discovery;

#[derive(Clone)]
pub struct NdiSourceRef {
    source: Source,
    name: String,
}

impl std::fmt::Debug for NdiSourceRef {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("NdiSourceRef")
            .field("name", &self.name)
            .finish()
    }
}

impl PartialEq for NdiSourceRef {
    fn eq(&self, other: &Self) -> bool {
        self.name == other.name
    }
}

impl Eq for NdiSourceRef {}

impl NdiSourceRef {
    pub(crate) fn new(source: Source) -> Self {
        Self {
            name: source.get_name(),
            source,
        }
    }

    pub fn name(&self) -> String {
        self.name.clone()
    }

    pub fn id(&self) -> String {
        self.name.clone()
    }

    pub fn open(&self) -> anyhow::Result<NdiSource> {
        tracing::debug!("Setting up NDI receiver");
        let recv = ndi::recv::RecvBuilder::new()
            .color_format(RecvColorFormat::RGBX_RGBA)
            .build()?;
        let source = NdiSource::new(recv, &self.source)?;

        Ok(source)
    }
}

pub struct NdiSource {
    recv: Recv,
    metadata: Option<NdiSourceMetadata>,
    source: Source,
}

#[derive(Debug, Clone, Copy)]
struct NdiSourceMetadata {
    width: u32,
    height: u32,
    frame_rate: f32,
}

impl Default for NdiSourceMetadata {
    fn default() -> Self {
        Self {
            width: 1920,
            height: 1080,
            frame_rate: 30.0,
        }
    }
}

impl NdiSourceMetadata {
    fn new(video_data: &VideoData) -> Self {
        let width = video_data.width();
        let height = video_data.height();
        let frame_rate = video_data.frame_rate();

        Self {
            width,
            height,
            frame_rate,
        }
    }
}

impl NdiSource {
    fn new(mut recv: Recv, source: &Source) -> anyhow::Result<Self> {
        let source = source.clone();
        tracing::debug!("Connecting to source: {:?}", source.get_name());
        recv.disconnect();
        recv.connect(&source);

        tracing::debug!("Receiving first frame to get video metadata");
        let mut video_data = None;
        let mut i = 0;
        while video_data.is_none() {
            if !matches!(recv.capture_video(&mut video_data, 100), FrameType::Video) {
                video_data = None;
            }
            i += 1;
            if i > 10 {
                break;
            }
        }
        let metadata = video_data.map(|video_data| {
            tracing::debug!("Received video frame: {video_data:?}");
            NdiSourceMetadata::new(&video_data)
        });

        Ok(Self {
            recv,
            metadata,
            source,
        })
    }

    pub fn width(&self) -> u32 {
        self.metadata.unwrap_or_default().width
    }

    pub fn height(&self) -> u32 {
        self.metadata.unwrap_or_default().height
    }

    pub fn frame_rate(&self) -> f32 {
        self.metadata.unwrap_or_default().frame_rate
    }

    pub fn frame(&mut self) -> anyhow::Result<Option<NdiFrame>> {
        if self.recv.get_no_connections() == 0 {
            tracing::warn!("Connected to no sources, trying to reconnect to {}", self.source.get_name());
            self.recv.connect(&self.source);
        }
        tracing::trace!("Waiting for frame");
        let mut video_data = None;

        const TIMEOUT: u32 = 1000;
        match self.recv.capture_video(&mut video_data, TIMEOUT) {
            FrameType::None => {
                Ok(None)
            }
            FrameType::Video => {
                if let Some(video_data) = video_data {
                    tracing::debug!("Received video frame: {video_data:?}");
                    self.metadata = Some(NdiSourceMetadata::new(&video_data));

                    Ok(Some(NdiFrame(video_data)))
                } else {
                    tracing::warn!("Received video frame with no data");
                    Err(anyhow::anyhow!("Video data was null"))
                }
            }
            frame_type => {
                tracing::warn!("Received non-video frame: {frame_type:?}");
                Err(anyhow::anyhow!("Frame type was not video"))
            }
        }
    }
}

pub struct NdiFrame(VideoData);

impl NdiFrame {
    pub fn data(self) -> anyhow::Result<Vec<u8>> {
        let size = self.0.height() * self.0.line_stride_in_bytes().unwrap_or_default();
        anyhow::ensure!(!self.0.p_data().is_null(), "Video data was null");
        let buffer = unsafe { std::slice::from_raw_parts(self.0.p_data(), size as usize) };
        let frame = Vec::from_iter(buffer.to_owned());
        let image = match self.0.four_cc() {
            FourCCVideoType::RGBA | FourCCVideoType::RGBX => {
                decode::<image::Rgba<u8>>(frame, self.0).map(DynamicImage::ImageRgba8)?
            }
            video_type => anyhow::bail!("Unsupported video type: {video_type:?}"),
        };
        let image = image.into_rgba8();

        Ok(image.into_flat_samples().samples)
    }
}

fn decode<T: Pixel<Subpixel = u8> + 'static>(
    frame: Vec<u8>,
    video_data: VideoData,
) -> anyhow::Result<ImageBuffer<T, Vec<u8>>> {
    let image =
        image::ImageBuffer::<T, _>::from_vec(video_data.width(), video_data.height(), frame)
            .ok_or_else(|| anyhow::anyhow!("Failed to create image"))?;

    Ok(image)
}
