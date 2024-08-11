use mizer_processing::*;

use crate::DmxConnectionManager;

#[derive(Debug)]
pub(crate) struct DmxProcessor;

impl Processor for DmxProcessor {
    fn priorities(&self) -> ProcessorPriorities {
        ProcessorPriorities {
            post_process: 500,
            ..Default::default()
        }
    }

    #[tracing::instrument]
    fn post_process(&mut self, injector: &mut Injector, _: ClockFrame) {
        profiling::scope!("DmxProcessor::post_process");
        if let Some(dmx) = injector.get_mut::<DmxConnectionManager>() {
            dmx.flush();
        }
    }
}
