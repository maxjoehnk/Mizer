use std::ops::Deref;

use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;

use crate::EffectEngine;

pub(crate) struct EffectsProcessor;

impl Processor for EffectsProcessor {
    fn process(&mut self, injector: &mut Injector, frame: ClockFrame) {
        profiling::scope!("EffectsProcessor::process");
        let engine = injector.inject::<EffectEngine>();
        let fixtures = injector.inject::<FixtureManager>();
        engine.run_programmer_effects(fixtures.get_programmer().deref());
        engine.process_instances(fixtures, frame);
    }
}
