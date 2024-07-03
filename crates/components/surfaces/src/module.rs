use mizer_message_bus::MessageBus;
use mizer_module::*;
use crate::project_loading::SurfaceProjectHandler;
use crate::registry::SurfaceRegistry;
use crate::Surface;

pub struct SurfaceModule;

module_name!(SurfaceModule);

#[derive(Clone)]
pub struct SurfaceRegistryApi {
    pub bus: MessageBus<Vec<Surface>>,
}

impl Module for SurfaceModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let registry = SurfaceRegistry::new();
        let api = SurfaceRegistryApi {
            bus: registry.bus.clone(),
        };
        context.provide(SurfaceProjectHandler);
        
        context.provide_api(api);

        Ok(())
    }
}
