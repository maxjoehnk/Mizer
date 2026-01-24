use crate::{Device, DeviceDiscovery, DeviceStatus};
use futures::stream::BoxStream;
use futures::{stream, StreamExt};
use mizer_module::Connections;
use mizer_traktor_kontrol_x1::{TraktorX1Discovery, TraktorX1Ref};

impl DeviceDiscovery for TraktorX1Discovery {
    type Device = TraktorX1Ref;

    fn discover(settings: &Connections) -> BoxStream<'static, Self::Device> {
        match TraktorX1Discovery::new() {
            Err(err) => {
                tracing::error!("Discovery of Traktor Kontrol X1 devices failed: {err:?}");

                stream::empty().boxed()
            }
            Ok(discovery) => discovery.into_stream().boxed(),
        }
    }
}

impl Device for TraktorX1Ref {
    fn status(&self) -> DeviceStatus {
        DeviceStatus::Connected
    }
}
