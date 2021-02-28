use bytes::{BufMut, BytesMut};
use std::convert::TryFrom;
use mizer_conversion::ConvertToDmx;

#[derive(Debug, Clone, Copy, Default)]
pub struct Color {
    pub red: u8,
    pub green: u8,
    pub blue: u8,
}

impl Color {
    pub fn as_slice(&self) -> [u8; 3] {
        [self.red, self.green, self.blue]
    }
}

pub struct PixelData(Vec<Color>);

impl TryFrom<Vec<f64>> for PixelData {
    type Error = anyhow::Error;

    fn try_from(data: Vec<f64>) -> anyhow::Result<Self> {
        let pixels = data.chunks_exact(3)
            .map(|bytes| (bytes[0], bytes[1], bytes[2]))
            .map(convert_colors)
            .collect();

        Ok(PixelData(pixels))
    }
}

fn convert_colors((r, g, b): (f64, f64, f64)) -> Color {
    Color {
        red: r.to_8bit(),
        green: g.to_8bit(),
        blue: b.to_8bit(),
    }
}

const SET_PIXEL_COLORS: u8 = 0x00;

pub struct SetColors(pub(crate) u8, pub(crate) PixelData);

impl SetColors {
    pub fn to_buffer(self) -> BytesMut {
        let data_len = self.1.0.len() * 3;
        let mut buffer = BytesMut::with_capacity(4 + data_len);
        buffer.put_slice(&[self.0, SET_PIXEL_COLORS]);
        buffer.put_u16(data_len as u16);

        for pixel in &self.1.0 {
            buffer.put_slice(&pixel.as_slice());
        }

        buffer
    }
}
