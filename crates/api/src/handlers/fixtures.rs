use std::ops::Deref;

use regex::Regex;

use mizer_command_executor::*;
use mizer_fixture_patch_export::PatchExporter;
use mizer_fixtures::fixture::ChannelLimit;
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;

use crate::proto::fixtures::*;
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

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_fixtures(&self) -> Fixtures {
        let mut fixtures = Fixtures::default();
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
                ),
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
                        ),
                    })
                    .collect(),
                config: Some(FixtureConfig {
                    invert_pan: fixture.configuration.invert_pan,
                    invert_tilt: fixture.configuration.invert_tilt,
                    reverse_pixel_order: fixture.configuration.reverse_pixel_order,
                    channel_limits: fixture.configuration.limits.iter().map(|(control, limits)| FixtureChannelLimit {
                        control: Some(control.clone().into()),
                        min: limits.min,
                        max: limits.max,
                    }).collect()
                }),
            };
            fixtures.fixtures.push(fixture_model);
        }
        fixtures
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_fixture_definitions(&self) -> FixtureDefinitions {
        let definitions = self
            .fixture_library
            .list_definitions()
            .into_iter()
            .map(FixtureDefinition::from)
            .collect();

        FixtureDefinitions {
            definitions,
            ..Default::default()
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_fixtures(&self, add_fixtures: AddFixturesRequest) {
        let request = add_fixtures.request.unwrap();
        let cmd = PatchFixturesCommand {
            definition_id: request.definition_id,
            mode: request.mode,
            start_id: request.id,
            start_channel: request.channel,
            universe: request.universe,
            name: request.name,
            count: add_fixtures.count,
        };
        self.runtime.run_command(cmd).unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn delete_fixtures(&self, fixture_ids: Vec<u32>) -> anyhow::Result<()> {
        let cmd = DeleteFixturesCommand { fixture_ids };
        self.runtime.run_command(cmd)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_fixture(&self, request: UpdateFixtureRequest) -> anyhow::Result<()> {
        let cmd = UpdateFixtureCommand {
            fixture_id: request.fixture_id,
            invert_pan: request.invert_pan,
            invert_tilt: request.invert_tilt,
            reverse_pixel_order: request.reverse_pixel_order,
            limit: request.limit.map(|limit| (limit.control.unwrap().into(), ChannelLimit {
                min: limit.min,
                max: limit.max,
            })),
            name: request.name,
            address: request
                .address
                .map(|address| (address.universe as u16, address.channel as u16)),
        };
        self.runtime.run_command(cmd)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn export_patch(&self, path: &str) -> anyhow::Result<()> {
        let fixtures = self.fixture_manager.get_fixtures();
        let patch_exporter = PatchExporter::new();
        let mut fixture_refs = fixtures
            .iter()
            .map(|fixture| fixture.deref())
            .collect::<Vec<_>>();
        fixture_refs.sort_by_key(|fixture| fixture.id);
        let pdf = patch_exporter.export_csv(fixture_refs.as_slice())?;

        std::fs::write(path, pdf)?;

        Ok(())
    }
}
