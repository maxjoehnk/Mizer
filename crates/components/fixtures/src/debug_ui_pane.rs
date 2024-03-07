use mizer_module::*;
use mizer_node::Inject;

use crate::manager::FixtureManager;

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
    }
}
