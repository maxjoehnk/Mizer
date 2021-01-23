use crate::protos::FixturesApi;
use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};
use mizer_fixtures::manager::FixtureManager;
use mizer_proto::fixtures::{Fixture, Fixtures, GetFixturesRequest};

pub struct FixturesApiImpl {
    fixture_manager: FixtureManager,
}

impl FixturesApiImpl {
    pub fn new(fixture_manager: FixtureManager) -> Self {
        FixturesApiImpl { fixture_manager }
    }
}

impl FixturesApi for FixturesApiImpl {
    fn get_fixtures(
        &self,
        _: ServerHandlerContext,
        req: ServerRequestSingle<GetFixturesRequest>,
        resp: ServerResponseUnarySink<Fixtures>,
    ) -> grpc::Result<()> {
        let mut fixtures = Fixtures::new();
        for fixture in self.fixture_manager.get_fixtures() {
            let fixture_model = Fixture {
                channel: fixture.channel as i32,
                universe: fixture.universe as i32,
                id: fixture.id.clone(),
                name: fixture.definition.name.clone(),
                manufacturer: fixture.definition.manufacturer.clone(),
                ..Default::default()
            };
            fixtures.fixtures.push(fixture_model);
        }
        resp.finish(fixtures)
    }
}
