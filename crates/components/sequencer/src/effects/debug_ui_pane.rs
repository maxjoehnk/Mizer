use crate::EffectEngine;
use mizer_module::*;

pub struct EffectsDebugUiPane;

impl<TUi: DebugUi> DebugUiPane<TUi> for EffectsDebugUiPane {
    fn title(&self) -> &'static str {
        "Effects"
    }

    fn render<'a>(
        &mut self,
        injector: &Injector,
        _state_access: &dyn NodeStateAccess,
        ui: &mut TUi::DrawHandle<'a>,
        _textures: &mut <TUi::DrawHandle<'a> as DebugUiDrawHandle<'a>>::TextureMap,
    ) {
        let engine = injector.inject::<EffectEngine>();
        let instances = engine.instances.lock().unwrap();
        for effect in engine.effects() {
            ui.collapsing_header(effect.name.clone(), |ui| {
                ui.columns(2, |columns| {
                    columns[0].label("ID");
                    columns[1].label(effect.id.to_string());

                    columns[0].label("Name");
                    columns[1].label(effect.name);
                });

                ui.collapsing_header("Channels", |ui| {
                    for channel in effect.channels {
                        ui.collapsing_header(format!("{:?}", channel.control), |ui| {
                            for step in channel.steps {
                                ui.horizontal(|ui| {
                                    ui.label(format!("{:?}", step.control_point));
                                    ui.label(format!("{:?}", step.value));
                                });
                            }
                        });
                    }
                });
                ui.collapsing_header("Instances", |ui| {
                    let instances = instances
                        .iter()
                        .filter(|(_, instance)| instance.effect_id == effect.id);

                    for (_id, instance) in instances {
                        ui.columns(2, |columns| {
                            columns[0].label("Rate");
                            columns[1].label(instance.rate.to_string());
                        });
                    }
                });
            });
        }
    }
}
