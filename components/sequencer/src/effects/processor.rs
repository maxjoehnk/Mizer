use mizer_module::*;
use crate::EffectEngine;
use mizer_fixtures::manager::FixtureManager;

pub(crate) struct EffectsProcessor;

impl Processor for EffectsProcessor {
    fn process(&self, injector: &Injector, frame: ClockFrame) {
        profiling::scope!("EffectsProcessor::process");
        let engine = injector.get::<EffectEngine>().unwrap();
        let fixtures = injector.get::<FixtureManager>().unwrap();
        engine.process_instances(fixtures, frame);
    }
}
