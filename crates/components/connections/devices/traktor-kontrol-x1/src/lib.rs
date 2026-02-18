mod module;

use flume::{unbounded, Receiver, Sender, TryRecvError};
use futures::{SinkExt, Stream};
use pinboard::Pinboard;
use std::collections::HashMap;
use std::fmt::{Debug, Formatter};
use std::sync::Arc;
use std::time::Duration;
use traktor_kontrol_x1::{list_devices, TraktorX1, X1Error, X1State};
pub use traktor_kontrol_x1::{Button, DeckButton, DeckEncoder, Encoder, FxButton, FxKnob, Knob};
use mizer_connection_contracts::{IConnection, RemoteConnectionStorageHandle, TransmissionStateSender};

pub use module::TraktorX1Module;

#[derive(PartialEq, Eq, Hash)]
#[repr(transparent)]
struct TraktorX1InternalId(uuid::Uuid);

impl TraktorX1InternalId {
    fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

pub struct X1DiscoveryService {
    device_sender: RemoteConnectionStorageHandle<TraktorX1Ref>,
    states: HashMap<TraktorX1InternalId, TraktorX1State>,
}

struct TraktorX1State {
    device: TraktorX1,
    leds: HashMap<Button, u8>,
    state: Arc<Pinboard<X1State>>,
    receiver: Receiver<X1Command>,
}

impl TraktorX1State {
    fn new(
        device: TraktorX1,
        state: Arc<Pinboard<X1State>>,
        receiver: Receiver<X1Command>,
    ) -> Self {
        Self {
            device,
            leds: Default::default(),
            state,
            receiver,
        }
    }

    fn update(&mut self) -> anyhow::Result<()> {
        let response = self.device.read_state();
        if matches!(response, Err(X1Error::Timeout)) {
            return Ok(());
        }
        let response = response?;

        self.state.set(response);

        Ok(())
    }

    fn handle_commands(&mut self) -> anyhow::Result<()> {
        loop {
            match self.receiver.try_recv() {
                Ok(X1Command::WriteLed(button, enabled)) => {
                    let value = enabled * 127f64;
                    let value = value.round() as u8;
                    self.leds.insert(button, value);
                    if let Err(err) = self.device.write_leds(self.leds.iter()) {
                        tracing::error!("Unable to write Traktor Kontrol X1 leds: {err:?}");
                    }
                }
                Err(TryRecvError::Empty) => break,
                Err(err) => return Err(err.into()),
            }
        }

        Ok(())
    }
}

impl X1DiscoveryService {
    fn new(device_sender: RemoteConnectionStorageHandle<TraktorX1Ref>) -> anyhow::Result<Self> {
        Ok(Self {
            device_sender,
            states: Default::default(),
        })
    }

    fn run(mut self) {
        tracing::trace!("Discovering attached Traktor Kontrol X1 devices...");
        match list_devices() {
            Ok(devices) => {
                tracing::debug!("Found {} Traktor Kontrol X1 devices", devices.len());
                for x1 in devices {
                    let (sender, receiver) = unbounded();
                    let id = TraktorX1InternalId::new();
                    let response = Arc::new(Pinboard::new_empty());
                    let state = TraktorX1State::new(x1, response.clone(), receiver);
                    self.states.insert(id, state);

                    let x1_ref = TraktorX1Ref {
                        state: response,
                        sender,
                    };
                    if let Err(err) = self.device_sender.add_connection(x1_ref, None) {
                        tracing::error!("Unable to notify of new device {err:?}");
                    }
                }
            }
            Err(err) => {
                tracing::error!("Unable to discover Traktor Kontrol X1 devices: {err:?}");
                return;
            }
        }
        loop {
            for (_, state) in self.states.iter_mut() {
                if let Err(err) = state.update() {
                    tracing::error!("Unable to update x1 state: {err:?}");
                }
                if let Err(err) = state.handle_commands() {
                    tracing::error!("Unable to handle x1 commands: {err:?}");
                }
            }
            std::thread::sleep(Duration::from_millis(10));
        }
    }
}

pub fn discover_devices(handle: RemoteConnectionStorageHandle<TraktorX1Ref>) -> anyhow::Result<()> {
    let service = X1DiscoveryService::new(handle)?;
    std::thread::Builder::new()
        .name("Traktor X1 Discovery".to_string())
        .spawn(move || service.run())?;

    Ok(())
}

pub struct TraktorX1Ref {
    state: Arc<Pinboard<X1State>>,
    sender: Sender<X1Command>,
}

impl IConnection for TraktorX1Ref {
    type Config = Self;
    const TYPE: &'static str = "x1";

    fn create(config: Self::Config, transmission_sender: TransmissionStateSender) -> anyhow::Result<Self> {
        Ok(config)
    }
}

enum X1Command {
    WriteLed(Button, f64),
}

impl Debug for TraktorX1Ref {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct(stringify!(TraktorX1Ref)).finish()
    }
}

impl TraktorX1Ref {
    pub fn is_button_pressed(&self, button: Button) -> bool {
        if let Some(state) = self.state.read() {
            state.is_button_pressed(button)
        } else {
            false
        }
    }

    pub fn read_knob(&self, knob: Knob) -> Option<u16> {
        let state = self.state.read()?;

        Some(state.read_knob(knob))
    }

    pub fn write_led(&self, button: Button, value: f64) -> anyhow::Result<()> {
        self.sender.send(X1Command::WriteLed(button, value))?;

        Ok(())
    }
}
