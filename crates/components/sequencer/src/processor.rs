use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;

use crate::sequencer::Sequencer;
use crate::EffectEngine;

#[derive(Debug)]
pub(crate) struct SequenceProcessor;

impl Processor for SequenceProcessor {
    #[tracing::instrument]
    fn process(&mut self, injector: &InjectionScope<'_>, frame: ClockFrame) {
        profiling::scope!("SequenceProcessor::process");
        let sequencer = injector.inject::<Sequencer>();
        let fixture_manager = injector.inject::<FixtureManager>();
        let effect_engine = injector.inject::<EffectEngine>();
        sequencer.run_sequences(fixture_manager, effect_engine, frame);
    }
}
