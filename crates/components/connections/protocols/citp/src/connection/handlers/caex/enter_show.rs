use citp::protocol::caex::EnterShow;
use citp::protocol::{caex, ReadFromBytes};

use crate::connection::handlers::{CitpMessageHandler, InternalWriteToBytes};
use crate::handler_name;

pub struct EnterShowHandler;
handler_name!(EnterShowHandler);

impl InternalWriteToBytes for EnterShow {}

impl CitpMessageHandler for EnterShowHandler {
    const FIRST_HEADER_CONTENT_TYPE: &'static [u8; 4] = caex::Header::CONTENT_TYPE;
    const SECOND_HEADER_CONTENT_TYPE: &'static [u8; 4] =
        &caex::EnterShow::CONTENT_TYPE.to_le_bytes();

    type Result<'a> = ();

    fn handle<'a>(&'a self, data: &[u8]) -> anyhow::Result<Self::Result<'a>> {
        let enter_show = EnterShow::read_from_bytes(data)?;
        tracing::debug!("EnterShow: {enter_show:?}");

        Ok(())
    }
}
