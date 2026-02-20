use crate::LayoutStorage;
use mizer_debug_ui::*;
use mizer_node::Inject;

pub struct LayoutsDebugUiPane;

impl<S: DebugUi> DebugUiPane<S> for LayoutsDebugUiPane {
    fn title(&self) -> &'static str {
        "Layouts"
    }

    fn render<'a>(
        &mut self,
        injector: &Injector,
        _state_access: &dyn NodeStateAccess,
        ui: &mut S::DrawHandle<'a>,
        _textures: &mut <S::DrawHandle<'a> as DebugUiDrawHandle<'a>>::TextureMap,
    ) {
        let layouts = injector.inject::<LayoutStorage>();
        let layouts = layouts.read();
        for layout in layouts {
            ui.collapsing_header(layout.id, None, |ui| {
                for control in layout.controls {
                    ui.collapsing_header(control.id.to_string(), None, |ui| {
                        ui.columns(2, |columns| {
                            columns[0].label("Label");
                            columns[1].label(control.label.unwrap_or_default());

                            columns[0].label("Position");
                            columns[1].label(format!("{:?}", control.position));

                            columns[0].label("Size");
                            columns[1].label(format!("{:?}", control.size));
                        });

                        ui.collapsing_header("Decoration", None, |ui| {
                            ui.columns(2, |columns| {
                                columns[0].label("Color");
                                columns[1].label(format!("{:?}", control.decoration.color));

                                columns[0].label("Image");
                                if let Some(image) = control.decoration.image {
                                    // TODO: fix type issue with texture map
                                    // columns[1].image(
                                    //     &image,
                                    //     image.try_to_buffer().unwrap_or_default().as_slice(),
                                    //     textures,
                                    // );
                                }
                            });
                        });

                        ui.collapsing_header("Behavior", None, |ui| {
                            ui.columns(2, |columns| {
                                columns[0].label("Sequencer Behavior");
                                columns[1].label(format!("{:?}", control.behavior.sequencer));
                            });
                        });
                    });
                }
            });
        }
    }
}
