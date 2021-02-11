use bytes::{BufMut, BytesMut};
use mizer_node_api::Color;

const SET_PIXEL_COLORS: u8 = 0x00;

pub struct SetColors(pub(crate) u8, pub(crate) Vec<Color>);

impl SetColors {
    pub fn to_buffer(self) -> BytesMut {
        let data_len = self.1.len() * 3;
        let mut buffer = BytesMut::with_capacity(4 + data_len);
        buffer.put_slice(&[self.0, SET_PIXEL_COLORS]);
        buffer.put_u16(data_len as u16);

        for pixel in &self.1 {
            buffer.put_slice(&pixel.as_slice());
        }

        buffer
    }
}
