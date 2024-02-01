use crate::{Fixture, FixturePriority};
use crate::color_mixer::{ColorMixer, update_color_mixer};
use crate::definition::{
    ColorChannel, FixtureFaderControl, SubFixtureControlChannel, SubFixtureDefinition,
};
use crate::fixture::{ChannelValues, IFixture, IFixtureMut};

#[derive(Debug)]
pub struct SubFixtureMut<'a> {
    pub(crate) fixture: &'a mut Fixture,
    pub(crate) definition: SubFixtureDefinition,
}

impl<'a> SubFixtureMut<'a> {
    fn update_color_mixer(&mut self) {
        update_color_mixer(
            self.color_mixer(),
            self.definition.controls.color_mixer.clone(),
            |channel, value| self.fixture.write(channel, value),
        );
    }

    fn color_mixer_mut(&mut self) -> Option<&mut ColorMixer> {
        let definition_id = self.definition.id;
        self.fixture
            .current_mode
            .sub_fixtures
            .iter_mut()
            .find(|s| s.id == definition_id)
            .and_then(|definition| definition.color_mixer.as_mut())
    }

    fn color_mixer(&self) -> Option<ColorMixer> {
        let definition_id = self.definition.id;
        self.fixture
            .current_mode
            .sub_fixtures
            .iter()
            .find(|s| s.id == definition_id)
            .and_then(|definition| definition.color_mixer.clone())
    }
}

#[derive(Debug)]
pub struct SubFixture<'a> {
    pub(crate) fixture: &'a Fixture,
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
                        self.update_color_mixer();
                    } else {
                        self.fixture.write_priority(channel, value, priority)
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
                    self.update_color_mixer();
                }
            }
        }
    }
}

impl<'a> IFixture for SubFixtureMut<'a> {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("SubFixtureMut::read_control");
        read_control(&self.fixture.channel_values, &self.definition, control)
    }
}

impl<'a> IFixture for SubFixture<'a> {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("SubFixture::read_control");
        read_control(&self.fixture.channel_values, self.definition, control)
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
