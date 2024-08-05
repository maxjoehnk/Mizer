use crate::{ExtractDependenciesQuery, Serializer};
use serde::de::DeserializeOwned;
use serde::Serialize;
use std::any::Any;
use std::fmt::Debug;

pub trait Query<'a>: Debug + Send + Sized + Serialize + DeserializeOwned {
    type Dependencies: ExtractDependenciesQuery<'a>;
    type Result: Any + Send + Sync;

    fn query(
        &self,
        dependencies: <<Self as Query<'a>>::Dependencies as ExtractDependenciesQuery<'a>>::Type,
    ) -> anyhow::Result<Self::Result>;

    fn requires_main_loop(&self) -> bool {
        true
    }

    fn serialize<TSerializer: Serializer>(&self, serializer: &TSerializer) -> anyhow::Result<()> {
        serializer.serialize(&self)
    }
    fn try_deserialize<TDeserializer: Serializer>(
        serializer: &TDeserializer,
    ) -> anyhow::Result<Option<Self>> {
        serializer.try_deserialize()
    }
}
