use crate::{Project, ProjectManager};
use mizer_sequencer::Sequencer;

impl ProjectManager for Sequencer {
    fn load(&self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("Sequencer::load");
        self.load_sequences(project.sequences.clone());

        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("Sequencer::save");
        project.sequences = self.sequences();
    }

    fn clear(&self) {
        self.clear();
    }
}
