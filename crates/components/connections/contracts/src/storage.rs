use std::any::{Any, TypeId};
use std::collections::HashMap;
use std::sync::Arc;
use crate::{ConnectionId, IConnection, StableConnectionId, TransmissionState, TransmissionStateReceiver};
use crate::transmissions::create_transmission_state;

#[derive(Default)]
pub struct ConnectionStorage {
    connection_ids: Vec<Option<ConnectionId>>,
    names: Vec<Option<Arc<String>>>,
    connections: Vec<Option<Connection>>,
    transmission_handles: Vec<Option<TransmissionStateReceiver>>,
    connection_types: HashMap<TypeId, Vec<usize>>,
}

pub struct DeletedConnectionHandle {
    connection_id: ConnectionId,
    connection: Connection,
    transmission_handle: Option<TransmissionStateReceiver>,
    name: Option<Arc<String>>,
}

impl DeletedConnectionHandle {
    pub fn get_connection_id(&self) -> ConnectionId {
        self.connection_id
    }

    pub fn get_connection(&self) -> &Connection {
        &self.connection
    }
}

impl ConnectionStorage {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn get_connection_id(&self, stable_id: &StableConnectionId) -> Option<ConnectionId> {
        // TODO: Check performance, maybe we should add a lookup table from stable id to connection id
        self.connection_ids.iter().filter_map(|id| id.as_ref()).find(|id| id == &stable_id).copied()
    }

    pub fn acquire_new_connection<T: IConnection>(&mut self, config: T::Config, name: Option<String>) -> anyhow::Result<ConnectionId> {
        let connection_type = T::TYPE;
        let entity_id = self.connection_ids.len();
        let type_id = self.connection_ids.iter().filter_map(|id| id.as_ref()).find(|id| id.connection_type == connection_type).map_or(0, |id| id.type_id) + 1;
        let id = ConnectionId { connection_type, type_id, entity_id };

        let (transmission_sender, transmission_receiver) = create_transmission_state();
        let connection = T::create(config, transmission_sender)?;
        self.connection_ids.push(Some(id));
        self.connections.push(Some(Connection::new(connection)));
        self.names.push(name.map(Arc::new));
        self.transmission_handles.push(Some(transmission_receiver));
        self.connection_types.entry(TypeId::of::<T>()).or_default().push(entity_id);

        Ok(id)
    }

    // Used for project loading
    pub fn add_connection<T: IConnection>(&mut self, id: StableConnectionId, config: T::Config, name: Option<String>) -> anyhow::Result<ConnectionId> {
        let connection_type = T::TYPE;
        let type_id = id.type_id();
        let entity_id = self.connection_ids.len();
        let id = ConnectionId { connection_type, type_id, entity_id };

        let (transmission_sender, transmission_receiver) = create_transmission_state();
        let connection = T::create(config, transmission_sender)?;
        self.connection_ids.push(Some(id));
        self.connections.push(Some(Connection::new(connection)));
        self.names.push(name.map(Arc::new));
        self.transmission_handles.push(Some(transmission_receiver));
        self.connection_types.entry(TypeId::of::<T>()).or_default().push(entity_id);

        Ok(id)
    }

    pub fn delete_connection_by_stable(&mut self, stable_id: &StableConnectionId) -> Option<DeletedConnectionHandle> {
        self.delete_connection(&self.get_connection_id(stable_id)?)
    }

    pub fn delete_connection(&mut self, id: &ConnectionId) -> Option<DeletedConnectionHandle> {
        self.connection_ids[id.entity_id] = None;
        let transmission_handle = self.transmission_handles[id.entity_id].take();
        let name = self.names[id.entity_id].take();
        let connection = self.connections[id.entity_id].take()?;

        Some(DeletedConnectionHandle {
            connection_id: *id,
            connection,
            transmission_handle,
            name,
        })
    }

    pub fn delete_all_with<T: IConnection>(&mut self) {
        let type_id = TypeId::of::<T>();
        let entity_ids = self.connection_types.remove(&type_id).unwrap_or_default();
        for entity_id in entity_ids {
            self.connection_ids[entity_id] = None;
            self.connections[entity_id] = None;
            self.transmission_handles[entity_id] = None;
            self.names[entity_id] = None;
        }
    }

    pub fn get_connection_by_stable<T: IConnection>(&self, stable_id: &StableConnectionId) -> Option<&T> {
        self.get_connection(&self.get_connection_id(stable_id)?)
    }

    pub fn get_connection<T: IConnection>(&self, id: &ConnectionId) -> Option<&T> {
        self.connections.get(id.entity_id).and_then(|c| c.as_ref()).filter(|Connection(type_id, _)| type_id == &TypeId::of::<T>())
            .and_then(|Connection(_, connection)| connection.downcast_ref::<T>())
    }

    pub fn get_connection_by_stable_mut<T: IConnection>(&mut self, stable_id: &StableConnectionId) -> Option<&mut T> {
        self.get_connection_mut(&self.get_connection_id(stable_id)?)
    }

    pub fn get_connection_mut<T: IConnection>(&mut self, id: &ConnectionId) -> Option<&mut T> {
        self.connections.get_mut(id.entity_id).and_then(|c| c.as_mut()).filter(|Connection(type_id, _)| type_id == &TypeId::of::<T>())
            .and_then(|Connection(_, connection)| connection.downcast_mut::<T>())
    }

    pub fn get_connections<T: IConnection>(&self) -> Vec<&T> {
        let Some(entity_ids) = self.connection_types.get(&TypeId::of::<T>()) else {
            return Vec::new();
        };
        return entity_ids.iter().filter_map(|entity_id| self.connections[*entity_id].as_ref()?.1.downcast_ref::<T>()).collect();
        // TODO: benchmark performance
        self.connections.iter().filter_map(|c| c.as_ref()).filter_map(|Connection(type_id, connection)| connection.downcast_ref::<T>().filter(|_| *type_id == TypeId::of::<T>())).collect()
    }

    pub fn rename_connection_by_stable(&mut self, stable_id: &StableConnectionId, name: String) -> Option<Arc<String>> {
        self.rename_connection(&self.get_connection_id(stable_id)?, name)
    }

    pub fn rename_connection(&mut self, id: &ConnectionId, name: String) -> Option<Arc<String>> {
        self.names[id.entity_id].replace(name.into())
    }

    pub fn query<T: IConnection>(&self) -> Vec<(ConnectionId, Option<&Arc<String>>, &T)> {
        self.connection_ids.iter()
            .zip(self.names.iter())
            .zip(self.connections.iter())
            .filter_map(|((id, name), connection)| {
                let id = *id.as_ref()?;
                connection.as_ref()?.as_ref::<T>().map(|connection| (id, name.as_ref(), connection))
            })
            .collect()
    }

    pub fn get_transmission_state(&self, id: &ConnectionId) -> Option<TransmissionState> {
        Some(self.transmission_handles.get(id.entity_id)?.as_ref()?.get_state())
    }

    pub(crate) fn get_transmission_states(&self) -> Vec<(ConnectionId, TransmissionState)> {
        self.connection_ids.iter()
            .zip(self.transmission_handles.iter())
            .filter_map(|(id, transmission_handle)| {
                let id = *id.as_ref()?;
                let transmission_handle = transmission_handle.as_ref()?;

                Some((id, transmission_handle.get_state()))
            }).collect()
    }

    pub fn restore_connection(&mut self, handle: DeletedConnectionHandle) {
        let id = handle.connection_id;
        self.connection_ids[id.entity_id] = Some(id);
        self.connections[id.entity_id] = Some(handle.connection);
        self.transmission_handles[id.entity_id] = handle.transmission_handle;
        self.names[id.entity_id] = handle.name;
    }

    pub fn process_handles(&mut self) {
        for handle in self.transmission_handles.iter_mut().flatten() {
            handle.process();
        }
    }
}

pub struct Connection(TypeId, Box<dyn Any>);

impl Connection {
    pub fn as_ref<T: IConnection>(&self) -> Option<&T> {
        self.1.downcast_ref::<T>()
    }
}

impl Connection {
    fn new<T: IConnection>(connection: T) -> Self {
        Self(TypeId::of::<T>(), Box::new(connection))
    }
}

