use crate::sequencer::Sequencer;
use crate::EffectEngine;
use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;

pub(crate) struct SequenceProcessor;

impl Processor for SequenceProcessor {
    fn process(&self, injector: &Injector, frame: ClockFrame) {
        profiling::scope!("SequenceProcessor::process");
        let sequencer = injector.get::<Sequencer>().unwrap();
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("sequencer requires fixtures");
        let effect_engine = injector.get::<EffectEngine>().unwrap();
        sequencer.run_sequences(fixture_manager, effect_engine, frame);
    }
}
