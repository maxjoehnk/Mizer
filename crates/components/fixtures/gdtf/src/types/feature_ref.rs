use std::str::FromStr;
use serde_derive::Serialize;

#[derive(Debug, Clone, Hash, PartialEq, Eq, Serialize)]
pub struct FeatureRef {
    pub group: String,
    pub feature: String,
}

impl FromStr for FeatureRef {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> anyhow::Result<Self> {
        let parts = s.split('.').collect::<Vec<_>>();
        anyhow::ensure!(parts.len() == 2, "Invalid Feature Reference {s}");

        Ok(Self {
            group: parts[0].to_string(),
            feature: parts[1].to_string(),
        })
    }
}
