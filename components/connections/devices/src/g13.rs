use crate::{Device, DeviceDiscovery, DeviceStatus};
use futures::stream::BoxStream;
use futures::{stream, StreamExt};
use mizer_g13::{G13Discovery, G13Ref};

impl DeviceDiscovery for G13Discovery {
    type Device = G13Ref;

    fn discover() -> BoxStream<'static, Self::Device> {
        match G13Discovery::new() {
            Err(err) => {
                log::error!("Discovery of G13 devices failed: {err:?}");

                stream::empty().boxed()
            }
            Ok(discovery) => discovery.into_stream().boxed(),
        }
    }
}

impl Device for G13Ref {
    fn status(&self) -> DeviceStatus {
        DeviceStatus::Connected
    }
}
