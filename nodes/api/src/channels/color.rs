use super::{GenericChannel, GenericSender};

#[derive(Debug, Clone, Copy, Default)]
pub struct Color {
    pub r: u8,
    pub g: u8,
    pub b: u8,
}

impl Color {
    pub const BLACK: Color = Color::new(0, 0, 0);
    pub const WHITE: Color = Color::new(255, 255, 255);

    pub const fn new(r: u8, g: u8, b: u8) -> Self {
        Color { r, g, b }
    }

    pub fn as_slice(&self) -> [u8; 3] {
        [self.r, self.g, self.b]
    }
}

pub type ColorChannel = GenericChannel<Color>;
pub type ColorSender = GenericSender<Color>;
