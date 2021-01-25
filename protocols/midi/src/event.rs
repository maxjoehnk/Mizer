use crate::message::MidiMessage;

#[derive(Debug, Clone)]
pub struct MidiEvent {
    pub timestamp: u64,
    pub msg: MidiMessage,
}
