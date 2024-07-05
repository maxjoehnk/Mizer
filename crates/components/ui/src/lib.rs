use futures::prelude::*;

use mizer_message_bus::MessageBus;

use crate::dialog::Dialog;

#[derive(Clone)]
pub struct UiApi {
    bus: MessageBus<UiEvent>,
}

impl UiApi {
    pub fn new() -> Self {
        Self {
            bus: MessageBus::new(),
        }
    }

    pub(crate) fn emit(&self, event: UiEvent) {
        self.bus.send(event);
    }

    pub fn subscribe_dialog(&self) -> impl Stream<Item = Dialog> {
        self.bus
            .subscribe()
            .into_stream()
            .filter_map(|event| async move {
                match event {
                    UiEvent::ShowDialog(dialog) => Some(dialog),
                }
            })
    }
}

#[derive(Clone)]
pub enum UiEvent {
    ShowDialog(Dialog),
}

pub mod dialog;
pub mod module;
