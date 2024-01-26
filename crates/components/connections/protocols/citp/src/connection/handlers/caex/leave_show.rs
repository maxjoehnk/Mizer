use citp::protocol::caex;

use crate::connection::handlers::CitpMessageHandler;
use crate::handler_name;

pub struct LeaveShowHandler;

handler_name!(LeaveShowHandler);

impl CitpMessageHandler for LeaveShowHandler {
    const FIRST_HEADER_CONTENT_TYPE: &'static [u8; 4] = caex::Header::CONTENT_TYPE;
    const SECOND_HEADER_CONTENT_TYPE: &'static [u8; 4] =
        &caex::LeaveShow::CONTENT_TYPE.to_le_bytes();

    type Result<'a> = ();

    fn handle<'a>(&'a self, _data: &[u8]) -> anyhow::Result<Self::Result<'a>> {
        Ok(())
    }
}
