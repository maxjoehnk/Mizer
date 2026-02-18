use std::collections::HashSet;
use std::sync::{Arc, Mutex};
use std::sync::atomic::Ordering;
use std::str::FromStr;
use dashmap::DashMap;
use crate::{IConnection, RemoteConnectionStorageHandle, StableConnectionId, TransmissionState};
use crate::storage_commands::IRemoteConnectionStorageReceiver;

#[derive(Default, Clone)]
pub struct ConnectionStorageView {
    remote_handles: Arc<Mutex<Vec<Box<dyn IRemoteConnectionStorageReceiver>>>>,
    transmission_state: Arc<DashMap<StableConnectionId, TransmissionState>>,
}

impl ConnectionStorageView {
    pub fn remote_access<T: IConnection>(&self) -> RemoteConnectionStorageHandle<T> where T::Config: Send + Sync {
        let (handle, receiver) = RemoteConnectionStorageHandle::<T>::create();

        let mut handles = self.remote_handles.lock().unwrap();
        handles.push(Box::new(receiver));

        handle
    }

    pub fn process_handles(&self, storage: &mut crate::ConnectionStorage) {
        let mut handles = self.remote_handles.lock().unwrap();
        for handle in handles.iter_mut() {
            if let Err(err) = handle.handle_command(storage) {
                tracing::error!("Error processing remote connection storage command: {err:?}");
            }
        }
    }

    pub fn update_transmission_states(&self, storage: &crate::ConnectionStorage) {
        let transmission_states = storage.get_transmission_states();
        let mut touched_ids = HashSet::new();
        for (id, states) in transmission_states {
            let stable_id = id.to_stable();
            touched_ids.insert(stable_id.clone());
            self.transmission_state.insert(stable_id, states);
        }
        let mut ids_to_remove = Vec::new();
        for handle in self.transmission_state.iter() {
            if !touched_ids.contains(handle.key()) {
                ids_to_remove.push(handle.key().clone());
            }
        }
        // Split so this doesn't deadlock
        for id in ids_to_remove {
            self.transmission_state.remove(&id);
        }
    }

    pub fn is_sending(&self, id: &str) -> Option<bool> {
        let id = StableConnectionId::from_str(id).ok()?;
        self.transmission_state
            .get(&id)
            .map(|state| state.sending.load(Ordering::Relaxed))
    }

    pub fn is_receiving(&self, id: &str) -> Option<bool> {
        let id = StableConnectionId::from_str(id).ok()?;
        self.transmission_state
            .get(&id)
            .map(|state| state.receiving.load(Ordering::Relaxed))
    }
}
