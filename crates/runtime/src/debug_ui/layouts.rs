use mizer_debug_ui_impl::*;
use mizer_layouts::LayoutStorage;

pub(super) fn layouts_debug_ui(
    ui: &mut <DebugUiImpl as DebugUi>::DrawHandle<'_>,
    textures: &mut <DebugUiImpl as DebugUi>::TextureMap,
    layouts: &LayoutStorage,
) {
    ui.collapsing_header("Layouts", |ui| {
        let layouts = layouts.read();
        for layout in layouts {
            ui.collapsing_header(layout.id, |ui| {
                for control in layout.controls {
                    ui.collapsing_header(control.id.to_string(), |ui| {
                        ui.columns(2, |columns| {
                            columns[0].label("Label");
                            columns[1].label(control.label.unwrap_or_default());

                            columns[0].label("Position");
                            columns[1].label(format!("{:?}", control.position));

                            columns[0].label("Size");
                            columns[1].label(format!("{:?}", control.size));
                        });

                        ui.collapsing_header("Decoration", |ui| {
                            ui.columns(2, |columns| {
                                columns[0].label("Color");
                                columns[1].label(format!("{:?}", control.decoration.color));

                                columns[0].label("Image");
                                if let Some(image) = control.decoration.image {
                                    columns[1].image(
                                        &image,
                                        image.try_to_buffer().unwrap_or_default().as_slice(),
                                        textures,
                                    );
                                }
                            });
                        });

                        ui.collapsing_header("Behavior", |ui| {
                            ui.columns(2, |columns| {
                                columns[0].label("Sequencer Behavior");
                                columns[1].label(format!("{:?}", control.behavior.sequencer));
                            });
                        });
                    });
                }
            });
        }
    });
}
