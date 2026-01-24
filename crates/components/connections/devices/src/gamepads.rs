use crate::{Device, DeviceDiscovery, DeviceStatus};
use futures::stream::BoxStream;
use futures::StreamExt;
use mizer_gamepads::{GamepadDiscovery, GamepadRef};
use mizer_module::Connections;

impl DeviceDiscovery for GamepadDiscovery {
    type Device = GamepadRef;

    fn discover(settings: &Connections) -> BoxStream<'static, Self::Device> {
        GamepadDiscovery::new().into_stream().boxed()
    }
}

impl Device for GamepadRef {
    fn status(&self) -> DeviceStatus {
        DeviceStatus::Connected
    }
}
