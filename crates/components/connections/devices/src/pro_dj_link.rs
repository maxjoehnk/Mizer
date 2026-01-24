use futures::stream::BoxStream;
use futures::{stream, FutureExt, StreamExt};
use mizer_module::Connections;
use mizer_protocol_pro_dj_link::{Device as _, ProDJLinkDevice, ProDJLinkDiscovery};

use crate::{Device, DeviceDiscovery, DeviceStatus};

impl DeviceDiscovery for ProDJLinkDiscovery {
    type Device = ProDJLinkDevice;

    fn discover(settings: &Connections) -> BoxStream<'static, Self::Device> {
        if !settings.pro_dj_link.enabled {
            return stream::empty().boxed();
        }

        ProDJLinkDiscovery::new()
            .into_stream()
            .flat_map(|discovery| match discovery {
                Ok(discovery) => discovery.into_stream().boxed(),
                Err(err) => {
                    tracing::error!("pro dj link discovery failed: {err:?}");

                    stream::empty().boxed()
                }
            })
            .boxed()
    }
}

impl Device for ProDJLinkDevice {
    fn status(&self) -> DeviceStatus {
        if self.is_online() {
            DeviceStatus::Connected
        } else {
            DeviceStatus::Disconnected
        }
    }
}
