use std::net::Ipv4Addr;
use std::ops::{Deref, DerefMut};
use std::time::Instant;

use enum_dispatch::enum_dispatch;

pub use discovery::*;
use pro_dj_link::Speed;

mod discovery;
mod module;

#[enum_dispatch]
#[derive(Debug, Clone)]
pub enum ProDJLinkDevice {
    CDJ(CDJView),
    DJM(DJMView),
}

impl Deref for ProDJLinkDevice {
    type Target = DeviceView;

    fn deref(&self) -> &Self::Target {
        match self {
            Self::CDJ(view) => &view.device,
            Self::DJM(view) => &view.device,
        }
    }
}

impl DerefMut for ProDJLinkDevice {
    fn deref_mut(&mut self) -> &mut Self::Target {
        match self {
            Self::CDJ(view) => &mut view.device,
            Self::DJM(view) => &mut view.device,
        }
    }
}

#[enum_dispatch(ProDJLinkDevice)]
pub trait Device {
    fn is_online(&self) -> bool;
}

#[derive(Debug, Clone)]
pub struct DeviceView {
    pub name: String,
    pub last_ping: Instant,
    pub device_id: u8,
    pub ip_addr: Ipv4Addr,
    pub mac_addr: [u8; 6],
}

impl DeviceView {
    fn id(&self) -> String {
        format!("{:?}", self.mac_addr)
    }
}

#[derive(Debug, Clone)]
pub struct CDJView {
    pub device: DeviceView,
    speed: Speed,
    pub beat: u8,
    pub state: pro_dj_link::State,
}

impl CDJView {
    pub fn id(&self) -> String {
        let id = self.device.id();
        format!("cdj-{id}")
    }

    pub fn original_bpm(&self) -> i16 {
        self.speed.original
    }

    pub fn pitch(&self) -> i32 {
        self.speed.pitch
    }

    pub fn current_bpm(&self) -> f64 {
        self.speed.current()
    }

    pub fn is_live(&self) -> bool {
        self.state.intersects(pro_dj_link::State::ON_AIR)
    }

    pub fn is_playing(&self) -> bool {
        self.state.intersects(pro_dj_link::State::PLAYING)
    }
}

impl Device for CDJView {
    fn is_online(&self) -> bool {
        self.device.last_ping.elapsed().as_secs() < 5
    }
}

#[derive(Debug, Clone)]
pub struct DJMView {
    pub device: DeviceView,
}

impl DJMView {
    pub fn id(&self) -> String {
        let id = self.device.id();
        format!("djm-{id}")
    }
}

impl Device for DJMView {
    fn is_online(&self) -> bool {
        self.device.last_ping.elapsed().as_secs() < 5
    }
}
