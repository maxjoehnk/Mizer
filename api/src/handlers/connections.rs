use std::collections::HashMap;

use crate::models::*;
use crate::RuntimeApi;

#[derive(Clone, Default)]
pub struct ConnectionsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> ConnectionsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    pub fn get_connections(&self) -> Connections {
        let connections = self
            .runtime
            .get_connections()
            .into_iter()
            .map(Connection::from)
            .collect();

        Connections {
            connections,
            ..Default::default()
        }
    }

    pub fn monitor_dmx(&self, output_id: String) -> anyhow::Result<HashMap<u16, [u8; 512]>> {
        self.runtime.get_dmx_monitor(output_id)
    }
}
