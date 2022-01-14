use dashmap::DashMap;
use crate::programmer::{Preset, Presets};

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
        add_preset(&self.color, 6, (1f64, 0f64, 1f64), "Purple");
        add_preset(&self.color, 7, (0f64, 1f64, 1f64), "Turquoise");
    }
}

fn add_preset<TValue>(presets: &DashMap<u32, Preset<TValue>>, id: u32, value: TValue, label: impl Into<String>) {
    let label = Some(label.into());

    presets.insert(id, Preset {
        id,
        label,
        value
    });
}
