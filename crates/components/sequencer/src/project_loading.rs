use crate::{Sequence, Sequencer};
use mizer_module::*;

impl ProjectHandler for Sequencer {
    fn get_name(&self) -> &'static str {
        "sequencer"
    }

    fn new_project(
        &mut self,
        context: &mut impl ProjectHandlerContext,
        _injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        self.clear();

        Ok(())
    }

    fn load_project(
        &mut self,
        context: &mut impl LoadProjectContext,
        _injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let sequences = context.read_file::<Vec<Sequence>>("sequences")?;
        self.load_sequences(sequences);

        Ok(())
    }

    fn save_project(
        &self,
        context: &mut impl SaveProjectContext,
        _injector: &dyn InjectDyn,
    ) -> anyhow::Result<()> {
        context.write_file("sequences", self.sequences())?;

        Ok(())
    }
}
