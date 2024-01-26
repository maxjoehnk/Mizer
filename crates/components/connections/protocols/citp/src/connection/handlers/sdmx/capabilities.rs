use citp::protocol::sdmx;

use crate::connection::handlers::CitpMessageHandler;
use crate::handler_name;

pub struct CapabilitiesHandler;

handler_name!(CapabilitiesHandler);

impl CitpMessageHandler for CapabilitiesHandler {
    const FIRST_HEADER_CONTENT_TYPE: &'static [u8; 4] = sdmx::Header::CONTENT_TYPE;
    const SECOND_HEADER_CONTENT_TYPE: &'static [u8; 4] = sdmx::Capa::CONTENT_TYPE;

    type Result<'a> = ();

    fn handle<'a>(&'a self, _data: &[u8]) -> anyhow::Result<Self::Result<'a>> {
        Ok(())
    }
}
