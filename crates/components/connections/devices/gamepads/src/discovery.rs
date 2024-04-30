use std::collections::HashMap;
use std::sync::Arc;

use flume::{unbounded, Receiver, Sender};
use futures::Stream;
use gilrs::{EventType, GamepadId, Gilrs};
use pinboard::NonEmptyPinboard;

use crate::{GamepadRef, GamepadState};

struct GamepadDiscoveryService {
    gilrs: Gilrs,
    connection_sender: Sender<GamepadRef>,
    gamepad_states: HashMap<GamepadId, Arc<NonEmptyPinboard<GamepadState>>>,
}

impl GamepadDiscoveryService {
    fn run(mut self) {
        for id in self.gilrs.gamepads().map(|(id, _)| id).collect::<Vec<_>>() {
            self.add_gamepad(id);
        }

        loop {
            while let Some(event) = self.gilrs.next_event_blocking(None) {
                tracing::trace!("{:?}", event);
                if event.event == EventType::Connected {
                    self.add_gamepad(event.id);
                }
                if let Some(gamepad_state) = self.gamepad_states.get(&event.id) {
                    let mut state = gamepad_state.read();
                    state.update(&self.gilrs.gamepad(event.id));
                    gamepad_state.set(state);
                }
            }
        }
    }

    fn add_gamepad(&mut self, id: GamepadId) {
        let gamepad = self.gilrs.gamepad(id);
        mizer_console::debug!(
            mizer_console::ConsoleCategory::Connections,
            "Gamepad connected: {:?}",
            gamepad.name()
        );
        let state = GamepadState::new(&gamepad);
        let state = Arc::new(NonEmptyPinboard::new(state));
        self.gamepad_states.insert(id, state.clone());
        let gamepad = GamepadRef::new(id, gamepad, state);
        self.connection_sender.send(gamepad).unwrap();
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
