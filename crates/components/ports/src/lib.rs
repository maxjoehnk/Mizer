use mizer_util::rw_lock::{RwLock, RwLockReadGuard};
pub use module::PortsModule;
use serde::{Deserialize, Serialize};
use std::fmt::{Debug, Display, Formatter};
use std::ops::Deref;
use std::sync::Arc;

pub mod commands;
mod module;
pub mod queries;

const MAX_SIZE: usize = 1000;

#[derive(Clone)]
pub struct NodePortState {
    values: IndexedState<f64>,
    ports: IndexedState<NodePort>,
}

impl NodePortState {
    pub fn new() -> Self {
        Self {
            values: IndexedState::new(),
            ports: IndexedState::new(),
        }
    }

    pub fn get_port(&self, port: &NodePortId) -> Option<NodePort> {
        let guard = self.ports.get(*port);

        let value = guard.deref();

        value.clone()
    }

    pub fn read_value(&self, port: NodePortId) -> Option<f64> {
        let guard = self.values.get(port);

        let value = guard.deref();

        *value
    }

    pub fn write_value(&self, port: NodePortId, value: f64) {
        self.values.set(port, value);
    }

    pub fn list_ports(&self) -> Vec<NodePort> {
        self.ports
            .values
            .iter()
            .filter_map(|port| port.read().as_ref().cloned())
            .collect()
    }

    pub fn add_port(&self, name: Option<String>) -> NodePortId {
        let id = self
            .ports
            .values
            .iter()
            .flat_map(|p| p.read().as_ref().map(|p| p.id))
            .max()
            .map(|p| p.next())
            .unwrap_or(NodePortId(1));

        self.values.set(id, 0.0);
        self.ports.set(
            id,
            NodePort {
                id,
                label: Arc::new(name.unwrap_or_else(|| format!("Port {}", id.0))),
            },
        );

        id
    }

    pub fn delete_port(&self, port_id: NodePortId) -> Option<NodePort> {
        let port = self.ports.delete(port_id);
        self.values.delete(port_id);

        port
    }

    pub(crate) fn insert_port(&self, port_id: NodePortId, port: NodePort) {
        self.ports.set(port_id, port);
        self.values.set(port_id, 0.0);
    }

    pub fn load_ports(&self, ports: Vec<NodePort>) {
        for port in ports {
            self.insert_port(port.id, port);
        }
    }

    pub fn clear_ports(&self) {
        self.ports.clear();
        self.values.clear();
    }
}

#[derive(Clone)]
struct IndexedState<T> {
    values: Arc<Vec<RwLock<Option<T>>>>,
}

impl<T: Debug> IndexedState<T> {
    pub fn new() -> Self {
        let values = (0..MAX_SIZE).map(|_| RwLock::new(None)).collect();

        Self {
            values: Arc::new(values),
        }
    }

    pub fn get(&self, port: NodePortId) -> StateReadGuard<T> {
        if port.0 as usize > MAX_SIZE {
            tracing::warn!("Trying to exceed limit: {port}");
            return StateReadGuard::none();
        }
        assert!(port.0 as usize > 0, "Port ID must be greater than 0");
        let guard = self.values[port.0 as usize - 1].read();

        StateReadGuard(Some(guard))
    }

    pub fn set(&self, port: NodePortId, value: T) {
        if port.0 as usize > MAX_SIZE {
            tracing::warn!("Trying to exceed limit: {port}");
            return;
        }
        assert!(port.0 as usize > 0, "Port ID must be greater than 0");
        let mut guard = self.values[port.0 as usize - 1].write();
        *guard = Some(value);
    }

    pub fn delete(&self, port: NodePortId) -> Option<T> {
        if port.0 as usize > MAX_SIZE {
            tracing::warn!("Trying to exceed limit: {port}");
            return None;
        }
        assert!(port.0 as usize > 0, "Port ID must be greater than 0");
        let mut guard = self.values[port.0 as usize - 1].write();

        guard.take()
    }

    pub fn clear(&self) {
        for i in 0..MAX_SIZE {
            let mut guard = self.values[i].write();
            *guard = None;
        }
    }
}

pub struct StateReadGuard<'a, T>(Option<RwLockReadGuard<'a, Option<T>>>);

impl<'a, T> Deref for StateReadGuard<'a, T> {
    type Target = Option<T>;

    fn deref(&self) -> &Self::Target {
        if let Some(guard) = &self.0 {
            guard.deref()
        } else {
            &None
        }
    }
}

impl<'a, T> StateReadGuard<'a, T> {
    fn none() -> Self {
        Self(None)
    }
}

#[derive(
    Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, PartialOrd, Ord, Hash,
)]
#[serde(transparent)]
#[repr(transparent)]
pub struct NodePortId(pub u32);

impl NodePortId {
    pub fn is_default(&self) -> bool {
        self.0 == 0
    }

    fn next(&self) -> Self {
        Self(self.0 + 1)
    }
}

impl From<u32> for NodePortId {
    fn from(value: u32) -> Self {
        Self(value)
    }
}

impl Into<u32> for NodePortId {
    fn into(self) -> u32 {
        self.0
    }
}

impl Display for NodePortId {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "Port {}", self.0)
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq, Hash)]
pub struct NodePort {
    pub id: NodePortId,
    pub label: Arc<String>,
}
