use std::collections::HashMap;
use std::ops::Deref;

use mizer_processing::*;
use mizer_protocol_dmx::DmxConnectionManager;

use crate::definition::{ColorChannel, FixtureFaderControl};
use crate::fixture::IFixture;
use crate::manager::FixtureManager;
use crate::{FixtureId, FixtureState};

#[derive(Debug)]
pub struct FixtureProcessor;

impl Processor for FixtureProcessor {
    #[tracing::instrument]
    fn pre_process(&mut self, injector: &mut Injector, _: ClockFrame, _fps: f64) {
        profiling::scope!("FixtureProcessor::pre_process");
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("fixture processor without fixture manager");
        fixture_manager.default_fixtures();
    }

    #[tracing::instrument]
    fn process(&mut self, injector: &Injector, _: ClockFrame) {
        profiling::scope!("FixtureProcessor::process");
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("fixture processor without fixture manager");
        let dmx_manager = injector
            .get::<DmxConnectionManager>()
            .expect("fixture processor without dmx module");
        fixture_manager.execute_programmers();
        fixture_manager.write_outputs(dmx_manager);
    }

    #[tracing::instrument]
    fn post_process(&mut self, injector: &Injector, _frame: ClockFrame) {
        profiling::scope!("FixtureProcessor::post_process");
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("fixture processor without fixture manager");
        let mut state = fixture_manager.states.read();
        for fixture in fixture_manager.get_fixtures().iter() {
            update_state(&mut state, FixtureId::Fixture(fixture.id), fixture.deref());
            for sub_fixture in fixture.current_mode.sub_fixtures.iter() {
                let id = FixtureId::SubFixture(fixture.id, sub_fixture.id);
                if let Some(sub_fixture) = fixture.sub_fixture(sub_fixture.id) {
                    update_state(&mut state, id, &sub_fixture);
                }
            }
        }
        fixture_manager.states.write(state);
        fixture_manager
            .get_programmer()
            .emit_state(fixture_manager.get_groups());
    }
}

impl DebuggableProcessor for FixtureProcessor {
    #[tracing::instrument(skip_all)]
    fn debug_ui<'a>(&mut self, injector: &Injector, ui: &mut impl DebugUiDrawHandle<'a>) {
        profiling::scope!("FixtureProcessor::update_debug_ui");
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("fixture processor without fixture manager");
        ui.collapsing_header("Fixtures", |ui| {
            let fixtures = fixture_manager.get_fixtures();
            for fixture in fixtures {
                ui.collapsing_header(fixture.name.as_str(), |ui| {
                    ui.columns(2, |columns| {
                        columns[0].label("Id");
                        columns[1].label(fixture.id.to_string());

                        columns[0].label("Universe");
                        columns[1].label(fixture.universe.to_string());

                        columns[0].label("Channel");
                        columns[1].label(fixture.channel.to_string());
                    });
                    ui.collapsing_header(format!("Mode: {}", fixture.current_mode.name), |_ui| {});
                    ui.collapsing_header("Configuration", |ui| {
                        ui.columns(2, |columns| {
                            columns[0].label("Invert Pan");
                            columns[1].label(fixture.configuration.invert_pan.to_string());

                            columns[0].label("Invert Tilt");
                            columns[1].label(fixture.configuration.invert_tilt.to_string());

                            columns[0].label("Reverse Pixel Order");
                            columns[1].label(fixture.configuration.reverse_pixel_order.to_string());
                        });
                    });
                    ui.collapsing_header("Definition", |ui| {
                        ui.columns(2, |columns| {
                            columns[0].label("ID");
                            columns[1].label(&fixture.definition.id);

                            columns[0].label("Provider");
                            columns[1].label(fixture.definition.provider);

                            columns[0].label("Manufacturer");
                            columns[1].label(&fixture.definition.manufacturer);

                            columns[0].label("Name");
                            columns[1].label(&fixture.definition.name);
                        });
                        ui.collapsing_header("Modes", |ui| {
                            for mode in &fixture.definition.modes {
                                ui.collapsing_header(&mode.name, |ui| {
                                    ui.collapsing_header("Channels", |ui| {
                                        ui.columns(2, |columns| {
                                            for channel in mode.get_channels() {
                                                columns[0].label(&channel.name);
                                                columns[1]
                                                    .label(format!("{:?}", channel.resolution));
                                            }
                                        });
                                    });
                                });
                            }
                        });
                        ui.columns(2, |columns| {
                            if let Some(dimensions) = fixture.definition.physical.dimensions {
                                columns[0].label("Dimensions");
                                columns[1].label(format!(
                                    "{}x{}x{}",
                                    dimensions.height, dimensions.width, dimensions.depth
                                ));
                            }
                            if let Some(weight) = fixture.definition.physical.weight {
                                columns[0].label("Weight");
                                columns[1].label(format!("{weight}kg"));
                            }
                        });
                    });
                    ui.collapsing_header("Channel Values", |ui| {
                        ui.columns(2, |columns| {
                            for (channel, value) in fixture.channel_values.iter() {
                                columns[0].label(channel);
                                columns[1].label(value.to_string());
                            }
                        });
                    });
                });
            }
        });
    }
}

fn update_state(
    state: &mut HashMap<FixtureId, FixtureState>,
    id: FixtureId,
    fixture: &impl IFixture,
) {
    let fixture_state = state.entry(id).or_default();
    fixture_state.brightness = fixture.read_control(FixtureFaderControl::Intensity);
    let red = fixture.read_control(FixtureFaderControl::ColorMixer(ColorChannel::Red));
    let green = fixture.read_control(FixtureFaderControl::ColorMixer(ColorChannel::Green));
    let blue = fixture.read_control(FixtureFaderControl::ColorMixer(ColorChannel::Blue));
    fixture_state.color = red
        .zip(green)
        .zip(blue)
        .map(|((red, green), blue)| (red, green, blue));
}
