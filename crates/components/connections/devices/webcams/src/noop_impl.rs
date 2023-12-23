use crate::WebcamSetting;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct WebcamRef;

impl WebcamRef {
    pub fn name(&self) -> String {
        unimplemented!()
    }

    pub fn id(&self) -> String {
        unimplemented!()
    }

    pub fn open(&self) -> anyhow::Result<Webcam> {
        anyhow::bail!("Webcam Support not enabled")
    }
}

pub struct Webcam;

impl Webcam {
    pub fn width(&self) -> u32 {
        unimplemented!()
    }

    pub fn height(&self) -> u32 {
        unimplemented!()
    }

    pub fn frame_rate(&self) -> u32 {
        unimplemented!()
    }

    pub fn settings(&self) -> anyhow::Result<Vec<WebcamSetting>> {
        anyhow::bail!("Webcam Support not enabled")
    }

    pub fn frame(&mut self) -> anyhow::Result<WebcamFrame> {
        anyhow::bail!("Webcam Support not enabled")
    }
}

pub struct WebcamFrame;

impl WebcamFrame {
    pub fn data(&self) -> anyhow::Result<Vec<u8>> {
        anyhow::bail!("Webcam Support not enabled")
    }
}
