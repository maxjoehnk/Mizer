use crate::fixture::{ChannelValue, ChannelValues, IFixture};
use crate::manager::FixtureManager;
use mizer_module::*;
use mizer_node::Inject;

pub struct FixturesDebugUiPane;

impl<TUi: DebugUi> DebugUiPane<TUi> for FixturesDebugUiPane {
    fn title(&self) -> &'static str {
        "Fixtures"
    }

    #[tracing::instrument(skip_all)]
    fn render<'a>(
        &mut self,
        injector: &Injector,
        _state_access: &dyn NodeStateAccess,
        ui: &mut TUi::DrawHandle<'a>,
        _textures: &mut <TUi::DrawHandle<'a> as DebugUiDrawHandle<'a>>::TextureMap,
    ) {
        profiling::scope!("FixtureProcessor::update_debug_ui");
        let fixture_manager = injector.inject::<FixtureManager>();
        let fixtures = fixture_manager.get_fixtures();
        for fixture in fixtures {
            ui.collapsing_header(fixture.name.as_str(), None, |ui| {
                ui.columns(2, |columns| {
                    columns[0].label("Id");
                    columns[1].label(fixture.id.to_string());

                    columns[0].label("Universe");
                    columns[1].label(fixture.universe.to_string());

                    columns[0].label("Channel");
                    columns[1].label(fixture.channel.to_string());
                });
                ui.collapsing_header(format!("Mode: {}", fixture.current_mode.name), None, |ui| {
                    if let Some(ref color_mixer) = fixture.current_mode.color_mixer {
                        ui.collapsing_header("Color Mixer", None, |ui| {
                            ui.collapsing_header(
                                format!("Red: {}", color_mixer.rgb().red),
                                Some("red"),
                                |ui| {
                                    ui.columns(4, |columns| {
                                        debug_channel_values(columns, &color_mixer.red);
                                    });
                                },
                            );
                            ui.collapsing_header(
                                format!("Green: {}", color_mixer.rgb().green),
                                Some("green"),
                                |ui| {
                                    ui.columns(4, |columns| {
                                        debug_channel_values(columns, &color_mixer.green);
                                    });
                                },
                            );
                            ui.collapsing_header(
                                format!("Blue: {}", color_mixer.rgb().blue),
                                Some("blue"),
                                |ui| {
                                    ui.columns(4, |columns| {
                                        debug_channel_values(columns, &color_mixer.blue);
                                    });
                                },
                            );
                        });
                    }
                });
                ui.collapsing_header("Configuration", None, |ui| {
                    ui.columns(2, |columns| {
                        columns[0].label("Invert Pan");
                        columns[1].label(fixture.configuration.invert_pan.to_string());

                        columns[0].label("Invert Tilt");
                        columns[1].label(fixture.configuration.invert_tilt.to_string());

                        columns[0].label("Reverse Pixel Order");
                        columns[1].label(fixture.configuration.reverse_pixel_order.to_string());
                    });
                });
                ui.collapsing_header("Definition", None, |ui| {
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
                    ui.collapsing_header("Modes", None, |ui| {
                        for mode in &fixture.definition.modes {
                            ui.collapsing_header(&mode.name, None, |ui| {
                                ui.collapsing_header("Channels", None, |ui| {
                                    ui.columns(2, |columns| {
                                        for channel in mode.get_channels() {
                                            columns[0].label(&channel.name);
                                            columns[1].label(format!("{:?}", channel.resolution));
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
                ui.collapsing_header("Channel Values", None, |ui| {
                    for (channel, value) in fixture.channel_values.iter() {
                        ui.collapsing_header(format!("{channel}: {value}"), Some(channel), |ui| {
                            ui.columns(4, |columns| {
                                let values =
                                    fixture.channel_values.get_priorities(channel).unwrap();
                                debug_channel_values(columns, values);
                            });
                        });
                    }
                });
                ui.collapsing_header("Faders", None, |ui| {
                    ui.columns(3, |columns| {
                        for (control, _control_type) in
                            fixture.current_mode.controls.controls().into_iter()
                        {
                            for fader in control.faders() {
                                let channel =
                                    fixture.current_mode.controls.get_channel(&fader).unwrap();
                                let channel = format!("{:?}", channel);
                                columns[0].label(format!("{fader:?}"));
                                columns[1].label(
                                    fixture.read_control(fader).unwrap_or_default().to_string(),
                                );
                                columns[2].label(channel);
                            }
                        }
                    });
                });
                ui.collapsing_header("Sub Fixtures", None, |ui| {
                    for sub_fixture in &fixture.current_mode.sub_fixtures {
                        ui.collapsing_header(&sub_fixture.name, None, |ui| {
                            ui.columns(3, |columns| {
                                if let Some(sub_fixture) = fixture.sub_fixture(sub_fixture.id) {
                                    for (control, _control_type) in
                                        sub_fixture.definition.controls.controls().into_iter()
                                    {
                                        for fader in control.faders() {
                                            let channel = sub_fixture
                                                .definition
                                                .controls
                                                .get_channel(&fader)
                                                .unwrap();
                                            let channel = format!("{:?}", channel);
                                            columns[0].label(format!("{fader:?}"));
                                            columns[1].label(
                                                sub_fixture
                                                    .read_control(fader)
                                                    .unwrap_or_default()
                                                    .to_string(),
                                            );
                                            columns[2].label(channel);
                                        }
                                    }
                                }
                            });
                        })
                    }
                });
            });
        }
    }
}

fn debug_channel_values<'a>(
    columns: &mut [impl DebugUiDrawHandle<'a>],
    channel_values: &ChannelValues,
) {
    for value in &channel_values.values {
        debug_channel_value(columns, value);
    }

    if !channel_values.previous_values.is_empty() {
        columns[0].label("Previous");
        columns[1].label("");
        columns[2].label("");
        columns[3].label("");
        for previous in &channel_values.previous_values {
            debug_channel_value(columns, previous);
        }
    }

    if let Some(active_fade) = &channel_values.active_fade {
        columns[0].label("Active Fade");
        columns[1].label(format!("Remaining: {:?}", active_fade.remaining()));
        columns[2].label("");
        columns[3].label("");
    }
}

fn debug_channel_value<'a>(
    columns: &mut [impl DebugUiDrawHandle<'a>],
    channel_value: &ChannelValue,
) {
    columns[0].label(format!("Value: {}", channel_value.value));
    columns[1].label(format!("Priority: {}", channel_value.priority));
    #[cfg(debug_assertions)]
    {
        if let Some(source) = &channel_value.source {
            columns[2].label(format!("Source: {}", source.label));
        } else {
            columns[2].label("Source: None");
        }
    }
    #[cfg(not(debug_assertions))]
    {
        columns[2].label(format!("Source: {:?}", channel_value.source));
    }
    columns[3].label(format!("{:?}", channel_value.fade_timings));
}
