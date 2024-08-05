//! Views to read pipeline internal values without locking
use std::collections::HashMap;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_node::NodePath;
use mizer_ports::Color;

#[derive(Clone)]
pub struct LayoutsView {
    faders: Arc<NonEmptyPinboard<HashMap<NodePath, f64>>>,
    buttons: Arc<NonEmptyPinboard<HashMap<NodePath, bool>>>,
    dials: Arc<NonEmptyPinboard<HashMap<NodePath, f64>>>,
    labels: Arc<NonEmptyPinboard<HashMap<NodePath, Arc<String>>>>,
    colors: Arc<NonEmptyPinboard<HashMap<NodePath, Color>>>,
}

impl Default for LayoutsView {
    fn default() -> Self {
        Self {
            faders: Arc::new(NonEmptyPinboard::new(Default::default())),
            buttons: Arc::new(NonEmptyPinboard::new(Default::default())),
            dials: Arc::new(NonEmptyPinboard::new(Default::default())),
            labels: Arc::new(NonEmptyPinboard::new(Default::default())),
            colors: Arc::new(NonEmptyPinboard::new(Default::default())),
        }
    }
}

impl LayoutsView {
    pub fn get_fader_value(&self, path: &NodePath) -> Option<f64> {
        let values = self.faders.read();

        values.get(path).copied()
    }

    pub(crate) fn write_fader_values(&self, values: HashMap<NodePath, f64>) {
        self.faders.set(values);
    }

    pub fn get_dial_value(&self, path: &NodePath) -> Option<f64> {
        let values = self.dials.read();

        values.get(path).copied()
    }

    pub(crate) fn write_dial_values(&self, values: HashMap<NodePath, f64>) {
        self.dials.set(values);
    }

    pub fn get_button_value(&self, path: &NodePath) -> Option<bool> {
        let values = self.buttons.read();

        values.get(path).copied()
    }

    pub(crate) fn write_button_values(&self, values: HashMap<NodePath, bool>) {
        self.buttons.set(values);
    }

    pub fn get_label_value(&self, path: &NodePath) -> Option<Arc<String>> {
        let values = self.labels.read();

        values.get(path).cloned()
    }

    pub(crate) fn write_label_values(&self, values: HashMap<NodePath, Arc<String>>) {
        self.labels.set(values);
    }

    pub(crate) fn write_control_colors(&self, values: HashMap<NodePath, Color>) {
        self.colors.set(values);
    }

    pub fn get_control_color(&self, path: &NodePath) -> Option<Color> {
        let values = self.colors.read();

        values.get(path).copied()
    }
}
