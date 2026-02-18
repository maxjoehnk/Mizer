use std::any::{Any, TypeId};
use std::collections::HashMap;
use std::sync::Arc;
use crate::{ConnectionId, IConnection, StableConnectionId, TransmissionState, TransmissionStateReceiver};
use crate::queries::Component;
use crate::sparse_set::{BoxedSparseSet, EntityId, SparseSet};
use crate::transmissions::create_transmission_state;

#[derive(Default)]
pub struct ConnectionStorage {
    pub(crate) connection_ids: Vec<Option<ConnectionId>>,
    pub(crate) names: SparseSet<Name>,
    pub(crate) connections: Connections,
    // pub(crate) connections: Vec<Option<Connection>>,
    pub(crate) transmission_handles: Vec<Option<TransmissionStateReceiver>>,
    pub(crate) connection_types: HashMap<TypeId, Vec<EntityId>>,
}

#[derive(Clone)]
pub struct Name(pub Arc<String>);

impl Name {
    pub fn new(name: String) -> Self {
        Self(Arc::new(name))
    }
}

impl From<String> for Name {
    fn from(value: String) -> Self {
        Self::new(value)
    }
}

impl From<Name> for Arc<String> {
    fn from(value: Name) -> Self {
        value.0
    }
}

pub struct DeletedConnectionHandle {
    connection_id: ConnectionId,
    connection: Connection,
    transmission_handle: Option<TransmissionStateReceiver>,
    name: Option<Name>,
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
        let entity_id = EntityId(self.connection_ids.len());
        let type_id = self.connection_ids.iter().filter_map(|id| id.as_ref()).find(|id| id.connection_type == connection_type).map_or(0, |id| id.type_id) + 1;
        let id = ConnectionId { connection_type, type_id, entity_id };

        let (transmission_sender, transmission_receiver) = create_transmission_state();
        let connection = T::create(config, transmission_sender)?;
        self.connection_ids.push(Some(id));
        self.connections.insert(entity_id, connection);
        if let Some(name) = name {
            self.names.insert(entity_id, Name::new(name));
        }
        self.transmission_handles.push(Some(transmission_receiver));
        self.connection_types.entry(TypeId::of::<T>()).or_default().push(entity_id);

        Ok(id)
    }

    // Used for project loading
    pub fn add_connection<T: IConnection>(&mut self, id: StableConnectionId, config: T::Config, name: Option<String>) -> anyhow::Result<ConnectionId> {
        let connection_type = T::TYPE;
        let type_id = id.type_id();
        let entity_id = EntityId(self.connection_ids.len());
        let id = ConnectionId { connection_type, type_id, entity_id };

        let (transmission_sender, transmission_receiver) = create_transmission_state();
        let connection = T::create(config, transmission_sender)?;
        self.connection_ids.push(Some(id));
        self.connections.insert(entity_id, connection);
        if let Some(name) = name {
            self.names.insert(entity_id, Name::new(name));
        }
        self.transmission_handles.push(Some(transmission_receiver));
        self.connection_types.entry(TypeId::of::<T>()).or_default().push(entity_id);

        Ok(id)
    }

    pub fn delete_connection_by_stable(&mut self, stable_id: &StableConnectionId) -> Option<DeletedConnectionHandle> {
        self.delete_connection(&self.get_connection_id(stable_id)?)
    }

    pub fn delete_connection(&mut self, id: &ConnectionId) -> Option<DeletedConnectionHandle> {
        self.connection_ids[id.entity_id.0] = None;
        let transmission_handle = self.transmission_handles[id.entity_id.0].take();
        let name = self.names.remove(id.entity_id);
        let connection = self.connections.remove(id.entity_id)?;

        Some(DeletedConnectionHandle {
            connection_id: *id,
            connection,
            transmission_handle,
            name,
        })
    }

    pub fn delete_all_with<T: IConnection>(&mut self) {
        let ids = self.connections.ids::<T>().collect::<Vec<_>>();
        for entity_id in ids {
            self.names.remove(entity_id);
            self.connections.remove(entity_id);
            self.connection_ids[entity_id.0] = None;
            self.transmission_handles[entity_id.0] = None;
        }
    }

    pub fn get_connection_by_stable<T: IConnection>(&self, stable_id: &StableConnectionId) -> Option<&T> {
        self.get_connection(&self.get_connection_id(stable_id)?)
    }

    pub fn get_connection<T: IConnection>(&self, id: &ConnectionId) -> Option<&T> {
        T::get(self, id.entity_id)
    }

    pub fn get_connection_by_stable_mut<T: IConnection>(&mut self, stable_id: &StableConnectionId) -> Option<&mut T> {
        self.get_connection_mut(&self.get_connection_id(stable_id)?)
    }

    pub fn get_connection_mut<T: IConnection>(&mut self, id: &ConnectionId) -> Option<&mut T> {
        T::get_mut(self, id.entity_id)
    }

    pub fn get_connections<T: IConnection>(&self) -> Vec<&T> {
        T::iter(self).collect()
    }

    pub fn rename_connection_by_stable(&mut self, stable_id: &StableConnectionId, name: impl Into<Name>) -> Option<Name> {
        self.rename_connection(&self.get_connection_id(stable_id)?, name)
    }

    pub fn rename_connection(&mut self, id: &ConnectionId, name: impl Into<Name>) -> Option<Name> {
        self.names.insert(id.entity_id, name.into())
    }

    pub fn query<T: IConnection>(&self) -> Vec<(ConnectionId, Option<&Arc<String>>, &T)> {
        self.fetch::<(ConnectionId, Option<Name>, T)>()
            .into_iter()
            .map(|(id, name, connection)| (*id, name.as_ref().map(|name| &name.0), connection))
            .collect()
    }

    pub fn get_transmission_state(&self, id: &ConnectionId) -> Option<TransmissionState> {
        Some(self.transmission_handles.get(id.entity_id.0)?.as_ref()?.get_state())
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
        self.connection_ids[id.entity_id.0] = Some(id);
        self.connections.insert_dyn(id.entity_id, handle.connection);
        self.transmission_handles[id.entity_id.0] = handle.transmission_handle;
        if let Some(name) = handle.name {
            self.names.insert(id.entity_id, name);
        }
    }

    pub fn process_handles(&mut self) {
        for handle in self.transmission_handles.iter_mut().flatten() {
            handle.process();
        }
    }
}

#[derive(Default)]
pub(crate) struct Connections(HashMap<TypeId, BoxedSparseSet>);

impl Connections {
    pub fn insert<T: IConnection>(&mut self, entity_id: EntityId, connection: T) -> Option<T> {
        let sparse_set = self.0.entry(TypeId::of::<T>()).or_insert_with(|| SparseSet::<T>::new().boxed());
        sparse_set.downcast_mut().unwrap().insert(entity_id, connection)
    }

    pub fn get<T: IConnection>(&self, entity_id: EntityId) -> Option<&T> {
        self.0.get(&TypeId::of::<T>()).and_then(|set| set.downcast_ref::<T>()).and_then(|set| set.get(entity_id))
    }

    pub fn get_mut<T: IConnection>(&mut self, entity_id: EntityId) -> Option<&mut T> {
        self.0.get_mut(&TypeId::of::<T>()).and_then(|set| set.downcast_mut::<T>()).and_then(|set| set.get_mut(entity_id))
    }

    pub fn as_ref<T: IConnection>(&self) -> Option<&SparseSet<T>> {
        self.0.get(&TypeId::of::<T>()).and_then(|set| set.downcast_ref())
    }

    pub fn iter<T: IConnection>(&self) -> impl Iterator<Item = &T> {
        self.0.get(&TypeId::of::<T>()).into_iter().flat_map(|set| set.downcast_ref::<T>()).flat_map(|set| set.iter())
    }

    pub fn entities<T: IConnection>(&self) -> impl Iterator<Item = (EntityId, &T)> {
        self.0.get(&TypeId::of::<T>()).into_iter().flat_map(|set| set.downcast_ref::<T>()).flat_map(|set| set.entities())
    }

    pub fn ids<T: IConnection>(&self) -> impl Iterator<Item = EntityId> + use<'_, T> {
        self.0.get(&TypeId::of::<T>()).into_iter().flat_map(|set| set.downcast_ref::<T>()).flat_map(|set| set.ids())
    }

    pub fn remove(&mut self, entity_id: EntityId) -> Option<Connection> {
        self.0.iter_mut().find_map(|(_, set)| set.0.remove_dyn(entity_id).map(Connection))
    }

    pub fn insert_dyn(&mut self, entity_id: EntityId, connection: Connection) {
        if let Some(set) = self.0.get_mut(&connection.inner_type_id()) {
            set.0.insert_dyn(entity_id, connection.0);
        }
    }
}

pub struct Connection(Box<dyn Any>);

impl Connection {
    pub fn as_ref<T: IConnection>(&self) -> Option<&T> {
        self.0.downcast_ref::<T>()
    }

    pub fn is_type<T: IConnection>(&self) -> bool {
        self.0.is::<T>()
    }
}

impl Connection {
    fn new<T: IConnection>(connection: T) -> Self {
        Self(Box::new(connection))
    }

    fn inner_type_id(&self) -> TypeId {
        (*self.0).type_id()
    }
}

