use crate::EffectEngine;
use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;

pub(crate) struct EffectsProcessor;

impl Processor for EffectsProcessor {
    fn process(&mut self, injector: &Injector, frame: ClockFrame) {
        profiling::scope!("EffectsProcessor::process");
        let engine = injector.get::<EffectEngine>().unwrap();
        let fixtures = injector.get::<FixtureManager>().unwrap();
        engine.process_instances(fixtures, frame);
    }
}
