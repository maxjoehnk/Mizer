use mizer_module::*;
use crate::{TimecodeControl, TimecodeManager, TimecodeTrack};

impl ProjectHandler for TimecodeManager {
    fn get_name(&self) -> &'static str {
        "timecode"
    }

    fn new_project(&mut self, _context: &mut impl ProjectHandlerContext, _injector: &mut dyn InjectDynMut) -> anyhow::Result<()> {
        self.clear();
        
        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext, _injector: &mut dyn InjectDynMut) -> anyhow::Result<()> {
        self.clear();
        profiling::scope!("TimecodeManager::load");
        let timecodes = context.read_file::<Vec<TimecodeTrack>>("timecodes")?;
        let controls = context.read_file::<Vec<TimecodeControl>>("controls")?;
        self.load_timecodes(timecodes, controls);

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext, _injector: &dyn InjectDyn) -> anyhow::Result<()> {
        profiling::scope!("TimecodeManager::save");
        context.write_file("timecodes", self.timecodes())?;
        context.write_file("controls", self.controls())?;

        Ok(())
    }
}
