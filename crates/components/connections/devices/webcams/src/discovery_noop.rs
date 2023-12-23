use crate::WebcamRef;
use futures::Stream;

pub struct WebcamDiscovery;

impl WebcamDiscovery {
    pub fn new() -> Self {
        Self
    }

    pub fn into_stream(self) -> impl Stream<Item = WebcamRef> {
        futures::stream::empty()
    }
}
