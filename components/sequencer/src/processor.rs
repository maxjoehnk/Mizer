use mizer_module::{Processor, Injector};
use crate::sequencer::Sequencer;
use mizer_fixtures::manager::FixtureManager;

pub(crate) struct SequenceProcessor;

impl Processor for SequenceProcessor {
    fn process(&self, injector: &Injector) {
        let sequencer = injector.get::<Sequencer>().unwrap();
        let fixture_manager = injector.get::<FixtureManager>().expect("sequencer requires fixtures");
        sequencer.run_sequences(fixture_manager);
    }
}
