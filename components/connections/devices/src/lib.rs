use crate::laser::LaserDevice;
use futures::StreamExt;
use futures::stream::select_all;
use mizer_module::{Module, Runtime};
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Arc;
use dashmap::DashMap;
use dashmap::mapref::one::{Ref, RefMut};
use mizer_gamepads::{GamepadRef, GamepadDiscovery, GamepadState};
use derive_more::From;
use futures::prelude::stream::BoxStream;
use mizer_protocol_laser::{EtherDreamLaser, HeliosLaser};

pub mod laser;
pub mod gamepads;

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
}

#[derive(Default, Clone)]
pub struct DeviceManager {
    laser_id_counter: Arc<AtomicUsize>,
    lasers: Arc<DashMap<String, LaserDevice>>,
    gamepads: Arc<DashMap<String, GamepadRef>>,
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
        let mut devices = select_all([lasers, gamepads]);
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
            }
        }
    }

    pub fn get_laser_mut(&self, id: &str) -> Option<RefMut<'_, String, LaserDevice>> {
        self.lasers.get_mut(id)
    }

    pub fn get_gamepad(&self, id: &str) -> Option<Ref<'_, String, GamepadRef>> {
        self.gamepads.get(id)
    }

    pub fn current_devices(&self) -> Vec<DeviceRef> {
        let lasers = self.lasers.iter()
            .map(|laser| match laser.value() {
                LaserDevice::EtherDream(ether_dream) => EtherDreamView::from(ether_dream).into(),
                LaserDevice::Helios(helios) => HeliosView::from(helios).into(),
            });
        let gamepads = self.gamepads.iter()
            .map(|gamepad| GamepadView {
                id: gamepad.key().clone(),
                name: gamepad.name(),
                state: gamepad.state(),
            }.into());

        lasers.chain(gamepads).collect()
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
}

pub struct DeviceModule(DeviceManager);

impl DeviceModule {
    pub fn new() -> (Self, DeviceManager) {
        let manager = DeviceManager::new();

        (DeviceModule(manager.clone()), manager)
    }
}

impl Module for DeviceModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let injector = runtime.injector_mut();
        injector.provide(self.0);

        Ok(())
    }
}
