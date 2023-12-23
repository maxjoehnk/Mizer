use ndi::{FourCCVideoType, VideoData};

pub struct NdiSender {
    send: ndi::Send,
    name: String,
    frame: Option<VideoData>,
}

impl NdiSender {
    pub fn new(name: String) -> anyhow::Result<Self> {
        let send = ndi::SendBuilder::new().ndi_name(name.clone()).build()?;

        Ok(Self {
            send,
            name,
            frame: None,
        })
    }

    pub fn set_name(&mut self, name: &str) -> anyhow::Result<()> {
        if self.name == name {
            return Ok(());
        }
        let name = name.to_string();
        tracing::debug!("Changing name to {name}");
        self.send = ndi::SendBuilder::new().ndi_name(name.clone()).build()?;
        self.name = name;

        Ok(())
    }

    pub fn queue_frame(&mut self, width: i32, height: i32, fps: f64, buffer: &mut [u8]) {
        profiling::scope!("NdiOutputState::queue_frame");
        tracing::trace!("sending frame via ndi");
        let video_data = {
            profiling::scope!("ndi::VideoData::from_buffer");
            VideoData::from_buffer(
                width,
                height,
                FourCCVideoType::BGRA,
                fps.floor() as i32,
                1,
                ndi::FrameFormatType::Progressive,
                0,
                0,
                None,
                buffer,
            )
        };
        {
            profiling::scope!("ndi::Send::send_video");
            self.send.send_video_async(&video_data);
        }
        // Keep frame in memory until next frame is sent as they will be processed in the background
        self.frame = Some(video_data);
    }
}
