use crate::models::*;

#[derive(Clone, Default)]
pub struct ConnectionsHandler {
}

impl ConnectionsHandler {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn get_connections(&self) -> Connections {
        Default::default()
    }
}
