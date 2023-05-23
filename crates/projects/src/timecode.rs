use crate::{Project, ProjectManager};
use mizer_timecode::TimecodeManager;

impl ProjectManager for TimecodeManager {
    fn load(&self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("TimecodeManager::load");
        self.load_timecodes(
            project.timecodes.timecodes.clone(),
            project.timecodes.controls.clone(),
        );

        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("TimecodeManager::save");
        project.timecodes.timecodes = self.timecodes();
        project.timecodes.controls = self.controls();
    }

    fn clear(&self) {
        self.clear();
    }
}
