use std::str::FromStr;

use citp::protocol::caex::{FixtureList, FixtureListMessageType};
use citp::protocol::{caex, Ucs2};

use mizer_fixtures::manager::FixtureManager;

use crate::connection::handlers::{CitpMessageHandler, InternalWriteToBytes};
use crate::handler_name;

pub struct FixtureListRequestHandler {
    fixture_manager: Option<FixtureManager>,
}
handler_name!(FixtureListRequestHandler);

impl<'a> InternalWriteToBytes for FixtureList<'a> {}

impl CitpMessageHandler for FixtureListRequestHandler {
    const FIRST_HEADER_CONTENT_TYPE: &'static [u8; 4] = caex::Header::CONTENT_TYPE;
    const SECOND_HEADER_CONTENT_TYPE: &'static [u8; 4] =
        &caex::FixtureListRequest::CONTENT_TYPE.to_le_bytes();

    type Result<'a> = FixtureList<'a>;

    fn handle<'a>(&'a self, _data: &[u8]) -> anyhow::Result<Self::Result<'a>> {
        let fixtures = self.get_fixtures();

        let fixture_list = FixtureList {
            message_type: FixtureListMessageType::ExistingPatchList,
            fixture_count: fixtures.len() as u16,
            fixtures: fixtures.into(),
        };

        Ok(fixture_list)
    }

    fn announce<'a>(&'a self) -> anyhow::Result<Option<Self::Result<'a>>> {
        let fixtures = self.get_fixtures();

        let fixture_list = FixtureList {
            message_type: FixtureListMessageType::ExistingPatchList,
            fixture_count: fixtures.len() as u16,
            fixtures: fixtures.into(),
        };

        Ok(Some(fixture_list))
    }
}

impl FixtureListRequestHandler {
    pub fn new(fixture_manager: Option<FixtureManager>) -> Self {
        Self { fixture_manager }
    }

    fn get_fixtures(&self) -> Vec<caex::Fixture> {
        let Some(ref fixture_manager) = self.fixture_manager else {
            return Default::default();
        };
        let fixtures = fixture_manager.get_fixtures();

        fixtures
            .into_iter()
            .map(|fixture| citp::protocol::caex::Fixture {
                fixture_identifier: 0xffffffff,
                fixture_name: Ucs2::from_str(&fixture.name)
                    .or_else(|_| Ucs2::from_str(""))
                    .unwrap(),
                manufacturer_name: Ucs2::from_str(&fixture.definition.manufacturer)
                    .or_else(|_| Ucs2::from_str(""))
                    .unwrap(),
                mode_name: Ucs2::from_str(&fixture.channel_mode.name)
                    .or_else(|_| Ucs2::from_str(""))
                    .unwrap(),
                data: citp::protocol::caex::FixtureData {
                    patched: 1,
                    universe: fixture.universe as u8,
                    universe_channel: fixture.channel,
                    channel: fixture.id as u16,
                    unit: Ucs2::from_str("").unwrap(),
                    circuit: Ucs2::from_str("").unwrap(),
                    note: Ucs2::from_str("").unwrap(),
                    position: Default::default(),
                    angles: Default::default(),
                },
                channel_count: fixture.channel_mode.channel_count(),
                is_dimmer: 0,
                identifier_count: 0,
                identifiers: Default::default(),
            })
            .collect()
    }
}
