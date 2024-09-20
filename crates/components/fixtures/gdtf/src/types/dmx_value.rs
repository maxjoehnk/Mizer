use std::str::FromStr;
use mizer_fixtures::channels::FixtureValue;

#[derive(Default, Debug, Clone, Copy)]
pub struct DmxValue(Option<InnerValue>);

#[derive(Debug, Clone, Copy)]
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

        Ok(Self(Some(InnerValue { value, byte_count })))
    }
}

impl DmxValue {
    pub fn to_fixture_value(&self) -> Option<FixtureValue> {
        let value = self.0?;
        let value = match value.byte_count {
            1 => Some(value.value as f64 / u8::MAX as f64),
            2 => Some(value.value as f64 / u16::MAX as f64),
            3 => Some(value.value as f64 / 16777215.0),
            4 => Some(value.value as f64 / u32::MAX as f64),
            _ => None,
        }?;
        
        Some(FixtureValue::Percent(value))
    }
}