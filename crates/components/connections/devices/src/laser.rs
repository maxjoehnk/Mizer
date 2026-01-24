use futures::stream::{self, BoxStream, StreamExt};
use mizer_module::Connections;
use mizer_protocol_laser::{EtherDreamLaser, HeliosLaser, Laser, LaserFrame};

use crate::{Device, DeviceDiscovery, DeviceStatus};

#[derive(Debug)]
pub enum LaserDevice {
    EtherDream(EtherDreamLaser),
    Helios(HeliosLaser),
}

impl LaserDevice {
    fn discover_helios() -> BoxStream<'static, LaserDevice> {
        let helios_devices = HeliosLaser::find_devices().unwrap();
        let devices = helios_devices
            .into_iter()
            .map(LaserDevice::Helios)
            .collect::<Vec<_>>();

        stream::iter(devices).boxed()
    }

    fn discover_ether_dream() -> BoxStream<'static, LaserDevice> {
        let handle = tokio::runtime::Handle::current();
        let (sender, receiver) = tokio::sync::mpsc::channel(5);
        handle.spawn_blocking(move || match EtherDreamLaser::find_devices() {
            Ok(ether_dreams) => {
                for device in ether_dreams {
                    match device {
                        Ok(device) => sender.try_send(LaserDevice::EtherDream(device)).unwrap(),
                        Err(err) => {
                            tracing::error!("ether dream discovery failed: {:?}", err);
                            return;
                        }
                    }
                }
            }
            Err(err) => {
                tracing::error!("ether dream discovery failed: {:?}", err);
            }
        });

        tokio_stream::wrappers::ReceiverStream::new(receiver).boxed()
    }
}

impl Laser for LaserDevice {
    fn write_frame(&mut self, frame: LaserFrame) -> anyhow::Result<()> {
        match self {
            LaserDevice::EtherDream(laser) => laser.write_frame(frame),
            LaserDevice::Helios(laser) => laser.write_frame(frame),
        }
    }
}

impl Device for LaserDevice {
    fn status(&self) -> DeviceStatus {
        DeviceStatus::Connected
    }
}

impl DeviceDiscovery for LaserDevice {
    type Device = LaserDevice;

    fn discover(settings: &Connections) -> BoxStream<'static, Self::Device> {
        let mut lasers = vec![
            LaserDevice::discover_helios()
        ];
        if settings.ether_dream.enabled {
            lasers.push(LaserDevice::discover_ether_dream());
        }

        stream::select_all(lasers).boxed()
    }
}
