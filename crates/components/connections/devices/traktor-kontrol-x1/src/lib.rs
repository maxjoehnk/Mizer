use flume::{unbounded, Receiver, Sender, TryRecvError};
use futures::Stream;
use pinboard::Pinboard;
use std::collections::HashMap;
use std::fmt::{Debug, Formatter};
use std::sync::Arc;
use std::time::Duration;
use traktor_kontrol_x1::{list_devices, TraktorX1, X1Error, X1State};
pub use traktor_kontrol_x1::{Button, DeckButton, DeckEncoder, Encoder, FxButton, FxKnob, Knob};

#[derive(PartialEq, Eq, Hash)]
#[repr(transparent)]
struct TraktorX1InternalId(uuid::Uuid);

impl TraktorX1InternalId {
    fn new() -> Self {
        Self(uuid::Uuid::new_v4())
    }
}

pub struct X1DiscoveryService {
    device_sender: Sender<TraktorX1Ref>,
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
    fn new(device_sender: Sender<TraktorX1Ref>) -> anyhow::Result<Self> {
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
                    if let Err(err) = self.device_sender.send(x1_ref) {
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

pub struct TraktorX1Discovery {
    devices: Receiver<TraktorX1Ref>,
}

impl TraktorX1Discovery {
    // As this will spawn a background thread initializing a new instance of this struct should be explicit.
    #[allow(clippy::new_without_default)]
    pub fn new() -> anyhow::Result<Self> {
        let (sender, receiver) = unbounded();
        let service = X1DiscoveryService::new(sender)?;
        std::thread::Builder::new()
            .name("Traktor X1 Discovery".to_string())
            .spawn(move || service.run())?;

        Ok(Self { devices: receiver })
    }

    pub fn into_stream(self) -> impl Stream<Item = TraktorX1Ref> {
        self.devices.into_stream()
    }
}

pub struct TraktorX1Ref {
    state: Arc<Pinboard<X1State>>,
    sender: Sender<X1Command>,
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
