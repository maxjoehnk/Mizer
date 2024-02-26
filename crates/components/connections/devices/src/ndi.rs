use futures::stream::BoxStream;
use futures::StreamExt;

use mizer_ndi::{NdiSourceDiscovery, NdiSourceRef};

use crate::{Device, DeviceDiscovery, DeviceStatus};

impl DeviceDiscovery for NdiSourceDiscovery {
    type Device = NdiSourceRef;

    fn discover() -> BoxStream<'static, Self::Device> {
        match NdiSourceDiscovery::new() {
            Ok(discovery) => discovery
                .into_stream()
                .flat_map(futures::stream::iter)
                .boxed(),
            Err(err) => {
                tracing::error!("ndi discovery failed: {err:?}");

                futures::stream::empty().boxed()
            }
        }
    }
}

impl Device for NdiSourceRef {
    fn status(&self) -> DeviceStatus {
        DeviceStatus::Connected
    }
}
