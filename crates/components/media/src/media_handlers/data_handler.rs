use crate::documents::MediaType;
use crate::media_handlers::{MediaHandler};

#[derive(Clone)]
pub struct DataHandler;

impl MediaHandler for DataHandler {
    const MEDIA_TYPE: MediaType = MediaType::Data;

    fn supported(content_type: &str) -> bool {
        content_type == "text/csv"
    }
}
