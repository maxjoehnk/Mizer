use palette::{FromColor, Hsv, Srgb};

pub fn hsv_to_rgb(hue: f64, saturation: f64, value: f64) -> (f64, f64, f64) {
    let hsv= Hsv::from_components((hue, saturation, value));
    let rgb = Srgb::from_color(hsv);

    rgb.into_components()
}
