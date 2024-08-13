use crate::color_mixer::{update_color_mixer, ColorMixer};
use crate::definition::{
    ColorChannel, FixtureFaderControl, SubFixtureControlChannel, SubFixtureDefinition,
};
use crate::fixture::{ChannelValues, IFixture, IFixtureMut};
use crate::FixturePriority;

#[derive(Debug)]
pub struct SubFixtureMut<'a> {
    pub(crate) channel_values: &'a mut ChannelValues,
    pub(crate) definition: &'a mut SubFixtureDefinition,
}

impl<'a> SubFixtureMut<'a> {
    pub(crate) fn update_color_mixer(&mut self) {
        profiling::scope!("SubFixture::update_color_mixer");
        update_color_mixer(
            self.definition.color_mixer.as_ref(),
            self.definition.controls.color_mixer.as_ref(),
            |channel, value| self.channel_values.write(channel, value),
        );
    }

    fn color_mixer_mut(&mut self) -> Option<&mut ColorMixer> {
        self.definition.color_mixer.as_mut()
    }
}

#[derive(Debug)]
pub struct SubFixture<'a> {
    pub(crate) channel_values: &'a ChannelValues,
    pub(crate) definition: &'a SubFixtureDefinition,
}

impl<'a> IFixtureMut for SubFixtureMut<'a> {
    fn write_fader_control(
        &mut self,
        control: FixtureFaderControl,
        value: f64,
        priority: FixturePriority,
    ) {
        profiling::scope!("SubFixtureMut::write_fader_control");
        if let Some(channel) = self.definition.controls.get_channel(&control) {
            match channel {
                SubFixtureControlChannel::Channel(channel) => {
                    if let FixtureFaderControl::ColorMixer(color_channel) = control {
                        let color_mixer = self.color_mixer_mut();
                        if let Some(color_mixer) = color_mixer {
                            match color_channel {
                                ColorChannel::Red => color_mixer.set_red(value, priority),
                                ColorChannel::Green => color_mixer.set_green(value, priority),
                                ColorChannel::Blue => color_mixer.set_blue(value, priority),
                            }
                        }
                    } else {
                        self.channel_values.write_priority(channel, value, priority)
                    }
                }
                SubFixtureControlChannel::VirtualDimmer => {
                    debug_assert!(
                        control == FixtureFaderControl::Intensity,
                        "Trying to write non intensity channel to virtual dimmer"
                    );
                    let color_mixer = self.color_mixer_mut();
                    if let Some(color_mixer) = color_mixer {
                        color_mixer.set_virtual_dimmer(value, priority);
                    }
                }
            }
        }
    }
}

impl<'a> IFixture for SubFixtureMut<'a> {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("SubFixtureMut::read_control");
        read_control(self.channel_values, self.definition, control)
    }
}

impl<'a> IFixture for SubFixture<'a> {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("SubFixture::read_control");
        read_control(self.channel_values, self.definition, control)
    }
}

fn read_control(
    channel_values: &ChannelValues,
    definition: &SubFixtureDefinition,
    control: FixtureFaderControl,
) -> Option<f64> {
    if let FixtureFaderControl::ColorMixer(channel) = control {
        let color_mixer = definition.color_mixer.as_ref()?;
        let rgb = color_mixer.rgb();

        return match channel {
            ColorChannel::Red => Some(rgb.red),
            ColorChannel::Green => Some(rgb.green),
            ColorChannel::Blue => Some(rgb.blue),
        };
    }
    match definition.controls.get_channel(&control) {
        Some(SubFixtureControlChannel::Channel(ref channel)) => channel_values.get(channel),
        Some(SubFixtureControlChannel::VirtualDimmer) => definition
            .color_mixer
            .as_ref()
            .and_then(|mixer| mixer.virtual_dimmer()),
        _ => None,
    }
}
