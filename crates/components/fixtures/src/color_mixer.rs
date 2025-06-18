use crate::definition::ColorGroup;
use crate::fixture::{ChannelValues, IChannelType};
use crate::manager::{FadeTimings, FixtureValueSource};
use crate::FixturePriority;
use palette::{FromColor, Hsv, Srgb};
use serde::Serialize;

#[derive(Debug, Clone, Default, PartialEq, Serialize)]
pub struct ColorMixer {
    pub(crate) red: ChannelValues,
    pub(crate) green: ChannelValues,
    pub(crate) blue: ChannelValues,
    virtual_dimmer: Option<ChannelValues>,
}

impl ColorMixer {
    pub fn new(virtual_dimmer: bool) -> Self {
        Self {
            virtual_dimmer: virtual_dimmer.then(|| {
                let mut value = ChannelValues::default();
                value.insert(
                    0.0,
                    FixturePriority::LOWEST,
                    Default::default(),
                    Default::default(),
                );

                value
            }),
            ..Default::default()
        }
    }

    pub(crate) fn flush(&mut self) {
        self.red.flush();
        self.green.flush();
        self.blue.flush();
        if let Some(virtual_dimmer) = self.virtual_dimmer.as_mut() {
            virtual_dimmer.flush();
        }
    }

    pub fn clear(&mut self) {
        self.red.clear();
        self.green.clear();
        self.blue.clear();
        if let Some(virtual_dimmer) = self.virtual_dimmer.as_mut() {
            virtual_dimmer.clear();
            virtual_dimmer.insert(0.0, FixturePriority::LOWEST, None, Default::default());
        }
    }

    pub fn set_red(
        &mut self,
        red: f64,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        self.red.insert(red, priority, source, fade_timings);
    }

    pub fn set_green(
        &mut self,
        green: f64,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        self.green.insert(green, priority, source, fade_timings);
    }

    pub fn set_blue(
        &mut self,
        blue: f64,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        self.blue.insert(blue, priority, source, fade_timings);
    }

    pub fn set_virtual_dimmer(
        &mut self,
        value: f64,
        priority: FixturePriority,
        source: Option<FixtureValueSource>,
        fade_timings: FadeTimings,
    ) {
        if let Some(virtual_dimmer) = self.virtual_dimmer.as_mut() {
            virtual_dimmer.insert(value, priority, source, fade_timings);
        }
    }

    pub fn virtual_dimmer(&self) -> Option<f64> {
        self.virtual_dimmer.as_ref().and_then(|v| v.get())
    }

    pub fn rgb(&self) -> Rgb {
        profiling::scope!("ColorMixer::rgb");
        let (rgb, _) = self.get_srgb();

        Rgb {
            red: rgb.red,
            green: rgb.green,
            blue: rgb.blue,
        }
    }

    pub fn rgbw(&self) -> Rgbw {
        profiling::scope!("ColorMixer::rgbw");
        let (rgb, hsv) = self.get_srgb();

        Rgbw {
            red: rgb.red * hsv.saturation,
            green: rgb.green * hsv.saturation,
            blue: rgb.blue * hsv.saturation,
            white: hsv.value - hsv.saturation,
        }
    }

    fn get_srgb(&self) -> (Srgb<f64>, Hsv<palette::encoding::Srgb, f64>) {
        let red = self.red.get().unwrap_or_default();
        let green = self.green.get().unwrap_or_default();
        let blue = self.blue.get().unwrap_or_default();
        let rgb = Srgb::new(red, green, blue);
        let mut hsv = Hsv::from_color(rgb);
        if let Some(virtual_dimmer) = self.virtual_dimmer.as_ref().and_then(|v| v.get()) {
            hsv.value *= virtual_dimmer;
        }
        let rgb = Srgb::from_color(hsv);

        (rgb, hsv)
    }

    pub fn cmy(&self) -> Cmy {
        profiling::scope!("ColorMixer::cmy");
        let rgb = self.rgb();

        let cyan = 1.0 - rgb.red;
        let magenta = 1.0 - rgb.green;
        let yellow = 1.0 - rgb.blue;

        Cmy {
            cyan,
            magenta,
            yellow,
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

#[derive(Debug, Clone, Copy, Default)]
pub struct Cmy {
    pub cyan: f64,
    pub magenta: f64,
    pub yellow: f64,
}

#[profiling::function]
pub(crate) fn update_color_mixer<TChannel: IChannelType>(
    color_mixer: Option<&ColorMixer>,
    color_group: Option<&ColorGroup<TChannel>>,
    mut write: impl FnMut(&String, f64),
) {
    debug_assert!(
        color_mixer.is_some(),
        "Trying to update non-existent color mixer"
    );
    debug_assert!(
        color_group.is_some(),
        "Trying to update color mixer without color group"
    );
    if let Some(color_mixer) = color_mixer {
        if let Some(ColorGroup::Rgb {
            red,
            green,
            blue,
            white,
            ..
        }) = color_group
        {
            let rgb = if let Some(white_channel) = white.as_ref().and_then(|c| c.to_channel()) {
                let value = color_mixer.rgbw();
                write(white_channel, value.white);

                Rgb {
                    red: value.red,
                    green: value.green,
                    blue: value.blue,
                }
            } else {
                color_mixer.rgb()
            };
            if let Some(channel) = red.to_channel() {
                write(channel, rgb.red);
            }
            if let Some(channel) = green.to_channel() {
                write(channel, rgb.green);
            }
            if let Some(channel) = blue.to_channel() {
                write(channel, rgb.blue);
            }
        } else if let Some(ColorGroup::Cmy {
            cyan,
            magenta,
            yellow,
        }) = color_group
        {
            let cmy = color_mixer.cmy();
            if let Some(channel) = cyan.to_channel() {
                write(channel, cmy.cyan);
            }
            if let Some(channel) = magenta.to_channel() {
                write(channel, cmy.magenta);
            }
            if let Some(channel) = yellow.to_channel() {
                write(channel, cmy.yellow);
            }
        }
    }
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
        let mut mixer = ColorMixer::new(false);
        mixer.set_red(
            red,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_green(
            green,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_blue(
            blue,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.flush();

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
    fn rgbw_should_return_rgbw_values(
        red: f64,
        green: f64,
        blue: f64,
        r: f64,
        g: f64,
        b: f64,
        w: f64,
    ) {
        let mut mixer = ColorMixer::new(false);
        mixer.set_red(
            red,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_green(
            green,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_blue(
            blue,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.flush();

        let result = mixer.rgbw();

        assert_eq!(r, result.red);
        assert_eq!(g, result.green);
        assert_eq!(b, result.blue);
        assert_eq!(w, result.white);
    }

    #[test_case(1f64, 1f64, 1f64, 0f64, 0f64, 0f64, 0f64)]
    #[test_case(1f64, 1f64, 1f64, 1f64, 1f64, 1f64, 1f64)]
    #[test_case(1f64, 1f64, 1f64, 0.5f64, 0.5f64, 0.5f64, 0.5f64)]
    #[test_case(0f64, 1f64, 1f64, 1f64, 0f64, 1f64, 1f64)]
    #[test_case(1f64, 0f64, 1f64, 1f64, 1f64, 0f64, 1f64)]
    #[test_case(1f64, 1f64, 0f64, 1f64, 1f64, 1f64, 0f64)]
    #[test_case(0.5f64, 0.5f64, 0.5f64, 1f64, 0.5f64, 0.5f64, 0.5f64)]
    fn rgb_should_apply_virtual_dimmer(
        red: f64,
        green: f64,
        blue: f64,
        dimmer: f64,
        r: f64,
        g: f64,
        b: f64,
    ) {
        let mut mixer = ColorMixer::new(true);
        mixer.set_red(
            red,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_green(
            green,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_blue(
            blue,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_virtual_dimmer(
            dimmer,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.flush();

        let result = mixer.rgb();

        assert_eq!(r, result.red);
        assert_eq!(g, result.green);
        assert_eq!(b, result.blue);
    }

    #[test_case(1f64, 1f64, 1f64, 0f64, 0f64, 0f64, 0f64, 0f64)]
    #[test_case(1f64, 1f64, 1f64, 1f64, 0f64, 0f64, 0f64, 1f64)]
    #[test_case(1f64, 1f64, 1f64, 0.5f64, 0f64, 0f64, 0f64, 0.5f64)]
    #[test_case(1f64, 1f64, 0f64, 1f64, 1f64, 1f64, 0f64, 0f64)]
    #[test_case(1f64, 0f64, 0f64, 1f64, 1f64, 0f64, 0f64, 0f64)]
    #[test_case(0f64, 1f64, 0f64, 1f64, 0f64, 1f64, 0f64, 0f64)]
    #[test_case(0f64, 0f64, 1f64, 1f64, 0f64, 0f64, 1f64, 0f64)]
    #[test_case(0.5f64, 0.5f64, 0.5f64, 1f64, 0f64, 0f64, 0f64, 0.5f64)]
    fn rgbw_should_apply_virtual_dimmer(
        red: f64,
        green: f64,
        blue: f64,
        dimmer: f64,
        r: f64,
        g: f64,
        b: f64,
        w: f64,
    ) {
        let mut mixer = ColorMixer::new(true);
        mixer.set_red(
            red,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_green(
            green,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_blue(
            blue,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.set_virtual_dimmer(
            dimmer,
            Default::default(),
            Default::default(),
            Default::default(),
        );
        mixer.flush();

        let result = mixer.rgbw();

        assert_eq!(r, result.red);
        assert_eq!(g, result.green);
        assert_eq!(b, result.blue);
        assert_eq!(w, result.white);
    }
}
