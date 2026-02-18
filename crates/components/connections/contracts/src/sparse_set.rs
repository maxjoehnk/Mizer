use std::any::Any;

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
#[repr(transparent)]
pub struct EntityId(pub(crate) usize);

pub struct BoxedSparseSet(pub(crate) Box<dyn DynStorage>);

impl BoxedSparseSet {
    pub fn downcast_ref<T: Any>(&self) -> Option<&SparseSet<T>> {
        self.0.as_any().as_sparse_set::<T>()
    }

    pub fn downcast_mut<T: Any>(&mut self) -> Option<&mut SparseSet<T>> {
        self.0.as_any_mut().as_spare_set_mut::<T>()
    }
}

pub trait DynStorage: Any {
    fn insert_dyn(&mut self, entity_id: EntityId, component: Box<dyn Any>);
    fn remove_dyn(&mut self, entity_id: EntityId) -> Option<Box<dyn Any>>;
    fn clear(&mut self);

    fn as_any(&self) -> &dyn Any;

    fn as_any_mut(&mut self) -> &mut dyn Any;
}

trait DynStorageExt {
    fn as_sparse_set<T: Any>(&self) -> Option<&SparseSet<T>>;
    fn as_spare_set_mut<T: Any>(&mut self) -> Option<&mut SparseSet<T>>;
}

impl DynStorageExt for dyn Any {
    fn as_sparse_set<T: Any>(&self) -> Option<&SparseSet<T>> {
        self.downcast_ref::<SparseSet<T>>()
    }

    fn as_spare_set_mut<T: Any>(&mut self) -> Option<&mut SparseSet<T>> {
        self.downcast_mut::<SparseSet<T>>()
    }
}

pub(crate) struct SparseSet<T> {
    components: Vec<T>,
    entities: Vec<EntityId>,
    sparse_index: Vec<Option<usize>>,
}

impl<T> Default for SparseSet<T> {
    fn default() -> Self {
        Self {
            components: Vec::new(),
            entities: Vec::new(),
            sparse_index: Vec::new(),
        }
    }
}

impl<T> SparseSet<T> {
    pub fn new() -> Self {
        Self::default()
    }

    /// Will return the previous value if this entity already had the component attached
    pub fn insert(&mut self, entity_id: EntityId, component: T) -> Option<T> {
        let index = self.components.len();
        let id = entity_id.0;

        // Fill empty spaces
        if id >= self.sparse_index.len() {
            self.sparse_index.resize(id + 1, None);
        }

        if let Some(existing_index) = self.sparse_index[id] {
            let previous = std::mem::replace(&mut self.components[existing_index], component);
            return Some(previous);
        }

        self.components.push(component);
        self.entities.push(entity_id);
        self.sparse_index[id] = Some(index);
        None
    }

    pub fn get(&self, entity_id: EntityId) -> Option<&T> {
        self.sparse_index.get(entity_id.0)?.map(|index| &self.components[index])
    }

    pub fn get_mut(&mut self, entity_id: EntityId) -> Option<&mut T> {
        self.sparse_index.get_mut(entity_id.0)?.map(|index| &mut self.components[index])
    }

    pub fn iter(&self) -> impl Iterator<Item = &T> {
        self.components.iter()
    }

    pub fn entities(&self) -> impl Iterator<Item = (EntityId, &T)> {
        self.entities.iter().copied().zip(self.components.iter())
    }

    pub fn ids<'a>(&'a self) -> impl Iterator<Item = EntityId> + 'a {
        self.entities.iter().copied()
    }

    pub fn remove(&mut self, entity_id: EntityId) -> Option<T> {
        let index = self.sparse_index.get_mut(entity_id.0)?.take()?;

        // TODO: check overflow behavior for correctness
        let last_index = self.components.len() - 1;
        self.components.swap(index, last_index);
        self.entities.swap(index, last_index);

        let swapped_entity = self.entities[index];
        self.sparse_index[swapped_entity.0] = Some(index);

        self.entities.pop();

        self.components.pop()
    }

    pub fn clear(&mut self) {
        self.components.clear();
        self.entities.clear();
        self.sparse_index.clear();
    }
}

impl<T> SparseSet<T> where T: 'static {
    pub fn boxed(self) -> BoxedSparseSet {
        BoxedSparseSet(Box::new(self))
    }
}

impl<T> DynStorage for SparseSet<T> where T: 'static {
    fn insert_dyn(&mut self, entity_id: EntityId, component: Box<dyn Any>) {
        self.insert(entity_id, *component.downcast().unwrap());
    }

    fn remove_dyn(&mut self, entity_id: EntityId) -> Option<Box<dyn Any>> {
        self.remove(entity_id).map(|component| Box::new(component) as Box<dyn Any>)
    }

    fn clear(&mut self) {
        self.clear();
    }

    fn as_any(&self) -> &dyn Any {
        self
    }

    fn as_any_mut(&mut self) -> &mut dyn Any {
        self
    }
}
