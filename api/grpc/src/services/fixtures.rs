use crate::protos::FixturesApi;
use crate::protos::{Fixture, Fixtures, GetFixturesRequest};
use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};
use mizer_fixtures::manager::FixtureManager;

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
        _: ServerRequestSingle<GetFixturesRequest>,
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
        log::trace!("GetFixtures: {:?}", fixtures);
        resp.finish(fixtures)
    }
}
