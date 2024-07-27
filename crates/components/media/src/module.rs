use mizer_module::*;
use crate::background_media_job::BackgroundMediaJob;

use crate::MediaServer;

pub struct MediaModule;

module_name!(MediaModule);

impl Module for MediaModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let media_server = MediaServer::new(context.status_handle(), context.settings().clone())?;
        let event_bus = media_server.event_bus.subscribe();
        context.provide_api(media_server.clone());
        context.provide(media_server.clone());
        
        context.add_background_job(BackgroundMediaJob::new(media_server, event_bus));

        Ok(())
    }
}
