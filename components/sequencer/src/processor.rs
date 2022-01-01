use crate::sequencer::Sequencer;
use mizer_fixtures::manager::FixtureManager;
use mizer_module::{Injector, Processor};

pub(crate) struct SequenceProcessor;

impl Processor for SequenceProcessor {
    fn process(&self, injector: &Injector) {
        profiling::scope!("SequenceProcessor::process");
        let sequencer = injector.get::<Sequencer>().unwrap();
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("sequencer requires fixtures");
        sequencer.run_sequences(fixture_manager);
    }
}
