use std::collections::HashMap;

use crate::connection::{CitpConnectionHandle, CitpConnectionId};

pub struct CitpConnectionManager {
    receiver: flume::Receiver<CitpConnectionHandle>,
    connections: HashMap<CitpConnectionId, CitpConnectionHandle>,
}

impl CitpConnectionManager {
    pub fn new(receiver: flume::Receiver<CitpConnectionHandle>) -> anyhow::Result<Self> {
        Ok(Self {
            connections: Default::default(),
            receiver,
        })
    }

    pub(crate) fn process_updates(&mut self) {
        while let Ok(handle) = self.receiver.try_recv() {
            tracing::debug!("Received connection handle: {handle:?}");
            self.connections.insert(handle.id, handle);
        }
    }

    pub fn list_connections(&self) -> Vec<CitpConnectionHandle> {
        self.connections.values().cloned().collect()
    }
}
