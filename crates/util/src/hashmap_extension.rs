use std::collections::HashMap;
use std::fmt::Debug;
use std::hash::Hash;
use indexmap::IndexMap;

pub trait HashMapExtension<TKey> {
    fn rename_key(&mut self, from: &TKey, to: TKey) -> bool;
}

impl<TKey: Eq + Hash + Debug, TValue> HashMapExtension<TKey> for HashMap<TKey, TValue> {
    fn rename_key(&mut self, from: &TKey, to: TKey) -> bool {
        if let Some(value) = self.remove(from) {
            self.insert(to, value);

            true
        } else {
            false
        }
    }
}

impl<TKey: Eq + Hash + Debug, TValue> HashMapExtension<TKey> for IndexMap<TKey, TValue> {
    fn rename_key(&mut self, from: &TKey, to: TKey) -> bool {
        if let Some((index, _key, value)) = self.shift_remove_full(from) {
            self.shift_insert(index, to, value);

            true
        } else {
            false
        }
    }
}
