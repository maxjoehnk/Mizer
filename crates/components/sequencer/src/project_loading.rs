use mizer_module::*;
use crate::{Sequence, Sequencer};

impl ProjectHandler for Sequencer {
    fn get_name(&self) -> &'static str {
        "sequencer"
    }

    fn new_project(&mut self, context: &mut impl ProjectHandlerContext) -> anyhow::Result<()> {
        self.clear();

        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext) -> anyhow::Result<()> {
        let sequences = context.read_file::<Vec<Sequence>>("sequences")?;
        self.load_sequences(sequences);

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext) -> anyhow::Result<()> {
        context.write_file("sequences", self.sequences())?;

        Ok(())
    }
}
