use std::str::FromStr;

#[derive(Default, Debug, Clone)]
pub struct DmxValue(Option<InnerValue>);

#[derive(Debug, Clone)]
pub struct InnerValue {
    pub value: u32,
    pub byte_count: u8,
}

impl FromStr for DmxValue {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> anyhow::Result<Self> {
        if s == "None" {
            return Ok(Self(None));
        }
        let parts = s.split('/').collect::<Vec<_>>();
        anyhow::ensure!(parts.len() == 2, "Invalid DMX Value {s}");
        let value = u32::from_str(parts[0])?;
        let byte_count = u8::from_str(parts[1])?;

        Ok(Self(Some(InnerValue {
            value,
            byte_count,
        })))
    }
}

