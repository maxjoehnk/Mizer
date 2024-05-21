use crate::{ExtractDependencies, Serializer};
use serde::de::DeserializeOwned;
use serde::Serialize;
use std::any::Any;
use std::fmt::Debug;

pub trait Command<'a>: Debug + Send + Sized + Serialize + DeserializeOwned {
    type Dependencies: ExtractDependencies<'a>;
    type State: Any;
    type Result: Any + Send + Sync;

    fn label(&self) -> String;

    fn apply(
        &self,
        dependencies: <<Self as Command<'a>>::Dependencies as ExtractDependencies<'a>>::Type,
    ) -> anyhow::Result<(Self::Result, Self::State)>;
    fn revert(
        &self,
        dependencies: <<Self as Command<'a>>::Dependencies as ExtractDependencies<'a>>::Type,
        state: Self::State,
    ) -> anyhow::Result<()>;

    fn serialize<TSerializer: Serializer>(&self, serializer: &TSerializer) -> anyhow::Result<()> {
        serializer.serialize(&self)
    }
    fn try_deserialize<TDeserializer: Serializer>(
        serializer: &TDeserializer,
    ) -> anyhow::Result<Option<Self>> {
        serializer.try_deserialize()
    }
}
