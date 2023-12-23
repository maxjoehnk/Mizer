pub struct NdiSender;

impl NdiSender {
    pub fn new(_name: String) -> anyhow::Result<Self> {
        Ok(Self)
    }

    pub fn set_name(&mut self, _name: &str) -> anyhow::Result<()> {
        Ok(())
    }

    pub fn queue_frame(&self, _width: i32, _height: i32, _fps: f64, _buffer: &mut [u8]) {}
}
