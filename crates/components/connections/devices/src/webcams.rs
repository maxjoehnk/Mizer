use futures::stream::BoxStream;
use futures::StreamExt;

use mizer_webcams::{WebcamDiscovery, WebcamRef};

use crate::{Device, DeviceDiscovery, DeviceStatus};

impl DeviceDiscovery for WebcamDiscovery {
    type Device = WebcamRef;

    fn discover() -> BoxStream<'static, Self::Device> {
        let discovery = WebcamDiscovery::new();

        discovery.into_stream().boxed()
    }
}

impl Device for WebcamRef {
    fn status(&self) -> DeviceStatus {
        DeviceStatus::Connected
    }
}
