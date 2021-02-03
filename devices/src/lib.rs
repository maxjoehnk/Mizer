use chashmap::{CHashMap, WriteGuard};
use crate::laser::LaserDevice;
use futures::stream::{BoxStream};
use std::sync::Arc;
use futures::StreamExt;
use std::sync::atomic::{AtomicUsize, Ordering};

pub mod laser;

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
