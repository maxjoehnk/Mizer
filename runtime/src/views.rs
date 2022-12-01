//! Views to read pipeline internal values without locking
use std::collections::HashMap;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_node::NodePath;

#[derive(Clone)]
#[repr(transparent)]
pub struct LayoutsView(Arc<NonEmptyPinboard<HashMap<NodePath, f64>>>);

impl Default for LayoutsView {
    fn default() -> Self {
        Self(Arc::new(NonEmptyPinboard::new(Default::default())))
    }
}

impl LayoutsView {
    pub fn get_fader_value(&self, path: &NodePath) -> Option<f64> {
        let values = self.0.read();

        values.get(path).copied()
    }

    pub(crate) fn write_fader_values(&self, values: HashMap<NodePath, f64>) {
        self.0.set(values);
    }
}
