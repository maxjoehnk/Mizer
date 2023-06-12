use base64::Engine;
use serde::{Deserialize, Serialize};
use std::fmt::{Debug, Formatter};

#[derive(Clone, Deserialize, Serialize, PartialEq, Hash)]
pub struct Base64Image(String);

impl Debug for Base64Image {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_tuple("Base64Image")
            .field(&"<binary data>")
            .finish()
    }
}

impl Base64Image {
    pub fn from_buffer(buffer: Vec<u8>) -> Self {
        Self(base64::engine::general_purpose::STANDARD.encode(buffer))
    }

    pub fn try_to_buffer(&self) -> anyhow::Result<Vec<u8>> {
        let buffer = base64::engine::general_purpose::STANDARD.decode(&self.0)?;

        Ok(buffer)
    }
}
