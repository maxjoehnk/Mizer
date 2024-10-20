use crate::proto::appearance::*;

impl From<mizer_appearance::Appearance> for Appearance {
    fn from(appearance: mizer_appearance::Appearance) -> Self {
        Self {
            icon: appearance.icon.map(|icon| icon.to_string()),
            color: appearance.color.map(|color| Color {
                red: color.red as f32,
                green: color.green as f32,
                blue: color.blue as f32,
                alpha: color.alpha as f32,
            }),
            background: appearance.background.map(|color| Color {
                red: color.red as f32,
                green: color.green as f32,
                blue: color.blue as f32,
                alpha: color.alpha as f32,
            }),
        }
    }
}