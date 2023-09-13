use mizer_processing::*;

use crate::MidiConnectionManager;

#[derive(Debug)]
pub(crate) struct MidiProcessor;

impl Processor for MidiProcessor {
    #[tracing::instrument]
    fn pre_process(&mut self, injector: &mut Injector, _: ClockFrame) {
        profiling::scope!("MidiProcessor::pre_process");
        if let Some(midi) = injector.get_mut::<MidiConnectionManager>() {
            midi.clear_device_requests();
            if let Err(err) = midi.search_available_devices() {
                log::error!("Failed to search for available MIDI devices: {err:?}");
            }
        }
    }
}

impl DebuggableProcessor for MidiProcessor {}
