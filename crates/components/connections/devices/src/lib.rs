use std::sync::Arc;

use mizer_gamepads::GamepadState;

pub enum DeviceStatus {
    Connected,
    Disconnected,
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
