use futures::{Stream, StreamExt};
use mizer_console::ConsoleHistory;

use crate::proto::console::*;

#[derive(Clone)]
pub struct ConsoleHandler {
    console_history: ConsoleHistory,
}

impl ConsoleHandler {
    pub fn new(console_history: ConsoleHistory) -> Self {
        Self { console_history }
    }

    pub fn get_console_history(&self) -> Vec<ConsoleMessage> {
        self.console_history
            .get_history()
            .into_iter()
            .map(ConsoleMessage::from)
            .collect()
    }

    pub fn observe_console(&self) -> impl Stream<Item = ConsoleMessage> {
        let subscriber = self.console_history.subscribe();
        subscriber.into_stream().map(ConsoleMessage::from)
    }
}
