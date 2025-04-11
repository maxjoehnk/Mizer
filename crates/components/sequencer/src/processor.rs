use crate::sequencer::Sequencer;
use crate::EffectEngine;
use mizer_fixtures::manager::FixtureManager;
use mizer_module::*;
use mizer_node_ports::NodePortState;

#[derive(Debug)]
pub(crate) struct SequenceProcessor;

impl Processor for SequenceProcessor {
    #[tracing::instrument]
    fn process(&mut self, injector: &mut Injector, frame: ClockFrame) {
        profiling::scope!("SequenceProcessor::process");
        let sequencer = injector.inject::<Sequencer>();
        let fixture_manager = injector.inject::<FixtureManager>();
        let effect_engine = injector.inject::<EffectEngine>();
        let ports_state = injector.inject::<NodePortState>();
        sequencer.run_sequences(fixture_manager, effect_engine, ports_state, frame);
    }
}
