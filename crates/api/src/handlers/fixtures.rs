use std::str::FromStr;
use mizer_command_executor::*;
use mizer_fixture_patch_export::PatchExporter;
use mizer_fixtures::ChannelLimit;
use mizer_fixtures::fixture::IFixture;

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
        let fixtures = self.runtime.query(ListFixturesQuery).unwrap();
        let fixtures = fixtures
            .into_iter()
            .map(|fixture| {
                let sub_fixtures = fixture
                    .channel_mode
                    .children
                    .iter()
                    .map(|sub_fixture_definition| {
                        let sub_fixture = fixture.sub_fixture(sub_fixture_definition.id).unwrap();
                        let channels = sub_fixture_definition.channels.values()
                            .map(|channel| {
                                let value = sub_fixture.read_channel(channel.channel);

                                FixtureChannel {
                                    category: FixtureChannelCategory::from(channel.channel_category()).into(),
                                    channel: channel.channel.to_string(),
                                    label: channel.label.as_ref().map(|label| label.to_string()),
                                    value: value.map(|v| FixtureValue {
                                        value: Some(fixture_value::Value::Percent(v)),
                                    }),
                                    presets: Default::default(),
                                }
                            })
                            .collect();
                        
                        SubFixture {
                            id: sub_fixture_definition.id,
                            name: sub_fixture_definition.name.to_string(),
                            channels,
                        }
                    })
                    .collect();
                
                let channels = fixture.channel_mode.channels.values()
                    .map(|channel| {
                        let value = fixture.read_channel(channel.channel);

                        FixtureChannel {
                            category: FixtureChannelCategory::from(channel.channel_category()).into(),
                            channel: channel.channel.to_string(),
                            label: channel.label.as_ref().map(|label| label.to_string()),
                            value: value.map(|v| FixtureValue {
                                value: Some(fixture_value::Value::Percent(v)),
                            }),
                            presets: Default::default(),
                        }
                    })
                    .collect();
                
                Fixture {
                    channel: fixture.channel as u32,
                    universe: fixture.universe as u32,
                    channel_count: fixture.channel_mode.dmx_channel_count as u32,
                    id: fixture.id,
                    name: fixture.name,
                    manufacturer: fixture.definition.manufacturer,
                    model: fixture.definition.name,
                    mode: fixture.channel_mode.name.to_string(),
                    channels,
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
                                channel: control.to_string(),
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
            .query(ListFixtureDefinitionsQuery::default())
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
            .query(GetFixtureDefinitionQuery {
                definition_id: add_fixtures.request.as_ref().unwrap().definition_id.clone(),
            })?
            .ok_or_else(|| anyhow::anyhow!("Unknown definition"))?;
        let cmd = into_patch_fixtures_command(add_fixtures);

        let mut fixtures = Fixtures::default();
        for fixture in cmd.preview(definition)? {
            let model = Fixture {
                channel: fixture.channel as u32,
                universe: fixture.universe as u32,
                channel_count: fixture.channel_mode.dmx_channel_count as u32,
                id: fixture.id,
                name: fixture.name.clone(),
                manufacturer: fixture.definition.manufacturer.clone(),
                model: fixture.definition.name.clone(),
                mode: fixture.channel_mode.name.to_string(),
                channels: Default::default(),
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
                    mizer_fixtures::channels::FixtureChannel::from_str(&limit.channel).unwrap(),
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
        let fixtures = self.runtime.query(ListFixturesQuery)?;
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
