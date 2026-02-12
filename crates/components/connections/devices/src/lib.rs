use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;

use dashmap::mapref::one::{RefMut};
use dashmap::DashMap;
use derive_more::From;
use futures::prelude::stream::BoxStream;
use futures::stream::select_all;
use futures::StreamExt;
use mizer_gamepads::GamepadState;
use mizer_module::Connections;
use mizer_traktor_kontrol_x1::{TraktorX1Discovery, TraktorX1Ref};

pub use crate::module::*;

pub mod traktor_kontrol_x1;

mod module;

pub trait Device {
    fn status(&self) -> DeviceStatus;
}

pub enum DeviceStatus {
    Connected,
    Disconnected,
}

pub trait DeviceDiscovery {
    type Device: Device;

    fn discover(settings: &Connections) -> BoxStream<'static, Self::Device>;
}

#[derive(From)]
enum DiscoveredDevice {
    TraktorX1(TraktorX1Ref),
}

#[derive(Default, Clone)]
pub struct DeviceManager {
    traktor_kontrol_x1_id_counter: Arc<AtomicUsize>,
    traktor_kontrol_x1s: Arc<DashMap<String, TraktorX1Ref>>,
}

impl DeviceManager {
    pub fn new() -> Self {
        Default::default()
    }

    pub async fn start_discovery(self, settings: Connections) {
        tracing::debug!("Starting device discovery...");
        let traktor_x1s = TraktorX1Discovery::discover(&settings)
            .map(DiscoveredDevice::from)
            .boxed_local();

        let mut devices = select_all([
            traktor_x1s,
        ]);
        while let Some(device) = devices.next().await {
            match device {
                DiscoveredDevice::TraktorX1(x1) => {
                    let id = self
                        .traktor_kontrol_x1_id_counter
                        .fetch_add(1, Ordering::Relaxed);
                    let id = format!("traktor-kontrol-x1-{}", id);
                    tracing::debug!("Discovered device {x1:?} => {id}");
                    self.traktor_kontrol_x1s.insert(id, x1);
                }
            }
        }
    }

    pub fn get_x1_mut(&self, id: &str) -> Option<RefMut<'_, String, TraktorX1Ref>> {
        self.traktor_kontrol_x1s.get_mut(id)
    }

    pub fn current_devices(&self) -> Vec<DeviceRef> {
        profiling::scope!("DeviceManager::current_devices");
        let traktor_kontrol_x1s = self.traktor_kontrol_x1s.iter().map(|x1| {
            TraktorKontrolX1View {
                id: x1.key().clone(),
            }
        });

        vec![]
    }
}

#[derive(Debug, Clone)]
pub struct HeliosView {
    pub id: String,
    pub name: Arc<String>,
    pub firmware: u32,
}

#[derive(Debug, Clone)]
pub struct EtherDreamView {
    pub id: String,
    pub name: Arc<String>,
}

#[derive(Debug, Clone)]
pub struct GamepadView {
    pub id: String,
    pub name: Arc<String>,
    pub state: GamepadState,
}

#[derive(From, Debug, Clone)]
pub enum DeviceRef {
    Webcam(WebcamView),
    TraktorKontrolX1(TraktorKontrolX1View),
}

#[derive(Debug, Clone)]
pub struct G13View {
    pub id: String,
}

#[derive(Debug, Clone)]
pub struct WebcamView {
    pub id: String,
    pub name: Arc<String>,
}

#[derive(Debug, Clone)]
pub struct NdiSourceView {
    pub id: String,
    pub name: Arc<String>,
}

#[derive(Debug, Clone)]
pub struct TraktorKontrolX1View {
    pub id: String,
}
