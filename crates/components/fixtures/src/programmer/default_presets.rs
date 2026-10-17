use crate::programmer::{Preset, PresetValue, Presets};
use dashmap::DashMap;

impl Presets {
    pub fn load_defaults(&self) {
        add_preset(&self.intensity, 1, 0f64, "0%");
        add_preset(&self.intensity, 2, 0.25f64, "25%");
        add_preset(&self.intensity, 3, 0.5f64, "50%");
        add_preset(&self.intensity, 4, 0.75f64, "75%");
        add_preset(&self.intensity, 5, 1f64, "100%");

        add_preset(&self.color, 1, (1f64, 1f64, 1f64, None), "White");
        add_preset(&self.color, 2, (1f64, 0f64, 0f64, None), "Red");
        add_preset(&self.color, 3, (0f64, 1f64, 0f64, None), "Green");
        add_preset(&self.color, 4, (0f64, 0f64, 1f64, None), "Blue");
        add_preset(&self.color, 5, (1f64, 1f64, 0f64, None), "Yellow");
        add_preset(&self.color, 6, (1f64, 0f64, 1f64, None), "Magenta");
        add_preset(&self.color, 7, (0f64, 1f64, 1f64, None), "Turquoise");
        add_preset(&self.color, 8, (1f64, 0.5f64, 0f64, None), "Orange");
        add_preset(&self.color, 9, (0.5f64, 1f64, 0f64, None), "Lime");
        add_preset(&self.color, 10, (0.5f64, 0f64, 1f64, None), "Purple");
        add_preset(&self.color, 11, (1f64, 0f64, 0.5f64, None), "Pink");
        add_preset(&self.color, 12, (0f64, 1f64, 0.5f64, None), "Mint");
        add_preset(&self.color, 13, (0f64, 0.5f64, 1f64, None), "Light Blue");
    }
}

fn add_preset<TValue>(
    presets: &DashMap<u32, Preset<TValue>>,
    id: u32,
    value: TValue,
    label: impl Into<String>,
) {
    let label = Some(label.into());

    presets.insert(
        id,
        Preset {
            id,
            label,
            value: PresetValue::Universal(value),
        },
    );
}
