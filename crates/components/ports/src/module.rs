use crate::NodePortState;
use mizer_module::*;

pub struct PortsModule;

module_name!(PortsModule);

impl Module for PortsModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let state = NodePortState::new();
        context.provide_api(state.clone());
        context.provide(state);

        Ok(())
    }
}
