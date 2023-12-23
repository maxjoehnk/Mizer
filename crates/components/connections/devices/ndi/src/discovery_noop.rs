use futures::Stream;
use crate::NdiSourceRef;

pub struct NdiSourceDiscovery;

impl NdiSourceDiscovery {
    pub fn new() -> anyhow::Result<Self> {
        Ok(Self)
    }

    pub fn into_stream(self) -> impl Stream<Item = Vec<NdiSourceRef>> {
        futures::stream::empty()
    }
}
