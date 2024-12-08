use mizer_module::*;

use crate::effects::debug_ui_pane::EffectsDebugUiPane;
use crate::effects::{EffectEngine, EffectsProcessor};

pub struct EffectsModule;

module_name!(EffectsModule);

impl Module for EffectsModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let engine = EffectEngine::new();
        context.provide_api(engine.clone());
        context.add_project_handler(engine.clone());
        context.provide(engine);
        context.add_processor(EffectsProcessor);
        context.add_debug_ui_pane(EffectsDebugUiPane);

        Ok(())
    }
}
