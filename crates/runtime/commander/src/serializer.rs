use serde::de::DeserializeOwned;
use serde::Serialize;

pub trait Serializer {
    fn serialize<T: Serialize>(&self, data: &T) -> anyhow::Result<()>;
    fn try_deserialize<T: DeserializeOwned>(&self) -> anyhow::Result<Option<T>>;
}
