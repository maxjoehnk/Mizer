use grpc::{ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::SettingsHandler;

use crate::protos::{RequestSettings, Settings, SettingsApi};

impl SettingsApi for SettingsHandler {
    fn load_settings(
        &self,
        _: ServerRequestSingle<RequestSettings>,
        resp: ServerResponseUnarySink<Settings>,
    ) -> grpc::Result<()> {
        resp.finish(self.get_settings())
    }
}
