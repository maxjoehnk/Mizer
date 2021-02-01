use chashmap::{CHashMap, WriteGuard};
use crate::laser::LaserDevice;
use futures::stream::{BoxStream};
use std::sync::Arc;
use futures::StreamExt;
use std::sync::atomic::{AtomicUsize, Ordering};

pub mod laser {
    use mizer_protocol_laser::{HeliosLaser, EtherDreamLaser, Laser, LaserFrame};
    use crate::{Device, DeviceDiscovery, DeviceStatus};
    use futures::stream::{self, BoxStream, StreamExt};

    #[derive(Debug)]
    pub enum LaserDevice {
        EtherDream(EtherDreamLaser),
        Helios(HeliosLaser),
    }

    impl LaserDevice {
        fn discover_helios() -> BoxStream<'static, LaserDevice> {
            let helios_devices = HeliosLaser::find_devices().unwrap();
            let devices = helios_devices.into_iter().map(LaserDevice::Helios).collect::<Vec<_>>();

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
                        },
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
}

pub trait Device {
    fn status(&self) -> DeviceStatus;
}

pub enum DeviceStatus {
    Connected,
    Disconnected
}

pub trait DeviceDiscovery {
    type Device : Device;

    fn discover() -> BoxStream<'static, Self::Device>;
}

#[derive(Default, Clone)]
pub struct DeviceManager {
    laser_id_counter: Arc<AtomicUsize>,
    lasers: Arc<CHashMap<String, LaserDevice>>
}

impl DeviceManager {
    pub fn new() -> Self {
        Default::default()
    }

    pub async fn start_discovery(self) -> () {
        let mut lasers = LaserDevice::discover();
        while let Some(laser) = lasers.next().await {
            let id = self.laser_id_counter.fetch_add(1, Ordering::Relaxed);
            let id = format!("laser-{}", id);
            log::debug!("Discovered device {:?} => {}", &laser, &id);
            self.lasers.insert(id, laser);
        }
    }

    pub fn get_laser_mut(&self, id: &str) -> Option<WriteGuard<String, LaserDevice>> {
        self.lasers.get_mut(id)
    }
}
