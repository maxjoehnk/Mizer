use mizer_command_executor::*;
use mizer_fixture_patch_export::PatchExporter;
use mizer_fixtures::fixture::ChannelLimit;

use crate::proto::fixtures::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct FixturesHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> FixturesHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_fixtures(&self) -> Fixtures {
        let fixtures = self.runtime.execute_query(ListFixturesQuery).unwrap();
        let fixtures = fixtures
            .into_iter()
            .map(|fixture| {
                let controls =
                    FixtureControls::with_values(&fixture, fixture.current_mode.controls.clone());
                let sub_fixtures = fixture
                    .current_mode
                    .sub_fixtures
                    .iter()
                    .map(|sub_fixture| {
                        let controls = FixtureControls::with_values(
                            &fixture.sub_fixture(sub_fixture.id).unwrap(),
                            sub_fixture.controls.clone(),
                        );
                        SubFixture {
                            id: sub_fixture.id,
                            name: sub_fixture.name.clone(),
                            controls,
                        }
                    })
                    .collect();
                Fixture {
                    channel: fixture.channel as u32,
                    universe: fixture.universe as u32,
                    channel_count: fixture.current_mode.dmx_channels() as u32,
                    id: fixture.id,
                    name: fixture.name,
                    manufacturer: fixture.definition.manufacturer,
                    model: fixture.definition.name,
                    mode: fixture.current_mode.name,
                    controls,
                    children: sub_fixtures,
                    config: Some(FixtureConfig {
                        invert_pan: fixture.configuration.invert_pan,
                        invert_tilt: fixture.configuration.invert_tilt,
                        reverse_pixel_order: fixture.configuration.reverse_pixel_order,
                        channel_limits: fixture
                            .configuration
                            .limits
                            .into_iter()
                            .map(|(control, limits)| FixtureChannelLimit {
                                control: Some(control.into()),
                                min: limits.min,
                                max: limits.max,
                            })
                            .collect(),
                    }),
                }
            })
            .collect();

        Fixtures { fixtures }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_fixture_definitions(&self) -> FixtureDefinitions {
        let definitions = self
            .runtime
            .execute_query(ListFixtureDefinitionsQuery::default())
            .unwrap();
        let definitions = definitions
            .into_iter()
            .map(FixtureDefinition::from)
            .collect();

        FixtureDefinitions { definitions }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_fixtures(&self, add_fixtures: AddFixturesRequest) {
        let cmd = into_patch_fixtures_command(add_fixtures);
        self.runtime.run_command(cmd).unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn preview_fixtures(&self, add_fixtures: AddFixturesRequest) -> anyhow::Result<Fixtures> {
        let definition = self
            .runtime
            .execute_query(GetFixtureDefinitionQuery {
                definition_id: add_fixtures.request.as_ref().unwrap().definition_id.clone(),
            })?
            .ok_or_else(|| anyhow::anyhow!("Unknown definition"))?;
        let cmd = into_patch_fixtures_command(add_fixtures);

        let mut fixtures = Fixtures::default();
        for fixture in cmd.preview(definition)? {
            let model = Fixture {
                channel: fixture.channel as u32,
                universe: fixture.universe as u32,
                channel_count: fixture.current_mode.dmx_channels() as u32,
                id: fixture.id,
                name: fixture.name.clone(),
                manufacturer: fixture.definition.manufacturer.clone(),
                model: fixture.definition.name.clone(),
                mode: fixture.current_mode.name.clone(),
                controls: Default::default(),
                children: Default::default(),
                config: None,
            };

            fixtures.fixtures.push(model);
        }

        Ok(fixtures)
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
            limit: request.limit.map(|limit| {
                (
                    limit.control.unwrap().into(),
                    ChannelLimit {
                        min: limit.min,
                        max: limit.max,
                    },
                )
            }),
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
        let fixtures = self.runtime.execute_query(ListFixturesQuery)?;
        let patch_exporter = PatchExporter::new();
        let mut fixture_refs = fixtures.iter().collect::<Vec<_>>();
        fixture_refs.sort_by_key(|fixture| fixture.id);
        let pdf = patch_exporter.export_csv(fixture_refs.as_slice())?;

        std::fs::write(path, pdf)?;

        Ok(())
    }
}

fn into_patch_fixtures_command(add_fixtures: AddFixturesRequest) -> PatchFixturesCommand {
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

    cmd
}
