use super::{GenericChannel, GenericSender};
use crate::Color;

pub type Pixels = Vec<Color>;

pub struct PixelChannel {
    pub back_channel: GenericSender<(u64, u64)>,
    pub receiver: GenericChannel<Pixels>,
}

pub struct PixelSender {
    back_channel: GenericChannel<(u64, u64)>,
    sender: GenericSender<Pixels>,
    dimensions: (u64, u64)
}

impl PixelChannel {
    pub fn new() -> (PixelSender, PixelChannel) {
        let back_channel = GenericChannel::new();
        let pixels = GenericChannel::new();

        let channel = PixelChannel {
            back_channel: back_channel.0,
            receiver: pixels.1
        };
        let sender = PixelSender {
            back_channel: back_channel.1,
            sender: pixels.0,
            dimensions: (0, 0),
        };

        (sender, channel)
    }
}

impl PixelSender {
    pub fn send(&self, msg: Pixels) {
        self.sender.send(msg);
    }

    pub fn dimensions(&self) -> (u64, u64) {
        self.dimensions
    }

    pub fn recv(&mut self) {
        if let Ok(Some(dimensions)) = self.back_channel.recv_last() {
            self.dimensions = dimensions;
        }
    }
}
