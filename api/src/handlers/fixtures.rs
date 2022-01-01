use std::str::FromStr;
use std::ops::Deref;
use regex::Regex;

use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;
use mizer_node::NodeType;
use mizer_nodes::Node;

use crate::models::fixtures::*;
use crate::RuntimeApi;

lazy_static::lazy_static! {
    static ref FIXTURE_NAME_REGEX: Regex = Regex::new("^(?P<name>.*?)(?P<counter>[0-9]+)?$").unwrap();
}

#[derive(Clone)]
pub struct FixturesHandler<R: RuntimeApi> {
    fixture_manager: FixtureManager,
    fixture_library: FixtureLibrary,
    runtime: R,
}

impl<R: RuntimeApi> FixturesHandler<R> {
    pub fn new(
        fixture_manager: FixtureManager,
        fixture_library: FixtureLibrary,
        runtime: R,
    ) -> Self {
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
                channel_count: fixture.current_mode.dmx_channels() as u32,
                id: fixture.id,
                name: fixture.name.clone(),
                manufacturer: fixture.definition.manufacturer.clone(),
                model: fixture.definition.name.clone(),
                mode: fixture.current_mode.name.clone(),
                controls: FixtureControls::with_values(
                    fixture.deref() as &mizer_fixtures::fixture::Fixture,
                    fixture.current_mode.controls.clone(),
                ).into(),
                children: fixture.current_mode.sub_fixtures.iter()
                    .map(|sub_fixture| SubFixture {
                        id: sub_fixture.id,
                        name: sub_fixture.name.clone(),
                        controls: FixtureControls::with_values(&fixture.sub_fixture(sub_fixture.id).unwrap(), sub_fixture.controls.clone()).into(),
                        ..Default::default()
                    })
                    .collect(),
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
        let request = add_fixtures.request.unwrap();
        let definition = self
            .fixture_library
            .get_definition(&request.definitionId)
            .unwrap();
        let captures = FIXTURE_NAME_REGEX.captures(&request.name).unwrap();
        if let Some(mode) = definition.get_mode(&request.mode) {
            for i in 0..add_fixtures.count {
                let fixture_id = request.id + i;
                let name = Self::built_name(&captures, i);
                let offset = mode.dmx_channels() * (i as u8);
                self.fixture_manager.add_fixture(
                    fixture_id,
                    name,
                    definition.clone(),
                    request.mode.clone().into(),
                    None,
                    (request.channel as u8) + offset,
                    Some(request.universe as u16),
                );
                self.runtime.add_node_for_fixture(fixture_id).unwrap();
            }
        }
    }

    fn built_name(captures: &regex::Captures, index: u32) -> String {
        let base_name = &captures["name"];
        if let Some(counter) = captures.name("counter") {
            let counter = u32::from_str(counter.as_str()).unwrap();
            let counter = counter + index;

            format!("{}{}", base_name, counter)
        }else {
            base_name.to_string()
        }
    }

    pub fn delete_fixtures(&self, fixture_ids: Vec<u32>) -> anyhow::Result<()> {
        for id in fixture_ids {
            self.delete_fixture_node(id)?;
            self.fixture_manager.delete_fixture(id);
        }
        Ok(())
    }

    fn delete_fixture_node(&self, id: u32) -> anyhow::Result<()> {
        if let Some(path) = self.runtime.nodes()
            .into_iter()
            .filter(|node| node.node_type() == NodeType::Fixture)
            .find(|node| if let Node::Fixture(fixture_node) = node.downcast() {
                fixture_node.fixture_id == id
            } else { false })
            .map(|node| node.path) {
            self.runtime.delete_node(path)?;
        }
        Ok(())
    }
}
