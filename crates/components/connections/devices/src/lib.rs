use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;

use dashmap::mapref::one::{Ref, RefMut};
use dashmap::DashMap;
use derive_more::From;
use futures::prelude::stream::BoxStream;
use futures::stream::select_all;
use futures::StreamExt;

use mizer_g13::{G13Discovery, G13Ref};
use mizer_gamepads::{GamepadDiscovery, GamepadRef, GamepadState};
use mizer_module::{Module, Runtime};
use mizer_ndi::{NdiSourceDiscovery, NdiSourceRef};
use mizer_protocol_laser::{EtherDreamLaser, HeliosLaser};
use mizer_protocol_pro_dj_link::{CDJView, DJMView, ProDJLinkDevice, ProDJLinkDiscovery};
use mizer_webcams::{WebcamDiscovery, WebcamRef};

use crate::laser::LaserDevice;

pub mod g13;
pub mod gamepads;
pub mod laser;
pub mod ndi;
pub mod pro_dj_link;
pub mod webcams;

pub trait Device {
    fn status(&self) -> DeviceStatus;
}

pub enum DeviceStatus {
    Connected,
    Disconnected,
}

pub trait DeviceDiscovery {
    type Device: Device;

    fn discover() -> BoxStream<'static, Self::Device>;
}

#[derive(From)]
enum DiscoveredDevice {
    Laser(LaserDevice),
    Gamepad(GamepadRef),
    G13(G13Ref),
    Webcam(WebcamRef),
    NdiSource(NdiSourceRef),
    PioneerCDJ(CDJView),
    PioneerDJM(DJMView),
}

impl From<ProDJLinkDevice> for DiscoveredDevice {
    fn from(value: ProDJLinkDevice) -> Self {
        match value {
            ProDJLinkDevice::CDJ(view) => Self::PioneerCDJ(view),
            ProDJLinkDevice::DJM(view) => Self::PioneerDJM(view),
        }
    }
}

#[derive(Default, Clone)]
pub struct DeviceManager {
    laser_id_counter: Arc<AtomicUsize>,
    lasers: Arc<DashMap<String, LaserDevice>>,
    gamepads: Arc<DashMap<String, GamepadRef>>,
    g13_id_counter: Arc<AtomicUsize>,
    g13s: Arc<DashMap<String, G13Ref>>,
    webcams: Arc<DashMap<String, WebcamRef>>,
    ndi_sources: Arc<DashMap<String, NdiSourceRef>>,
    cdjs: Arc<DashMap<String, CDJView>>,
    djms: Arc<DashMap<String, DJMView>>,
}

impl DeviceManager {
    pub fn new() -> Self {
        Default::default()
    }

    pub async fn start_discovery(self) {
        log::debug!("Starting device discovery...");
        let lasers = LaserDevice::discover()
            .map(DiscoveredDevice::from)
            .boxed_local();
        let gamepads = GamepadDiscovery::discover()
            .map(DiscoveredDevice::from)
            .boxed_local();
        let g13s = G13Discovery::discover()
            .map(DiscoveredDevice::from)
            .boxed_local();
        let webcams = WebcamDiscovery::discover()
            .map(DiscoveredDevice::from)
            .boxed_local();
        let ndi_sources = NdiSourceDiscovery::discover()
            .map(DiscoveredDevice::from)
            .boxed_local();
        let pro_dj_link_devices = ProDJLinkDiscovery::discover()
            .map(DiscoveredDevice::from)
            .boxed_local();
        let mut devices = select_all([
            lasers,
            gamepads,
            g13s,
            webcams,
            ndi_sources,
            pro_dj_link_devices,
        ]);
        while let Some(device) = devices.next().await {
            match device {
                DiscoveredDevice::Laser(laser) => {
                    let id = self.laser_id_counter.fetch_add(1, Ordering::Relaxed);
                    let id = format!("laser-{}", id);
                    log::debug!("Discovered device {:?} => {}", &laser, &id);
                    self.lasers.insert(id, laser);
                }
                DiscoveredDevice::Gamepad(gamepad) => {
                    let id = gamepad.id();
                    let id = format!("gamepad-{}", id);
                    log::debug!("Discovered device {:?} => {}", &gamepad, &id);
                    self.gamepads.insert(id, gamepad);
                }
                DiscoveredDevice::G13(g13) => {
                    let id = self.g13_id_counter.fetch_add(1, Ordering::Relaxed);
                    let id = format!("g13-{}", id);
                    log::debug!("Discovered device {g13:?} => {id}");
                    self.g13s.insert(id, g13);
                }
                DiscoveredDevice::Webcam(webcam) => {
                    let id = webcam.id();
                    let id = format!("webcam-{}", id);
                    log::debug!("Discovered device {webcam:?} => {id}");
                    self.webcams.insert(id, webcam);
                }
                DiscoveredDevice::NdiSource(ndi_source) => {
                    let name = ndi_source.name();
                    let id = format!("ndi-source-{}", name);
                    if !self.ndi_sources.contains_key(&id) {
                        log::debug!("Discovered device {name} => {id}");
                        self.ndi_sources.insert(id, ndi_source);
                    }
                }
                DiscoveredDevice::PioneerCDJ(cdj) => {
                    let id = cdj.id();
                    if !self.cdjs.contains_key(&id) {
                        log::debug!("Discovered Pioneer CDJ {cdj:?}");
                    }
                    self.cdjs.insert(id, cdj);
                }
                DiscoveredDevice::PioneerDJM(djm) => {
                    let id = djm.id();
                    if !self.djms.contains_key(&id) {
                        log::debug!("Discovered Pioneer DJM {djm:?}");
                    }
                    self.djms.insert(id, djm);
                }
            }
        }
    }

    pub fn get_laser_mut(&self, id: &str) -> Option<RefMut<'_, String, LaserDevice>> {
        self.lasers.get_mut(id)
    }

    pub fn get_gamepad(&self, id: &str) -> Option<Ref<'_, String, GamepadRef>> {
        self.gamepads.get(id)
    }

    pub fn get_webcam(&self, id: &str) -> Option<Ref<'_, String, WebcamRef>> {
        self.webcams.get(id)
    }

    pub fn get_ndi_source(&self, id: &str) -> Option<Ref<'_, String, NdiSourceRef>> {
        self.ndi_sources.get(id)
    }

    pub fn get_g13_mut(&self, id: &str) -> Option<RefMut<'_, String, G13Ref>> {
        self.g13s.get_mut(id)
    }

    pub fn get_cdj(&self, id: &str) -> Option<Ref<'_, String, CDJView>> {
        self.cdjs.get(id)
    }

    pub fn current_devices(&self) -> Vec<DeviceRef> {
        profiling::scope!("DeviceManager::current_devices");
        let lasers = self.lasers.iter().map(|laser| match laser.value() {
            LaserDevice::EtherDream(ether_dream) => EtherDreamView::from(ether_dream).into(),
            LaserDevice::Helios(helios) => HeliosView::from(helios).into(),
        });
        let gamepads = self.gamepads.iter().map(|gamepad| {
            GamepadView {
                id: gamepad.key().clone(),
                name: gamepad.name(),
                state: gamepad.state(),
            }
            .into()
        });
        let g13s = self.g13s.iter().map(|g13| {
            G13View {
                id: g13.key().clone(),
            }
            .into()
        });
        let webcams = self.webcams.iter().map(|webcam| {
            WebcamView {
                id: webcam.key().clone(),
                name: webcam.name(),
            }
            .into()
        });
        let ndi_sources = self.ndi_sources.iter().map(|source| {
            NdiSourceView {
                id: source.key().clone(),
                name: source.name(),
            }
            .into()
        });
        let cdjs = self.cdjs.iter().map(|cdj| cdj.value().clone().into());
        let djms = self.djms.iter().map(|djm| djm.value().clone().into());

        lasers
            .chain(gamepads)
            .chain(g13s)
            .chain(webcams)
            .chain(ndi_sources)
            .chain(cdjs)
            .chain(djms)
            .collect()
    }
}

#[derive(Debug, Clone)]
pub struct HeliosView {
    pub name: String,
    pub firmware: u32,
}

impl From<&HeliosLaser> for HeliosView {
    fn from(laser: &HeliosLaser) -> Self {
        Self {
            name: laser.name.clone(),
            firmware: laser.firmware,
        }
    }
}

#[derive(Debug, Clone)]
pub struct EtherDreamView {
    pub name: String,
}

impl From<&EtherDreamLaser> for EtherDreamView {
    fn from(laser: &EtherDreamLaser) -> Self {
        let status = laser.status();
        Self {
            name: format!("EtherDream {}", status.mac_address),
        }
    }
}

#[derive(Debug, Clone)]
pub struct GamepadView {
    pub id: String,
    pub name: String,
    pub state: GamepadState,
}

#[derive(From, Debug, Clone)]
pub enum DeviceRef {
    Helios(HeliosView),
    EtherDream(EtherDreamView),
    Gamepad(GamepadView),
    G13(G13View),
    Webcam(WebcamView),
    NdiSource(NdiSourceView),
    PioneerCDJ(CDJView),
    PioneerDJM(DJMView),
}

#[derive(Debug, Clone)]
pub struct G13View {
    pub id: String,
}

#[derive(Debug, Clone)]
pub struct WebcamView {
    pub id: String,
    pub name: String,
}

#[derive(Debug, Clone)]
pub struct NdiSourceView {
    pub id: String,
    pub name: String,
}

pub struct DeviceModule(DeviceManager);

impl DeviceModule {
    pub fn new() -> (Self, DeviceManager) {
        let manager = DeviceManager::new();

        (DeviceModule(manager.clone()), manager)
    }
}

impl Module for DeviceModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector_mut();
        injector.provide(self.0);

        Ok(())
    }
}
