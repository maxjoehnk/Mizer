use mizer_fixtures::fixture::FixtureChannelGroupType;
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;

use crate::models::fixtures::*;
use crate::RuntimeApi;

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
                id: fixture.id,
                name: fixture.definition.name.clone(),
                manufacturer: fixture.definition.manufacturer.clone(),
                mode: fixture.current_mode.name.clone(),
                channels: fixture
                    .current_mode
                    .groups
                    .iter()
                    .map(|group| FixtureChannelGroup::with_values(group, &fixture.channel_values))
                    .collect(),
                dmxChannels: fixture
                    .current_mode
                    .channels
                    .iter()
                    .map(|channel| {
                        DmxChannel::with_value(
                            channel,
                            fixture
                                .channel_values
                                .get(&channel.name)
                                .copied()
                                .unwrap_or_default(),
                        )
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
        for request in add_fixtures.requests.into_iter() {
            let definition = self
                .fixture_library
                .get_definition(&request.definitionId)
                .unwrap();
            self.fixture_manager.add_fixture(
                request.id,
                definition,
                request.mode.into(),
                None,
                request.channel as u8,
                Some(request.universe as u16),
            );
            self.runtime.add_node_for_fixture(request.id).unwrap();
        }
    }

    pub fn write_fixture_channel(&self, request: WriteFixtureChannelRequest) {
        let value = request.value.unwrap();
        let channel = request.channel.as_str();
        for fixture_id in request.ids {
            if let Some(mut fixture) = self.fixture_manager.get_fixture_mut(fixture_id) {
                match &value {
                    WriteFixtureChannelRequest_oneof_value::color(value) => {
                        if let Some(color_group) = fixture
                            .current_mode
                            .groups
                            .iter()
                            .find(|g| g.name == channel)
                        {
                            if let FixtureChannelGroupType::Color(color_group) =
                                color_group.group_type.clone()
                            {
                                fixture.write(&color_group.red, value.red);
                                fixture.write(&color_group.green, value.green);
                                fixture.write(&color_group.blue, value.blue);
                            }
                        }
                    }
                    WriteFixtureChannelRequest_oneof_value::fader(value) => {
                        fixture.write(&request.channel, *value);
                    }
                }
            }
        }
    }
}
