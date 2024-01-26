use citp::protocol::pinf;

use crate::connection::handlers::CitpMessageHandler;
use crate::handler_name;

pub struct NameHandler;

handler_name!(NameHandler);

impl CitpMessageHandler for NameHandler {
    const FIRST_HEADER_CONTENT_TYPE: &'static [u8; 4] = pinf::Header::CONTENT_TYPE;
    const SECOND_HEADER_CONTENT_TYPE: &'static [u8; 4] = pinf::PNam::CONTENT_TYPE;

    type Result<'a> = ();

    fn handle<'a>(&'a self, _data: &[u8]) -> anyhow::Result<Self::Result<'a>> {
        Ok(())
    }
}
