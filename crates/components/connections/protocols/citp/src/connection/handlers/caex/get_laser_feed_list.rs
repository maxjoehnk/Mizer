use citp::protocol::caex;
use citp::protocol::caex::LaserFeedList;

use crate::connection::handlers::{CitpMessageHandler, InternalWriteToBytes};
use crate::handler_name;

pub struct GetLaserFeedListHandler;
handler_name!(GetLaserFeedListHandler);

impl<'a> InternalWriteToBytes for LaserFeedList<'a> {}

impl CitpMessageHandler for GetLaserFeedListHandler {
    const FIRST_HEADER_CONTENT_TYPE: &'static [u8; 4] = caex::Header::CONTENT_TYPE;
    const SECOND_HEADER_CONTENT_TYPE: &'static [u8; 4] =
        &caex::GetLaserFeedList::CONTENT_TYPE.to_le_bytes();

    type Result<'a> = LaserFeedList<'a>;

    fn handle<'a>(&'a self, _data: &[u8]) -> anyhow::Result<Self::Result<'a>> {
        Ok(LaserFeedList {
            feed_count: 0,
            feed_names: vec![].into(),
            source_key: 0,
        })
    }
}
