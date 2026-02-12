use std::collections::HashMap;
use std::sync::Arc;

use flume::{unbounded, Receiver, Sender};
use futures::Stream;
use gilrs::{EventType, GamepadId, Gilrs};
use pinboard::NonEmptyPinboard;
use mizer_connection_contracts::RemoteConnectionStorageHandle;
use crate::{GamepadRef, GamepadState};

pub(crate) struct GamepadDiscoveryService {
    pub gilrs: Gilrs,
    pub connection_sender: RemoteConnectionStorageHandle<GamepadRef>,
    pub gamepad_states: HashMap<GamepadId, Arc<NonEmptyPinboard<GamepadState>>>,
}

impl GamepadDiscoveryService {
    pub fn run(mut self) {
        for id in self.gilrs.gamepads().map(|(id, _)| id).collect::<Vec<_>>() {
            self.add_gamepad(id);
        }

        loop {
            while let Some(event) = self.gilrs.next_event_blocking(None) {
                tracing::trace!("{:?}", event);
                if event.event == EventType::Connected {
                    self.add_gamepad(event.id);
                }
                if event.event == EventType::Disconnected {

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
        if let Err(err) = self.connection_sender.add_connection(state, Some(gamepad.name().to_string())) {
            tracing::error!("Can't add gamepad connection: {:?}", err);
        }
    }
}
