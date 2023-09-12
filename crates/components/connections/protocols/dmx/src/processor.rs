use mizer_processing::*;

use crate::DmxConnectionManager;

#[derive(Debug)]
pub(crate) struct DmxProcessor;

impl DebuggableProcessor for DmxProcessor {}

impl Processor for DmxProcessor {
    #[tracing::instrument]
    fn post_process(&mut self, injector: &Injector, _: ClockFrame) {
        profiling::scope!("DmxProcessor::post_process");
        if let Some(dmx) = injector.get::<DmxConnectionManager>() {
            dmx.flush();
        }
    }
}
