use image::{DynamicImage, ImageBuffer, Pixel};
#[cfg(feature = "enable")]
use ndi::{FourCCVideoType, FrameType, Recv, RecvColorFormat, Source, VideoData};

#[cfg(feature = "enable")]
pub use discovery::NdiSourceDiscovery;

#[cfg(not(feature = "enable"))]
pub use discovery_noop::NdiSourceDiscovery;

#[cfg(feature = "enable")]
pub use sender::NdiSender;

#[cfg(not(feature = "enable"))]
pub use sender_noop::NdiSender;

#[cfg(feature = "enable")]
mod discovery;

#[cfg(not(feature = "enable"))]
mod discovery_noop;

#[cfg(feature = "enable")]
mod sender;

#[cfg(not(feature = "enable"))]
mod sender_noop;

#[derive(Debug, Clone)]
pub struct NdiSourceRef {
    #[cfg(feature = "ndi")]
    source: Source,
    name: String,
}

impl PartialEq for NdiSourceRef {
    fn eq(&self, other: &Self) -> bool {
        self.name == other.name
    }
}

impl Eq for NdiSourceRef {}

impl NdiSourceRef {
    #[cfg(feature = "enable")]
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

    #[cfg(feature = "enable")]
    pub fn open(&self) -> anyhow::Result<NdiSource> {
        tracing::debug!("Setting up NDI receiver");
        let recv = ndi::recv::RecvBuilder::new()
            .color_format(RecvColorFormat::RGBX_RGBA)
            .build()?;
        let source = NdiSource::new(recv, &self.source)?;

        Ok(source)
    }

    #[cfg(not(feature = "enable"))]
    pub fn open(&self) -> anyhow::Result<NdiSource> {
        anyhow::bail!("NDI support not enabled")
    }
}

#[cfg(not(feature = "enable"))]
pub struct NdiSource;

#[cfg(feature = "enable")]
pub struct NdiSource {
    recv: Recv,
    width: u32,
    height: u32,
    frame_rate: f32,
    _source: Source,
}

#[cfg(feature = "enable")]
impl NdiSource {
    fn new(mut recv: Recv, source: &Source) -> anyhow::Result<Self> {
        tracing::debug!("Connecting to source: {source:?}");
        recv.connect(source);
        tracing::info!("Connected to source {source:?}");

        tracing::debug!("Receiving first frame to get video metadata");
        let mut video_data = None;
        let mut i = 0;
        while video_data.is_none() {
            if !matches!(recv.capture_video(&mut video_data, 100), FrameType::Video) {
                video_data = None;
            }
            i += 1;
            if i > 10 {
                anyhow::bail!("Failed to receive video data");
            }
        }
        let video_data = video_data.unwrap();
        tracing::debug!("Received video frame: {video_data:?}");
        let width = video_data.width();
        let height = video_data.height();
        let frame_rate = video_data.frame_rate();

        Ok(Self {
            recv,
            width,
            height,
            frame_rate,
            _source: source.clone(),
        })
    }

    pub fn width(&self) -> u32 {
        self.width
    }

    pub fn height(&self) -> u32 {
        self.height
    }

    pub fn frame_rate(&self) -> f32 {
        self.frame_rate
    }

    pub fn frame(&mut self) -> anyhow::Result<NdiFrame> {
        let mut video_data = None;
        match self.recv.capture_video(&mut video_data, u32::MAX) {
            FrameType::Video => {
                if let Some(video_data) = video_data {
                    tracing::debug!("Received video frame: {video_data:?}");
                    self.width = video_data.width();
                    self.height = video_data.height();
                    self.frame_rate = video_data.frame_rate();

                    Ok(NdiFrame(video_data))
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

#[cfg(not(feature = "enable"))]
impl NdiSource {
    pub fn width(&self) -> u32 {
        0
    }

    pub fn height(&self) -> u32 {
        0
    }

    pub fn frame_rate(&self) -> f32 {
        0f32
    }

    pub fn frame(&mut self) -> anyhow::Result<NdiFrame> {
        anyhow::bail!("NDI support is not enabled")
    }
}

#[cfg(feature = "enable")]
pub struct NdiFrame(VideoData);

#[cfg(not(feature = "enable"))]
pub struct NdiFrame;

impl NdiFrame {
    #[cfg(not(feature = "enable"))]
    pub fn data(self) -> anyhow::Result<Vec<u8>> {
        anyhow::bail!("NDI support is not enabled")
    }

    #[cfg(feature = "enable")]
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

#[cfg(feature = "enable")]
fn decode<T: Pixel<Subpixel = u8> + 'static>(
    frame: Vec<u8>,
    video_data: VideoData,
) -> anyhow::Result<ImageBuffer<T, Vec<u8>>> {
    let image =
        image::ImageBuffer::<T, _>::from_vec(video_data.width(), video_data.height(), frame)
            .ok_or_else(|| anyhow::anyhow!("Failed to create image"))?;

    Ok(image)
}
