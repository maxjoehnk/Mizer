use mizer_fixtures::definition::ChannelResolution;
use serde_derive::Serialize;
use std::str::FromStr;

#[derive(Debug, Clone, Serialize)]
pub struct DmxChannelOffset(pub Option<Vec<u16>>);

impl DmxChannelOffset {
    pub fn is_virtual(&self) -> bool {
        self.0.is_none()
    }
}

impl FromStr for DmxChannelOffset {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        if s.is_empty() {
            return Ok(Self(None));
        }
        let offsets = s
            .split(',')
            .map(|offset_str| {
                let offset = u16::from_str(offset_str)?;
                if offset == 0 {
                    anyhow::bail!("Offset cannot be 0");
                }
                let offset = offset - 1;
                if offset > 511 {
                    // Parse again so we throw the proper error
                    u8::from_str(offset_str)?;
                    Ok(0)
                } else {
                    Ok(offset)
                }
            })
            .collect::<Result<Vec<_>, Self::Err>>();

        match offsets {
            Err(err) => Err(err.context(format!("Parsing offset {s}"))),
            Ok(offsets) => Ok(Self(Some(offsets))),
        }
    }
}

impl From<DmxChannelOffset> for ChannelResolution {
    fn from(offset: DmxChannelOffset) -> Self {
        match &offset.0.unwrap()[..] {
            [coarse] => Self::Coarse(*coarse),
            [coarse, fine] => Self::Fine(*coarse, *fine),
            [coarse, fine, finest] => Self::Finest(*coarse, *fine, *finest),
            [coarse, fine, finest, ultra] => Self::Ultra(*coarse, *fine, *finest, *ultra),
            offset => unimplemented!("Unsupported offset {offset:?}"),
        }
    }
}
