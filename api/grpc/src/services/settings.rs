use grpc::{ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::SettingsHandler;
use mizer_api::RuntimeApi;

use crate::protos::{RequestSettings, Settings, SettingsApi};

impl<R: RuntimeApi> SettingsApi for SettingsHandler<R> {
    fn load_settings(
        &self,
        _: ServerRequestSingle<RequestSettings>,
        resp: ServerResponseUnarySink<Settings>,
    ) -> grpc::Result<()> {
        resp.finish(self.get_settings())
    }

    fn save_settings(
        &self,
        req: ServerRequestSingle<Settings>,
        resp: ServerResponseUnarySink<Settings>,
    ) -> grpc::Result<()> {
        self.save_settings(req.message.clone()).unwrap();

        resp.finish(req.message)
    }
}
