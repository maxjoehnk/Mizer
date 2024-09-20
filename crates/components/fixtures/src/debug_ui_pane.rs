use crate::fixture::IFixture;
use crate::manager::FixtureManager;
use mizer_module::*;

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
            ui.collapsing_header(fixture.name.as_str(), |ui| {
                ui.columns(2, |columns| {
                    columns[0].label("Id");
                    columns[1].label(fixture.id.to_string());

                    columns[0].label("Universe");
                    columns[1].label(fixture.universe.to_string());

                    columns[0].label("Channel");
                    columns[1].label(fixture.channel.to_string());
                });
                ui.collapsing_header(format!("Mode: {}", fixture.channel_mode.name), |_ui| {});
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
                            ui.collapsing_header(mode.name.as_str(), |ui| {
                                ui.collapsing_header("Channels", |ui| {
                                    ui.columns(2, |columns| {
                                        for channel in mode.channels.values() {
                                            columns[0].label(channel.name());
                                            columns[1].label(format!("{:?}", channel.channels));
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
                            columns[0].label(channel.to_string());
                            columns[1].label(value.to_string());
                        }
                    });
                });
                ui.collapsing_header("Channels", |ui| {
                    ui.columns(2, |columns| {
                        for channel in
                            fixture.channel_mode.channels.values()
                        {
                            columns[0].label(channel.name());
                            columns[1].label(fixture.read_channel(channel.channel).unwrap_or_default().to_string());
                        }
                    });
                });
                // ui.collapsing_header("Sub Fixtures", |ui| {
                //     for sub_fixture in &fixture.current_mode.sub_fixtures {
                //         ui.collapsing_header(&sub_fixture.name, |ui| {
                //             ui.columns(3, |columns| {
                //                 if let Some(sub_fixture) = fixture.sub_fixture(sub_fixture.id) {
                //                     for (control, _control_type) in
                //                         sub_fixture.definition.controls.controls().into_iter()
                //                     {
                //                         for fader in control.faders() {
                //                             let channel = sub_fixture
                //                                 .definition
                //                                 .controls
                //                                 .get_channel(&fader)
                //                                 .unwrap();
                //                             let channel = format!("{:?}", channel);
                //                             columns[0].label(format!("{fader:?}"));
                //                             columns[1].label(
                //                                 sub_fixture
                //                                     .read_control(fader)
                //                                     .unwrap_or_default()
                //                                     .to_string(),
                //                             );
                //                             columns[2].label(channel);
                //                         }
                //                     }
                //                 }
                //             });
                //         })
                //     }
                // });
            });
        }
    }
}
