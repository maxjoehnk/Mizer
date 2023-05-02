use enum_iterator::{all, Sequence};
use flume::{unbounded, Receiver, Sender};
use futures::Stream;
use gilrs::{GamepadId, Gilrs};
use pinboard::NonEmptyPinboard;
use std::collections::HashMap;
use std::fmt::Formatter;
use std::sync::Arc;
use std::time::Duration;

pub struct GamepadDiscoveryService {
    gilrs: Gilrs,
    connection_sender: Sender<GamepadRef>,
    gamepad_states: HashMap<GamepadId, Arc<NonEmptyPinboard<GamepadState>>>,
}

impl GamepadDiscoveryService {
    fn run(mut self) {
        for (id, gamepad) in self.gilrs.gamepads() {
            let state = GamepadState::new(&gamepad);
            let state = Arc::new(NonEmptyPinboard::new(state));
            self.gamepad_states.insert(id, state.clone());
            let gamepad = GamepadRef::new(id, gamepad, state);
            self.connection_sender.send(gamepad).unwrap();
        }
        loop {
            while let Some(event) = self.gilrs.next_event() {
                log::trace!("{:?}", event);
                if let Some(gamepad_state) = self.gamepad_states.get(&event.id) {
                    let mut state = gamepad_state.read();
                    state.update(&self.gilrs.gamepad(event.id));
                    gamepad_state.set(state);
                }
            }
            std::thread::sleep(Duration::from_millis(50));
        }
    }
}

pub struct GamepadDiscovery {
    connections: Receiver<GamepadRef>,
}

impl GamepadDiscovery {
    // As this will spawn a background thread initializing a new instance of this struct should be explicit.
    #[allow(clippy::new_without_default)]
    pub fn new() -> Self {
        let (sender, receiver) = unbounded();
        std::thread::spawn(move || {
            let service = GamepadDiscoveryService {
                gilrs: Gilrs::new()
                    .map_err(|err| anyhow::anyhow!("Can't create Gamepad context {:?}", err))
                    .unwrap(),
                connection_sender: sender,
                gamepad_states: Default::default(),
            };
            service.run();
        });

        GamepadDiscovery {
            connections: receiver,
        }
    }

    pub fn into_stream(self) -> impl Stream<Item = GamepadRef> {
        self.connections.into_stream()
    }
}

#[derive(Clone, Debug)]
pub struct GamepadRef {
    id: GamepadId,
    name: String,
    state: Arc<NonEmptyPinboard<GamepadState>>,
}

impl GamepadRef {
    pub fn new(
        id: GamepadId,
        gamepad: gilrs::Gamepad,
        state: Arc<NonEmptyPinboard<GamepadState>>,
    ) -> Self {
        Self {
            id,
            name: gamepad.name().to_string(),
            state,
        }
    }

    pub fn name(&self) -> String {
        self.name.clone()
    }

    pub fn id(&self) -> u64 {
        let id: usize = self.id.into();
        id as u64
    }

    pub fn state(&self) -> GamepadState {
        self.state.read()
    }
}

#[derive(Clone)]
pub struct GamepadState {
    state: gilrs::ev::state::GamepadState,
    button_codes: HashMap<Button, gilrs::ev::Code>,
    axis_codes: HashMap<Axis, gilrs::ev::Code>,
}

impl GamepadState {
    fn new(gamepad: &gilrs::Gamepad<'_>) -> Self {
        let mut button_codes = HashMap::new();
        let mut axis_codes = HashMap::new();
        let state = gamepad.state().clone();
        for button in all::<Button>() {
            if let Some(code) = gamepad.button_code(button.into()) {
                button_codes.insert(button, code);
            }
        }
        for axis in all::<Axis>() {
            match axis.into() {
                gilrs::ev::AxisOrBtn::Axis(axis_gil) => {
                    if let Some(code) = gamepad.axis_code(axis_gil) {
                        axis_codes.insert(axis, code);
                    }
                }
                gilrs::ev::AxisOrBtn::Btn(btn) => {
                    if let Some(code) = gamepad.button_code(btn) {
                        axis_codes.insert(axis, code);
                    }
                }
            }
        }

        Self {
            state,
            button_codes,
            axis_codes,
        }
    }

    fn update(&mut self, gamepad: &gilrs::Gamepad<'_>) {
        self.state = gamepad.state().clone();
    }

    pub fn buttons(&self) -> Vec<Button> {
        self.button_codes.keys().copied().collect()
    }

    pub fn axes(&self) -> Vec<Axis> {
        self.axis_codes.keys().copied().collect()
    }

    pub fn is_button_pressed(&self, button: Button) -> Option<bool> {
        self.button_codes
            .get(&button)
            .map(|code| self.state.is_pressed(*code))
    }

    pub fn axis_value(&self, axis: Axis) -> Option<f64> {
        self.axis_codes
            .get(&axis)
            .map(|code| self.state.value(*code) as f64)
    }
}

impl std::fmt::Debug for GamepadState {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let mut debug = f.debug_struct("GamepadState");
        for button in self.buttons() {
            debug.field(
                format!("{:?}", button).as_str(),
                &self.is_button_pressed(button),
            );
        }
        for axis in self.axes() {
            debug.field(format!("{:?}", axis).as_str(), &self.axis_value(axis));
        }

        debug.finish()
    }
}

#[derive(Sequence, Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Button {
    LeftShoulder,
    RightShoulder,
    South,
    East,
    North,
    West,
    Select,
    Start,
    Mode,
    DPadUp,
    DPadRight,
    DPadDown,
    DPadLeft,
    LeftStick,
    RightStick,
}

impl From<Button> for gilrs::Button {
    fn from(button: Button) -> Self {
        match button {
            Button::LeftShoulder => Self::LeftTrigger,
            Button::RightShoulder => Self::RightTrigger,
            Button::LeftStick => Self::LeftThumb,
            Button::RightStick => Self::RightThumb,
            Button::South => Self::South,
            Button::East => Self::East,
            Button::North => Self::North,
            Button::West => Self::West,
            Button::Select => Self::Select,
            Button::Start => Self::Start,
            Button::Mode => Self::Mode,
            Button::DPadUp => Self::DPadUp,
            Button::DPadRight => Self::DPadRight,
            Button::DPadDown => Self::DPadDown,
            Button::DPadLeft => Self::DPadLeft,
        }
    }
}

#[derive(Sequence, Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Axis {
    LeftStickX,
    LeftStickY,
    RightStickX,
    RightStickY,
    LeftTrigger,
    RightTrigger,
}

impl From<Axis> for gilrs::ev::AxisOrBtn {
    fn from(axis: Axis) -> Self {
        match axis {
            Axis::LeftStickX => Self::Axis(gilrs::Axis::LeftStickX),
            Axis::LeftStickY => Self::Axis(gilrs::Axis::LeftStickY),
            Axis::RightStickX => Self::Axis(gilrs::Axis::RightStickX),
            Axis::RightStickY => Self::Axis(gilrs::Axis::RightStickY),
            Axis::LeftTrigger => Self::Btn(gilrs::Button::LeftTrigger2),
            Axis::RightTrigger => Self::Btn(gilrs::Button::RightTrigger2),
        }
    }
}
