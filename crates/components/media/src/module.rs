use mizer_module::{Module, Runtime};
use mizer_settings::Settings;

use crate::MediaServer;

pub struct MediaModule(MediaServer);

impl MediaModule {
    pub fn new(settings: Settings) -> anyhow::Result<(Self, MediaServer)> {
        let media_server = MediaServer::new(settings)?;

        Ok((Self(media_server.clone()), media_server))
    }
}

impl Module for MediaModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        runtime.injector_mut().provide(self.0);

        Ok(())
    }
}
