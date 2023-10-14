use mizer_message_bus::MessageBus;
use mizer_module::{Module, Runtime};

use crate::registry::SurfaceRegistry;
use crate::Surface;

pub struct SurfaceModule {
    registry: SurfaceRegistry,
}

impl SurfaceModule {
    pub fn new() -> (Self, SurfaceRegistryApi) {
        let registry = SurfaceRegistry::new();
        let api = SurfaceRegistryApi {
            bus: registry.bus.clone(),
        };

        (Self { registry }, api)
    }
}

#[derive(Clone)]
pub struct SurfaceRegistryApi {
    pub bus: MessageBus<Vec<Surface>>,
}

impl Module for SurfaceModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        runtime.injector_mut().provide(self.registry);

        Ok(())
    }
}
