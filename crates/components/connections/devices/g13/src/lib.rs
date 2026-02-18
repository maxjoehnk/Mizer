use flume::{unbounded, Receiver, Sender, TryRecvError};
pub use module::G13Module;
pub use g13::Keys;
use g13::{G13Error, G13Manager, ModeLeds, Response, G13};
use pinboard::Pinboard;
use std::collections::HashMap;
use std::fmt::{Debug, Formatter};
use std::sync::Arc;
use std::time::Duration;
use mizer_connection_contracts::{IConnection, RemoteConnectionStorageHandle, TransmissionStateSender};

mod module;

#[derive(PartialEq, Eq, Hash)]
#[repr(transparent)]
struct G13InternalId(uuid::Uuid);

impl G13InternalId {
    fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

pub struct G13DiscoveryService {
    manager: G13Manager,
    device_sender: RemoteConnectionStorageHandle<G13Ref>,
    g13_states: HashMap<G13InternalId, G13State>,
}

struct G13State {
    device: G13,
    state: Arc<Pinboard<Response>>,
    receiver: Receiver<G13Command>,
}

impl G13State {
    fn new(device: G13, state: Arc<Pinboard<Response>>, receiver: Receiver<G13Command>) -> Self {
        Self {
            device,
            state,
            receiver,
        }
    }

    fn update(&mut self) -> anyhow::Result<()> {
        let response = self.device.read(Duration::from_millis(10));
        if matches!(response, Err(G13Error::Libusb(rusb::Error::Timeout))) {
            return Ok(());
        }
        let response = response?;
        self.state.set(response);

        Ok(())
    }

    fn handle_commands(&mut self) -> anyhow::Result<()> {
        loop {
            match self.receiver.try_recv() {
                Ok(G13Command::WriteKeyColor(red, green, blue)) => {
                    let red = (red * u8::MAX as f64).round() as u8;
                    let green = (green * u8::MAX as f64).round() as u8;
                    let blue = (blue * u8::MAX as f64).round() as u8;

                    self.device.set_key_color((red, green, blue))?;
                }
                Ok(G13Command::SetKeyState(m1, m2, m3, mr)) => {
                    let mut leds = ModeLeds::empty();
                    if m1 {
                        leds.insert(ModeLeds::M1)
                    };
                    if m2 {
                        leds.insert(ModeLeds::M2)
                    };
                    if m3 {
                        leds.insert(ModeLeds::M3)
                    };
                    if mr {
                        leds.insert(ModeLeds::MR)
                    };

                    self.device.set_mode_leds(leds)?;
                }
                Err(TryRecvError::Empty) => break,
                Err(err) => return Err(err.into()),
            }
        }

        Ok(())
    }
}

impl G13DiscoveryService {
    fn new(device_sender: RemoteConnectionStorageHandle<G13Ref>) -> anyhow::Result<Self> {
        Ok(Self {
            manager: G13Manager::new()?,
            device_sender,
            g13_states: Default::default(),
        })
    }

    fn run(mut self) {
        tracing::trace!("Discovering attached G13 devices...");
        match self.manager.discover() {
            Ok(devices) => {
                tracing::debug!("Found {} G13 devices", devices.len());
                for g13 in devices {
                    let (sender, receiver) = unbounded();
                    let id = G13InternalId::new();
                    let response = Arc::new(Pinboard::new_empty());
                    let state = G13State::new(g13, response.clone(), receiver);
                    self.g13_states.insert(id, state);

                    let g13_ref = G13Ref {
                        state: response,
                        sender,
                    };
                    if let Err(err) = self.device_sender.add_connection(g13_ref, None) {
                        tracing::error!("Unable to notify of new device {err:?}");
                    }
                }
            }
            Err(err) => {
                tracing::error!("Unable to discover G13 devices: {err:?}");
                return;
            }
        }
        loop {
            for (_, state) in self.g13_states.iter_mut() {
                if let Err(err) = state.update() {
                    tracing::error!("Unable to update g13 state: {err:?}");
                }
                if let Err(err) = state.handle_commands() {
                    tracing::error!("Unable to handle g13 commands: {err:?}");
                }
            }
            std::thread::sleep(Duration::from_millis(50));
        }
    }
}

pub struct G13Ref {
    state: Arc<Pinboard<Response>>,
    sender: Sender<G13Command>,
}

impl IConnection for G13Ref {
    type Config = Self;
    const TYPE: &'static str = "g13";

    fn create(config: Self::Config, _: TransmissionStateSender) -> anyhow::Result<Self> {
        Ok(config)
    }
}

enum G13Command {
    WriteKeyColor(f64, f64, f64),
    SetKeyState(bool, bool, bool, bool),
}

impl Debug for G13Ref {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct(stringify!(G13Ref)).finish()
    }
}

impl G13Ref {
    pub fn is_key_pressed(&self, key: Keys) -> bool {
        if let Some(state) = self.state.read() {
            state.keys.contains(key)
        } else {
            false
        }
    }

    pub fn joystick_x(&self) -> Option<f32> {
        let state = self.state.read()?;

        Some(state.joystick.0)
    }

    pub fn joystick_y(&self) -> Option<f32> {
        let state = self.state.read()?;

        Some(state.joystick.1)
    }

    pub fn write_key_color(&self, red: f64, green: f64, blue: f64) -> anyhow::Result<()> {
        self.sender
            .send(G13Command::WriteKeyColor(red, green, blue))?;

        Ok(())
    }

    pub fn set_key_state(&self, m1: bool, m2: bool, m3: bool, mr: bool) -> anyhow::Result<()> {
        self.sender.send(G13Command::SetKeyState(m1, m2, m3, mr))?;

        Ok(())
    }
}
