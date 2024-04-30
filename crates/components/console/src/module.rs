use mizer_module::*;
use crate::aggregator::ConsoleAggregator;

pub struct ConsoleModule;

module_name!(ConsoleModule);

impl Module for ConsoleModule {
    const IS_REQUIRED: bool = true;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let (buffer, history) = ConsoleAggregator::init()?;
        context.spawn(buffer.distribute());
        context.provide_api(history);
        
        Ok(())
    }
}
