// TODO: contracts name isn't really fitting
use std::any::Any;
use std::fmt::{Display, Formatter};
use std::str::FromStr;
use anyhow::anyhow;
use serde_derive::{Deserialize, Serialize};

pub use storage::*;
pub use storage_commands::*;
pub use transmissions::*;
pub use view::*;

mod transmissions;
mod storage;
mod storage_commands;
mod view;

pub trait IConnection: Sized + Any + 'static {
    type Config;

    const TYPE: &'static str;

    fn create(config: Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self>;
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct ConnectionId {
    connection_type: &'static str,
    /// connection type specific id, used for serialization and references
    type_id: u32,
    entity_id: usize,
}

impl PartialEq<StableConnectionId> for ConnectionId {
    fn eq(&self, other: &StableConnectionId) -> bool {
        self.to_stable() == *other
    }
}

impl ConnectionId {
    pub fn to_stable(&self) -> StableConnectionId {
        StableConnectionId(format!("{self}"))
    }
}

impl Display for ConnectionId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}-{}", self.connection_type, self.type_id)
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, Deserialize, Serialize)]
#[serde(transparent)]
#[repr(transparent)]
pub struct StableConnectionId(String);

impl StableConnectionId {
    fn type_id(&self) -> u32 {
        self.0.split('-').nth(1).unwrap().parse::<u32>().unwrap()
    }
}

impl Display for StableConnectionId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.write_str(&self.0)
    }
}

impl FromStr for StableConnectionId {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        Self::try_from(s.to_string())
    }
}

impl TryFrom<String> for StableConnectionId {
    type Error = anyhow::Error;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        let mut split = value.split('-');
        let _type_name = split.next().ok_or_else(|| anyhow!("Invalid connection id: {value}"))?;
        let _type_id = split.next().ok_or_else(|| anyhow!("Invalid connection id: {value}"))?.parse::<u32>()?;
        if split.next().is_some() {
            return Err(anyhow!("Invalid connection id: {value}"));
        }

        Ok(Self(value))
    }
}
