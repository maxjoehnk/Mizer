use crate::models::fixtures::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::library::FixtureLibrary;
use mizer_runtime::RuntimeApi;

#[derive(Clone)]
pub struct FixturesHandler {
    fixture_manager: FixtureManager,
    fixture_library: FixtureLibrary,
    runtime: RuntimeApi,
}

impl FixturesHandler {
    pub fn new(fixture_manager: FixtureManager, fixture_library: FixtureLibrary, runtime: RuntimeApi) -> Self {
        Self {
            fixture_manager,
            fixture_library,
            runtime,
        }
    }

    pub fn get_fixtures(&self) -> Fixtures {
        let mut fixtures = Fixtures::new();
        for fixture in self.fixture_manager.get_fixtures() {
            let fixture_model = Fixture {
                channel: fixture.channel as u32,
                universe: fixture.universe as u32,
                id: fixture.id,
                name: fixture.definition.name.clone(),
                manufacturer: fixture.definition.manufacturer.clone(),
                mode: fixture.current_mode.name.clone(),
                ..Default::default()
            };
            fixtures.fixtures.push(fixture_model);
        }
        fixtures
    }

    pub fn get_fixture_definitions(&self) -> FixtureDefinitions {
        let definitions = self
            .fixture_library
            .list_definitions()
            .into_iter()
            .map(FixtureDefinition::from)
            .collect::<Vec<_>>();

        FixtureDefinitions {
            definitions: definitions.into(),
            ..Default::default()
        }
    }

    pub fn add_fixtures(&self, add_fixtures: AddFixturesRequest) {
        for request in add_fixtures.requests.into_iter() {
            let definition = self.fixture_library.get_definition(&request.definitionId).unwrap();
            self.fixture_manager.add_fixture(request.id, definition, request.mode.into(), "output".into(), request.channel as u8, Some(request.universe as u16));
            if add_fixtures.create_nodes {
                self.runtime.add_node_for_fixture(request.id).unwrap();
            }
        }
    }
}
