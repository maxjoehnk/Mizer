use crate::MidiConnectionManager;
use mizer_processing::*;

#[derive(Debug)]
pub(crate) struct MidiProcessor;

impl Processor for MidiProcessor {
    #[tracing::instrument]
    fn pre_process(&mut self, injector: &mut Injector, _: ClockFrame) {
        profiling::scope!("MidiProcessor::pre_process");
        if let Some(midi) = injector.get::<MidiConnectionManager>() {
            midi.clear_device_requests();
        }
    }
}
