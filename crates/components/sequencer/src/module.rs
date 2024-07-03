use mizer_module::*;

use crate::processor::SequenceProcessor;
use crate::sequencer::Sequencer;

pub struct SequencerModule;

module_name!(SequencerModule);

impl Module for SequencerModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let sequencer = Sequencer::new();
        context.provide_api(sequencer.clone());
        context.add_project_handler(sequencer.clone());
        context.provide(sequencer);
        context.add_processor(SequenceProcessor);

        Ok(())
    }
}
