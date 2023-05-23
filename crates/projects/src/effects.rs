use crate::{Project, ProjectManagerMut};
use mizer_sequencer::EffectEngine;

impl ProjectManagerMut for EffectEngine {
    fn new_project(&mut self) {
        log::debug!("new effect engine");
        self.load_defaults();
    }

    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("EffectEngine::load");
        log::debug!("load effect engine");
        for effect in &project.effects {
            self.effects.insert(effect.id, effect.clone());
        }
        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("EffectEngine::save");
        log::debug!("save effect engine");
        for effect in self.effects.iter() {
            project.effects.push(effect.value().clone());
        }
    }

    fn clear(&mut self) {
        log::debug!("clear effect engine");
        EffectEngine::clear(self);
    }
}
