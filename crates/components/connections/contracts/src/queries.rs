use crate::{ConnectionId, ConnectionStorage, IConnection, Name};
use std::marker::PhantomData;
use crate::sparse_set::EntityId;

impl ConnectionStorage {
    pub fn fetch<'a, T: Query<'a>>(&'a self) -> Vec<T::Result> {
        profiling::scope!("ConnectionStorage::fetch");
        T::load(self).collect()
    }
}

pub trait Query<'a> {
    type Result;

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result>;
}

pub struct Has<T: Component>(PhantomData<T>);

pub struct Either<T1: Component, T2: Component>(PhantomData<(T1, T2)>);

pub(crate) trait Component {
    fn iter<'a>(storage: &'a ConnectionStorage) -> impl Iterator<Item = &'a Self>
    where
        Self: 'a;

    fn entities<'a>(storage: &'a ConnectionStorage) -> impl Iterator<Item = (EntityId, &'a Self)>
    where
        Self: 'a;

    fn get<'a>(storage: &'a ConnectionStorage, id: EntityId) -> Option<&'a Self>
    where
        Self: 'a;

    fn get_mut<'a>(storage: &'a mut ConnectionStorage, id: EntityId) -> Option<&'a mut Self>
    where
        Self: 'a;

    fn has(storage: &ConnectionStorage, entity_id: EntityId) -> bool;
}

impl Component for Name {
    fn iter<'a>(storage: &'a ConnectionStorage) -> impl Iterator<Item = &'a Self>
    where
        Self: 'a,
    {
        storage.names.iter()
    }

    fn entities<'a>(storage: &'a ConnectionStorage) -> impl Iterator<Item=(EntityId, &'a Self)>
    where
        Self: 'a
    {
        storage.names.entities()
    }

    fn get<'a>(storage: &'a ConnectionStorage, id: EntityId) -> Option<&'a Self>
    where
        Self: 'a,
    {
        storage.names.get(id)
    }

    fn get_mut<'a>(storage: &'a mut ConnectionStorage, id: EntityId) -> Option<&'a mut Self>
    where
        Self: 'a
    {
        storage.names.get_mut(id)
    }

    fn has(storage: &ConnectionStorage, entity_id: EntityId) -> bool {
        storage.names.get(entity_id).is_some()
    }
}

impl Component for ConnectionId {
    fn iter<'a>(storage: &'a ConnectionStorage) -> impl Iterator<Item = &'a Self>
    where
        Self: 'a,
    {
        storage.connection_ids.iter().filter_map(|name| name.as_ref())
    }

    fn entities<'a>(storage: &'a ConnectionStorage) -> impl Iterator<Item=(EntityId, &'a Self)>
    where
        Self: 'a
    {
        storage.connection_ids.iter()
            .filter_map(|id| id.as_ref())
            .map(|id| (id.entity_id, id))

    }

    fn get<'a>(storage: &'a ConnectionStorage, id: EntityId) -> Option<&'a Self>
    where
        Self: 'a
    {
        storage.connection_ids.get(id.0).and_then(|id| id.as_ref())
    }

    fn get_mut<'a>(storage: &'a mut ConnectionStorage, id: EntityId) -> Option<&'a mut Self>
    where
        Self: 'a
    {
        storage.connection_ids.get_mut(id.0).and_then(|id| id.as_mut())
    }

    fn has(storage: &ConnectionStorage, entity_id: EntityId) -> bool {
        storage.connection_ids[entity_id.0].is_some()
    }
}

impl<T> Component for T
where
    T: IConnection,
{
    fn iter<'a>(storage: &'a ConnectionStorage) -> impl Iterator<Item = &'a Self>
    where
        Self: 'a,
    {
        storage.connections.iter::<T>()
    }

    fn entities<'a>(storage: &'a ConnectionStorage) -> impl Iterator<Item=(EntityId, &'a Self)>
    where
        Self: 'a
    {
        storage.connections.entities::<T>()
    }

    fn get<'a>(storage: &'a ConnectionStorage, id: EntityId) -> Option<&'a Self>
    where
        Self: 'a
    {
        storage.connections.get::<T>(id)
    }

    fn get_mut<'a>(storage: &'a mut ConnectionStorage, id: EntityId) -> Option<&'a mut Self>
    where
        Self: 'a
    {
        storage.connections.get_mut::<T>(id)
    }

    fn has(storage: &ConnectionStorage, entity_id: EntityId) -> bool {
        storage.connections.get::<T>(entity_id).is_some()
    }
}

impl<'a, T: Component + 'a> Query<'a> for T {
    type Result = &'a T;

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result> {
        T::iter(storage)
    }
}

impl<'a, T1: Component + 'a, T2: Component + 'a> Query<'a> for (T1, Has<T2>) {
    type Result = &'a T1;

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result> {
        T1::entities(storage)
            .filter(|(entity_id, _)| T2::has(storage, *entity_id))
            .map(|(_, t1)| t1)
    }
}

impl<'a, T1: Component + 'a, T2: Component + 'a> Query<'a> for (T1, Option<T2>) {
    type Result = (&'a T1, Option<&'a T2>);

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result> {
        T1::entities(storage).map(|(entity_id, t1)| (t1, T2::get(storage, entity_id)))
    }
}

impl<'a, T1: Component + 'a, T2: Component + 'a> Query<'a> for (T1, T2) {
    type Result = (&'a T1, &'a T2);

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result> {
        T1::entities(storage).filter_map(|(entity_id, t1)| T2::get(storage, entity_id).map(|t2| (t1, t2)))
    }
}

impl<'a, T1: Component + 'a, T2: Component + 'a, T3: Component + 'a> Query<'a> for (T1, T2, Has<T3>) {
    type Result = (&'a T1, &'a T2);

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result> {
        T1::entities(storage)
            .filter(|(entity_id, _)| T3::has(storage, *entity_id))
            .filter_map(|(entity_id, t1)| T2::get(storage, entity_id).map(|t2| (t1, t2)))
    }
}

impl<'a, T1: Component + 'a, T2: Component + 'a, T3: Component + 'a, T4: Component + 'a> Query<'a> for (T1, T2, Either<T3, T4>) {
    type Result = (&'a T1, &'a T2);

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result> {
        T1::entities(storage)
            .filter(|(entity_id, _)| T3::has(storage, *entity_id) || T4::has(storage, *entity_id))
            .filter_map(|(entity_id, t1)| T2::get(storage, entity_id).map(|t2| (t1, t2)))
    }
}

impl<'a, T1: Component + 'a, T2: Component + 'a, T3: Component + 'a> Query<'a> for (T1, T2, T3) {
    type Result = (&'a T1, &'a T2, &'a T3);

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result> {
        T1::entities(storage)
            .filter_map(|(entity_id, t1)| T2::get(storage, entity_id).zip(T3::get(storage, entity_id)).map(|(t2, t3)| (t1, t2, t3)))
    }
}

impl<'a, T1: Component + 'a, T2: Component + 'a, T3: Component + 'a> Query<'a> for (T1, Option<T2>, T3) {
    type Result = (&'a T1, Option<&'a T2>, &'a T3);

    fn load(storage: &'a ConnectionStorage) -> impl Iterator<Item = Self::Result> {
        T1::entities(storage)
            .filter_map(|(entity_id, t1)| {
                let t2 = T2::get(storage, entity_id);
                let t3 = T3::get(storage, entity_id)?;

                Some((t1, t2, t3))
            })
    }
}
