use std::ops::Deref;

use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;

use crate::EffectEngine;

pub(crate) struct EffectsProcessor;

impl Processor for EffectsProcessor {
    fn process(&mut self, injector: &Injector, frame: ClockFrame) {
        profiling::scope!("EffectsProcessor::process");
        let engine = injector.get::<EffectEngine>().unwrap();
        let fixtures = injector.get::<FixtureManager>().unwrap();
        engine.run_programmer_effects(fixtures.get_programmer().deref());
        engine.process_instances(fixtures, frame);
    }
}

impl DebuggableProcessor for EffectsProcessor {
    fn debug_ui<'a>(&mut self, injector: &Injector, ui: &mut impl DebugUiDrawHandle<'a>) {
        let engine = injector.get::<EffectEngine>().unwrap();
        let instances = engine.instances.lock().unwrap();
        ui.collapsing_header("Effects", |ui| {
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
        });
    }
}
