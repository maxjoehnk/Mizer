use mizer_module::*;
use crate::{Effect, EffectEngine};

impl ProjectHandler for EffectEngine {
    fn get_name(&self) -> &'static str {
        "effects"
    }

    fn new_project(&mut self, _context: &mut impl ProjectHandlerContext) -> anyhow::Result<()> {
        self.clear();
        self.load_defaults();

        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext) -> anyhow::Result<()> {
        self.clear();
        let effects = context.read_file::<Vec<Effect>>("effects")?;
        profiling::scope!("EffectEngine::load_project");
        tracing::debug!("load effect engine");
        for effect in &effects {
            self.effects.insert(effect.id, effect.clone());
        }

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext) -> anyhow::Result<()> {
        profiling::scope!("EffectEngine::save_project");
        tracing::debug!("save effect engine");
        let mut effects = Vec::with_capacity(self.effects.len());
        for effect in self.effects.iter() {
            effects.push(effect.value().clone());
        }

        context.write_file("effects", &effects)?;

        Ok(())
    }
}
