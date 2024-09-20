use std::num::ParseIntError;
use std::str::FromStr;
use mizer_fixtures::builder::DmxChannelBuilder;
use mizer_fixtures::channels::{DmxChannel, DmxChannels};

#[derive(Debug, Clone)]
pub struct DmxChannelOffset(Option<Vec<u16>>);

impl DmxChannelOffset {
    pub fn is_virtual(&self) -> bool {
        self.0.is_none()
    }

    pub fn into_channels(self) -> Vec<DmxChannelBuilder> {
        self.0.unwrap_or_default()
            .into_iter()
            .map(DmxChannel::new)
            .enumerate()
            .map(|(endianess, channel)| DmxChannelBuilder::new(endianess as u8, channel))
            .collect()
    }
}

impl FromStr for DmxChannelOffset {
    type Err = ParseIntError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        if s.is_empty() {
            return Ok(Self(None));
        }
        let offsets = s
            .split(',')
            .map(|offset_str| {
                let offset = u16::from_str(offset_str)?;
                let offset = offset - 1;
                if offset > 511 {
                    // Parse again so we throw the proper error
                    u8::from_str(offset_str)?;
                    unreachable!()
                } else {
                    Ok(offset)
                }
            })
            .collect::<Result<Vec<_>, Self::Err>>();

        match offsets {
            Err(err) => {
                eprintln!("{err:?} for input {s}");
                Err(err)
            }
            Ok(offsets) => Ok(Self(Some(offsets))),
        }
    }
}

impl From<DmxChannelOffset> for DmxChannels {
    fn from(offset: DmxChannelOffset) -> Self {
        let channels = offset.0.unwrap().into_iter().map(DmxChannel::new).collect::<Vec<_>>();
        let count = channels.len();
        match channels[..] {
            [coarse] => Self::Resolution8Bit { coarse },
            [coarse, fine] => Self::Resolution16Bit { coarse, fine },
            [coarse, fine, finest] => Self::Resolution24Bit { coarse, fine, finest },
            [coarse, fine, finest, ultra] => Self::Resolution32Bit { coarse, fine, finest, ultra },
            _ => unimplemented!("Unsupported offset count: {count}"),
        }
    }
}
