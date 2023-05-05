use mizer_module::{Module, Runtime};

use crate::processor::SequenceProcessor;
use crate::sequencer::Sequencer;
use crate::{EffectEngine, EffectsProcessor};

pub struct SequencerModule(Sequencer);

impl SequencerModule {
    pub fn new() -> (Self, Sequencer) {
        let sequencer = Sequencer::new();

        (Self(sequencer.clone()), sequencer)
    }
}

impl Module for SequencerModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        runtime.injector_mut().provide(self.0);
        runtime.injector_mut().provide(EffectEngine::new());
        runtime.add_processor(SequenceProcessor.into());

        Ok(())
    }
}

pub struct EffectsModule(EffectEngine);

impl EffectsModule {
    pub fn new() -> (Self, EffectEngine) {
        let engine = EffectEngine::new();

        (Self(engine.clone()), engine)
    }
}

impl Module for EffectsModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        runtime.injector_mut().provide(self.0);
        runtime.add_processor(EffectsProcessor.into());

        Ok(())
    }
}
