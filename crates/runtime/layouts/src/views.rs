//! Views to read pipeline internal values without locking
use std::collections::HashMap;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_node::NodePath;

#[derive(Clone)]
pub struct LayoutsView {
    faders: Arc<NonEmptyPinboard<HashMap<NodePath, f64>>>,
    buttons: Arc<NonEmptyPinboard<HashMap<NodePath, bool>>>,
    labels: Arc<NonEmptyPinboard<HashMap<NodePath, String>>>,
}

impl Default for LayoutsView {
    fn default() -> Self {
        Self {
            faders: Arc::new(NonEmptyPinboard::new(Default::default())),
            buttons: Arc::new(NonEmptyPinboard::new(Default::default())),
            labels: Arc::new(NonEmptyPinboard::new(Default::default())),
        }
    }
}

impl LayoutsView {
    pub fn get_fader_value(&self, path: &NodePath) -> Option<f64> {
        let values = self.faders.read();

        values.get(path).copied()
    }

    pub fn write_fader_values(&self, values: HashMap<NodePath, f64>) {
        self.faders.set(values);
    }

    pub fn get_button_value(&self, path: &NodePath) -> Option<bool> {
        let values = self.buttons.read();

        values.get(path).copied()
    }

    pub fn write_button_values(&self, values: HashMap<NodePath, bool>) {
        self.buttons.set(values);
    }

    pub fn get_label_value(&self, path: &NodePath) -> Option<String> {
        let values = self.labels.read();

        values.get(path).cloned()
    }

    pub fn write_label_values(&self, values: HashMap<NodePath, String>) {
        self.labels.set(values);
    }
}
