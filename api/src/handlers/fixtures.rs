use mizer_command_executor::*;
use protobuf::SingularPtrField;
use regex::Regex;
use std::ops::Deref;

use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;

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
                )
                .into(),
                children: fixture
                    .current_mode
                    .sub_fixtures
                    .iter()
                    .map(|sub_fixture| SubFixture {
                        id: sub_fixture.id,
                        name: sub_fixture.name.clone(),
                        controls: FixtureControls::with_values(
                            &fixture.sub_fixture(sub_fixture.id).unwrap(),
                            sub_fixture.controls.clone(),
                        )
                        .into(),
                        ..Default::default()
                    })
                    .collect(),
                config: SingularPtrField::some(FixtureConfig {
                    invert_pan: fixture.configuration.invert_pan,
                    invert_tilt: fixture.configuration.invert_tilt,
                    ..Default::default()
                }),
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
        let cmd = PatchFixturesCommand {
            definition_id: request.definitionId,
            mode: request.mode,
            start_id: request.id,
            start_channel: request.channel,
            universe: request.universe,
            name: request.name,
            count: add_fixtures.count,
        };
        self.runtime.run_command(cmd).unwrap();
    }

    pub fn delete_fixtures(&self, fixture_ids: Vec<u32>) -> anyhow::Result<()> {
        let cmd = DeleteFixturesCommand { fixture_ids };
        self.runtime.run_command(cmd)?;

        Ok(())
    }

    pub fn update_fixture(&self, request: UpdateFixtureRequest) -> anyhow::Result<()> {
        let cmd = UpdateFixtureCommand {
            fixture_id: request.fixtureId,
            invert_pan: request._invert_pan.and_then(|value| {
                if let UpdateFixtureRequest_oneof__invert_pan::invert_pan(value) = value {
                    Some(value)
                } else {
                    None
                }
            }),
            invert_tilt: request._invert_tilt.and_then(|value| {
                if let UpdateFixtureRequest_oneof__invert_tilt::invert_tilt(value) = value {
                    Some(value)
                } else {
                    None
                }
            }),
        };
        self.runtime.run_command(cmd)?;

        Ok(())
    }
}
