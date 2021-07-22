use grpc::{ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::FixturesHandler;
use mizer_api::models::*;

use crate::protos::*;
use mizer_api::RuntimeApi;

impl<R: RuntimeApi> FixturesApi for FixturesHandler<R> {
    fn get_fixtures(
        &self,
        _: ServerRequestSingle<GetFixturesRequest>,
        resp: ServerResponseUnarySink<Fixtures>,
    ) -> grpc::Result<()> {
        let fixtures = self.get_fixtures();
        log::trace!("GetFixtures: {:?}", fixtures);

        resp.finish(fixtures)
    }

    fn get_fixture_definitions(
        &self,
        _: ServerRequestSingle<GetFixtureDefinitionsRequest>,
        resp: ServerResponseUnarySink<FixtureDefinitions>,
    ) -> grpc::Result<()> {
        let definitions = self.get_fixture_definitions();

        resp.finish(definitions)
    }

    fn add_fixtures(
        &self,
        req: ServerRequestSingle<AddFixturesRequest>,
        resp: ServerResponseUnarySink<Fixtures>,
    ) -> grpc::Result<()> {
        self.add_fixtures(req.message);
        let fixtures = self.get_fixtures();

        resp.finish(fixtures)
    }

    fn write_fixture_channel(
        &self,
        req: ServerRequestSingle<WriteFixtureChannelRequest>,
        resp: ServerResponseUnarySink<Fixtures>,
    ) -> grpc::Result<()> {
        self.write_fixture_channel(req.message);
        let fixtures = self.get_fixtures();

        resp.finish(fixtures)
    }
}
