use palette::{FromColor, Hsv, Srgb};

pub fn hsv_to_rgb(hue: f64, saturation: f64, value: f64) -> (f64, f64, f64) {
    let hsv = Hsv::from_components((hue, saturation, value));
    let rgb = Srgb::from_color(hsv);

    rgb.into_components()
}

pub fn rgb_to_hsv(red: f64, green: f64, blue: f64) -> (f64, f64, f64) {
    let rgb = Srgb::from_components((red, green, blue));
    let hsv = Hsv::from_color(rgb);

    let (hue, saturation, value) = hsv.into_components();

    (hue.into_degrees(), saturation, value)
}
