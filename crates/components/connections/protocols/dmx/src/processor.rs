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

    fn pre_process(&mut self, injector: &InjectionScope, _frame: ClockFrame, _fps: f64) {
        profiling::scope!("DmxProcessor::pre_process");
        if let Some(dmx) = injector.try_inject_mut::<DmxConnectionManager>() {
            dmx.buffer.pristine();
        }
    }

    #[tracing::instrument]
    fn post_process(&mut self, injector: &InjectionScope, _: ClockFrame) {
        profiling::scope!("DmxProcessor::post_process");
        if let Some(dmx) = injector.try_inject_mut::<DmxConnectionManager>() {
            dmx.flush();
            dmx.buffer.cleanup();
        }
    }
}
