use crate::{Device, DeviceDiscovery, DeviceStatus};
use futures::stream::{self, BoxStream, StreamExt};
use mizer_protocol_laser::{EtherDreamLaser, HeliosLaser, Laser, LaserFrame};

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
        let (mut sender, receiver) = tokio::sync::mpsc::channel(5);
        handle.spawn_blocking(move || {
            let ether_dreams = EtherDreamLaser::find_devices().unwrap();
            for device in ether_dreams {
                match device {
                    Ok(device) => sender.try_send(LaserDevice::EtherDream(device)).unwrap(),
                    Err(err) => {
                        log::error!("ether dream discovery failed: {:?}", err);
                        return;
                    }
                }
            }
        });

        receiver.boxed()
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

    fn discover() -> BoxStream<'static, Self::Device> {
        let helios = LaserDevice::discover_helios();
        let ether_dream = LaserDevice::discover_ether_dream();

        stream::select_all(vec![helios, ether_dream]).boxed()
    }
}
