use palette::{FromColor, Hsv, Srgb};

#[derive(Debug, Clone, Copy, Default, PartialEq)]
pub struct ColorMixer {
    red: f64,
    green: f64,
    blue: f64,
}

impl ColorMixer {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn set_red(&mut self, red: f64) {
        self.red = red;
    }

    pub fn set_green(&mut self, green: f64) {
        self.green = green;
    }

    pub fn set_blue(&mut self, blue: f64) {
        self.blue = blue;
    }

    pub fn rgb(&self) -> Rgb {
        Rgb {
            red: self.red,
            green: self.green,
            blue: self.blue,
        }
    }

    pub fn rgbw(&self) -> Rgbw {
        let rgb = Srgb::new(self.red, self.green, self.blue);
        let hsv = Hsv::from_color(rgb);

        Rgbw {
            red: self.red * hsv.saturation,
            green: self.green * hsv.saturation,
            blue: self.blue * hsv.saturation,
            white: hsv.value - hsv.saturation,
        }
    }
}

#[derive(Debug, Clone, Copy, Default)]
pub struct Rgb {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
}

#[derive(Debug, Clone, Copy, Default)]
pub struct Rgbw {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
    pub white: f64,
}

#[cfg(test)]
mod tests {
    use test_case::test_case;
    use super::*;

    #[test_case(1f64, 1f64, 1f64)]
    #[test_case(0f64, 1f64, 1f64)]
    #[test_case(1f64, 0f64, 1f64)]
    #[test_case(1f64, 1f64, 0f64)]
    fn rgb_should_return_rgb_values(red: f64, green: f64, blue: f64) {
        let mut mixer = ColorMixer::new();
        mixer.set_red(red);
        mixer.set_green(green);
        mixer.set_blue(blue);

        let result = mixer.rgb();

        assert_eq!(red, result.red);
        assert_eq!(green, result.green);
        assert_eq!(blue, result.blue);
    }

    #[test_case(1f64, 1f64, 1f64, 0f64, 0f64, 0f64, 1f64)]
    #[test_case(0f64, 1f64, 1f64, 0f64, 1f64, 1f64, 0f64)]
    #[test_case(1f64, 0f64, 1f64, 1f64, 0f64, 1f64, 0f64)]
    #[test_case(1f64, 1f64, 0f64, 1f64, 1f64, 0f64, 0f64)]
    #[test_case(1f64, 0f64, 0f64, 1f64, 0f64, 0f64, 0f64)]
    #[test_case(0f64, 1f64, 0f64, 0f64, 1f64, 0f64, 0f64)]
    #[test_case(0f64, 0f64, 1f64, 0f64, 0f64, 1f64, 0f64)]
    #[test_case(0.5f64, 0.5f64, 0.5f64, 0f64, 0f64, 0f64, 0.5f64)]
    fn rgbw_should_return_rgbw_values(red: f64, green: f64, blue: f64, r: f64, g: f64, b: f64, w: f64) {
        let mut mixer = ColorMixer::new();
        mixer.set_red(red);
        mixer.set_green(green);
        mixer.set_blue(blue);

        let result = mixer.rgbw();

        assert_eq!(r, result.red);
        assert_eq!(g, result.green);
        assert_eq!(b, result.blue);
        assert_eq!(w, result.white);
    }
}
