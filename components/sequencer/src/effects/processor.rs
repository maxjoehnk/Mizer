use crate::EffectEngine;
use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;
use std::ops::Deref;

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
