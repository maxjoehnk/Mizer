use mizer_module::*;

use crate::MediaServer;

pub struct MediaModule;

module_name!(MediaModule);

impl Module for MediaModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let media_server = MediaServer::new(context.status_handle(), context.settings().clone())?;
        context.provide_api(media_server.clone());
        context.provide(media_server);

        Ok(())
    }
}
