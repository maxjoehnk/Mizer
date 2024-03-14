use crate::programmer::{Preset, Presets};
use dashmap::DashMap;

impl Presets {
    pub fn load_defaults(&self) {
        add_preset(&self.intensity, 1, 0f64, "0%");
        add_preset(&self.intensity, 2, 0.25f64, "25%");
        add_preset(&self.intensity, 3, 0.5f64, "50%");
        add_preset(&self.intensity, 4, 0.75f64, "75%");
        add_preset(&self.intensity, 5, 1f64, "100%");

        add_preset(&self.color, 1, (1f64, 1f64, 1f64), "White");
        add_preset(&self.color, 2, (1f64, 0f64, 0f64), "Red");
        add_preset(&self.color, 3, (0f64, 1f64, 0f64), "Green");
        add_preset(&self.color, 4, (0f64, 0f64, 1f64), "Blue");
        add_preset(&self.color, 5, (1f64, 1f64, 0f64), "Yellow");
        add_preset(&self.color, 6, (1f64, 0f64, 1f64), "Magenta");
        add_preset(&self.color, 7, (0f64, 1f64, 1f64), "Turquoise");
        add_preset(&self.color, 8, (1f64, 0.5f64, 0f64), "Orange");
        add_preset(&self.color, 9, (0.5f64, 1f64, 0f64), "Lime");
        add_preset(&self.color, 10, (0.5f64, 0f64, 1f64), "Purple");
        add_preset(&self.color, 11, (1f64, 0f64, 0.5f64), "Pink");
        add_preset(&self.color, 12, (0f64, 1f64, 0.5f64), "Mint");
        add_preset(&self.color, 13, (0f64, 0.5f64, 1f64), "Light Blue");
    }
}

fn add_preset<TValue>(
    presets: &DashMap<u32, Preset<TValue>>,
    id: u32,
    value: TValue,
    label: impl Into<String>,
) {
    let label = Some(label.into());

    presets.insert(id, Preset { id, label, value });
}
