use crate::models::*;

#[derive(Clone)]
pub struct ConnectionsHandler {

}

impl ConnectionsHandler {
    pub fn new() -> Self {
        Self {}
    }

    pub fn get_connections(&self) -> Connections {
        Default::default()
    }
}
