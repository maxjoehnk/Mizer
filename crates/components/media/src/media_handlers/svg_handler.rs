use crate::documents::MediaType;
use crate::media_handlers::MediaHandler;

#[derive(Clone)]
pub struct SvgHandler;

impl MediaHandler for SvgHandler {
    const MEDIA_TYPE: MediaType = MediaType::Vector;

    fn supported(content_type: &str) -> bool {
        content_type == "text/xml" || content_type == "image/svg+xml"
    }
}
