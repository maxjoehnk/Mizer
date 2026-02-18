use std::net::Ipv4Addr;
use std::time::Instant;

use pro_dj_link::{Speed};

pub use discovery::*;
use mizer_connection_contracts::{ConnectionStorage, IConnection, TransmissionStateSender};
pub use module::*;

mod module;
mod discovery;

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

impl IConnection for CDJView {
    type Config = DeviceView;
    const TYPE: &'static str = "cdj";

    fn create(device: Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self> {
        Ok(CDJView {
            device,
            speed: Default::default(),
            beat: 1,
            state: Default::default(),
        })
    }
}

impl CDJView {
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

impl CDJView {
    fn is_online(&self) -> bool {
        self.device.last_ping.elapsed().as_secs() < 5
    }
}

#[derive(Debug, Clone)]
pub struct DJMView {
    pub device: DeviceView,
}

impl IConnection for DJMView {
    type Config = DeviceView;
    const TYPE: &'static str = "djm";

    fn create(device: Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self> {
        Ok(Self { device })
    }
}

impl DJMView {
    fn is_online(&self) -> bool {
        self.device.last_ping.elapsed().as_secs() < 5
    }
}

pub trait ProDjLinkExt {
    fn get_djm(&self) -> Option<DJMView>;
    fn get_cdj(&self, id: u8) -> Option<CDJView>;
}

impl ProDjLinkExt for ConnectionStorage {
    fn get_djm(&self) -> Option<DJMView> {
        self.fetch::<DJMView>()
            .into_iter()
            .next()
            .cloned()
    }

    fn get_cdj(&self, id: u8) -> Option<CDJView> {
        self.fetch::<CDJView>()
            .into_iter()
            .find(|cdj| cdj.device.device_id == id)
            .cloned()
    }
}
