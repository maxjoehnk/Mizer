use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};

use mizer_fixtures::fixture::{ChannelResolution, PhysicalFixtureData};
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;

use crate::protos::*;
use protobuf::SingularPtrField;

pub struct FixturesApiImpl {
    fixture_manager: FixtureManager,
    fixture_library: FixtureLibrary,
}

impl FixturesApiImpl {
    pub fn new(fixture_manager: FixtureManager, fixture_library: FixtureLibrary) -> Self {
        FixturesApiImpl {
            fixture_manager,
            fixture_library,
        }
    }
}

impl FixturesApi for FixturesApiImpl {
    fn get_fixtures(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<GetFixturesRequest>,
        resp: ServerResponseUnarySink<Fixtures>,
    ) -> grpc::Result<()> {
        let fixtures = self.get_all_fixtures();
        log::trace!("GetFixtures: {:?}", fixtures);
        resp.finish(fixtures)
    }

    fn get_fixture_definitions(
        &self,
        o: ServerHandlerContext,
        req: ServerRequestSingle<GetFixtureDefinitionsRequest>,
        resp: ServerResponseUnarySink<FixtureDefinitions>,
    ) -> grpc::Result<()> {
        let definitions = self
            .fixture_library
            .list_definitions()
            .into_iter()
            .map(FixtureDefinition::from)
            .collect::<Vec<_>>();

        resp.finish(FixtureDefinitions {
            definitions: definitions.into(),
            ..Default::default()
        })
    }

    fn add_fixtures(&self, o: ServerHandlerContext, req: ServerRequestSingle<AddFixturesRequest>, resp: ServerResponseUnarySink<Fixtures>) -> grpc::Result<()> {
        for request in req.message.requests.into_iter() {
            let definition = self.fixture_library.get_definition(&request.definitionId).unwrap();
            self.fixture_manager.add_fixture(request.id, definition, request.mode.into(), "output".into(), request.channel as u8, Some(request.universe as u16));
        }

        let fixtures = self.get_all_fixtures();

        resp.finish(fixtures)
    }
}


impl From<mizer_fixtures::fixture::FixtureDefinition> for FixtureDefinition {
    fn from(definition: mizer_fixtures::fixture::FixtureDefinition) -> Self {
        let physical: FixturePhysicalData = definition.physical.into();
        FixtureDefinition {
            id: definition.id,
            name: definition.name,
            manufacturer: definition.manufacturer,
            modes: definition
                .modes
                .into_iter()
                .map(FixtureMode::from)
                .collect::<Vec<_>>()
                .into(),
            tags: definition.tags.into(),
            physical: SingularPtrField::some(physical),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::fixture::PhysicalFixtureData> for FixturePhysicalData {
    fn from(physical_data: PhysicalFixtureData) -> Self {
        let mut data = FixturePhysicalData::new();
        if let Some(dimensions) = physical_data.dimensions {
            data.width = dimensions.width;
            data.height = dimensions.height;
            data.depth = dimensions.depth;
        }
        if let Some(weight) = physical_data.weight {
            data.weight = weight;
        }

        data
    }
}

impl From<mizer_fixtures::fixture::FixtureMode> for FixtureMode {
    fn from(mode: mizer_fixtures::fixture::FixtureMode) -> Self {
        FixtureMode {
            name: mode.name,
            channels: mode
                .channels
                .into_iter()
                .map(FixtureChannel::from)
                .collect::<Vec<_>>()
                .into(),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::fixture::FixtureChannelDefinition> for FixtureChannel {
    fn from(channel: mizer_fixtures::fixture::FixtureChannelDefinition) -> Self {
        FixtureChannel {
            name: channel.name,
            resolution: Some(channel.resolution.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_fixtures::fixture::ChannelResolution> for FixtureChannel_oneof_resolution {
    fn from(resolution: mizer_fixtures::fixture::ChannelResolution) -> Self {
        match resolution {
            ChannelResolution::Coarse(coarse) => {
                FixtureChannel_oneof_resolution::coarse(FixtureChannel_CoarseResolution {
                    channel: coarse.into(),
                    ..Default::default()
                })
            }
            ChannelResolution::Fine(fine, coarse) => {
                FixtureChannel_oneof_resolution::fine(FixtureChannel_FineResolution {
                    fineChannel: fine.into(),
                    coarseChannel: coarse.into(),
                    ..Default::default()
                })
            }
            ChannelResolution::Finest(finest, fine, coarse) => {
                FixtureChannel_oneof_resolution::finest(FixtureChannel_FinestResolution {
                    finestChannel: finest.into(),
                    fineChannel: fine.into(),
                    coarseChannel: coarse.into(),
                    ..Default::default()
                })
            }
        }
    }
}

impl FixturesApiImpl {
    fn get_all_fixtures(&self) -> Fixtures {
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
}
