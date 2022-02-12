use crate::{Project, ProjectManagerMut};
use mizer_sequencer::EffectEngine;

impl ProjectManagerMut for EffectEngine {
    fn new(&mut self) {
        log::debug!("new effect engine");
        self.load_defaults();
    }

    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        log::debug!("load effect engine");
        for effect in &project.effects {
            self.effects.insert(effect.id, effect.clone());
        }
        Ok(())
    }

    fn save(&self, project: &mut Project) {
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
