use evmap::shallow_copy::CopyValue;
use evmap::{ReadHandle, WriteHandle};
use mizer_midi_device_profiles::{DeviceControl, GridRef, MidiResolution};
use mizer_midi_messages::{Channel, MidiEvent, MidiMessage};
use mizer_util::LerpExt;

const HIGH_RES_CONTROL_OFFSET: u8 = 32;

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct MidiTimestamp(u64);

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
struct MidiValue {
    value: u8,
    timestamp: u64,
}

pub(crate) struct DeviceStateWriter {
    write: WriteHandle<MidiControlType, CopyValue<MidiValue>>,
}

impl DeviceStateWriter {
    pub fn write(&mut self, event: MidiEvent) {
        match event.msg {
            MidiMessage::NoteOn(channel, control, value) => {
                let control_type = MidiControlType::Note(channel, control);
                let value = MidiValue {
                    value,
                    timestamp: event.timestamp,
                };
                tracing::trace!("Inserting {control_type:?} => {value:?}");
                self.write.update(control_type, CopyValue::from(value));
            }
            MidiMessage::NoteOff(channel, control, _) => {
                let control_type = MidiControlType::Note(channel, control);
                let value = MidiValue {
                    value: 0,
                    timestamp: event.timestamp,
                };
                tracing::trace!("Inserting {control_type:?} => {value:?}");
                self.write.update(control_type, CopyValue::from(value));
            }
            MidiMessage::ControlChange(channel, control, value) => {
                let control_type = MidiControlType::ControlChange(channel, control);
                let value = MidiValue {
                    value,
                    timestamp: event.timestamp,
                };
                tracing::trace!("Inserting {control_type:?} => {value:?}");
                self.write.update(control_type, CopyValue::from(value));
            }
            _ => (),
        }
        self.write.refresh();
    }
}

pub struct DeviceState {
    data: ReadHandle<MidiControlType, CopyValue<MidiValue>>,
}

impl DeviceState {
    pub(crate) fn new() -> (DeviceState, DeviceStateWriter) {
        let (read_handle, write_handle) = evmap::new();

        let writer = DeviceStateWriter {
            write: write_handle,
        };
        let state = DeviceState { data: read_handle };

        (state, writer)
    }

    pub fn read_grid(&self, grid: &GridRef) -> Vec<f64> {
        let mut values = Vec::with_capacity(grid.len());
        for control in grid.controls() {
            if let Some(input) = control.input.as_ref() {
                let value = self.read_control_changes(input, None);
                if let Some((value, _)) = value {
                    values.push(value);
                } else {
                    values.push(Default::default())
                }
            }
        }

        values
    }

    pub fn read_note_changes(
        &self,
        channel: Channel,
        note: u8,
        last_read: Option<MidiTimestamp>,
    ) -> Option<(u8, MidiTimestamp)> {
        self.read_changes(&MidiControlType::Note(channel, note), last_read)
    }

    pub fn read_cc_changes(
        &self,
        channel: Channel,
        note: u8,
        last_read: Option<MidiTimestamp>,
    ) -> Option<(u8, MidiTimestamp)> {
        self.read_changes(&MidiControlType::ControlChange(channel, note), last_read)
    }

    pub fn read_control_changes(
        &self,
        control: &DeviceControl,
        last_read_at: Option<MidiTimestamp>,
    ) -> Option<(f64, MidiTimestamp)> {
        match control {
            DeviceControl::MidiNote(note) => self
                .read_note_changes(note.channel, note.note, last_read_at)
                .map(|(value, last_changed)| {
                    (
                        (value as u16).linear_extrapolate(note.range, (0., 1.)),
                        last_changed,
                    )
                }),
            DeviceControl::MidiCC(note) => {
                let value = match note.resolution {
                    MidiResolution::Default => self
                        .read_cc_changes(note.channel, note.note, last_read_at)
                        .map(|(v, last_changed)| (v as u16, last_changed)),
                    MidiResolution::HighRes => {
                        let coarse = self.read_cc(note.channel, note.note);
                        let fine = self.read_cc(note.channel, note.note + HIGH_RES_CONTROL_OFFSET);
                        let value = coarse.zip(fine);

                        value
                            .map(|(coarse, fine)| {
                                let coarse_value = (coarse.value as u16) << 7;
                                let fine_value = fine.value as u16;
                                let value = coarse_value + fine_value;

                                let last_changed_at = if coarse.timestamp > fine.timestamp {
                                    MidiTimestamp(coarse.timestamp)
                                } else {
                                    MidiTimestamp(fine.timestamp)
                                };

                                (value, last_changed_at)
                            })
                            .and_then(|(value, last_changed)| {
                                if let Some(last_read_at) = last_read_at {
                                    if last_changed > last_read_at {
                                        Some((value, last_changed))
                                    } else {
                                        None
                                    }
                                } else {
                                    Some((value, last_changed))
                                }
                            })
                    }
                };
                value.map(|(value, last_changed)| {
                    (value.linear_extrapolate(note.range, (0., 1.)), last_changed)
                })
            }
            _ => None,
        }
    }

    fn read_changes(
        &self,
        control_type: &MidiControlType,
        last_read_at: Option<MidiTimestamp>,
    ) -> Option<(u8, MidiTimestamp)> {
        let guard = self.data.get(control_type)?;
        let value = guard.get_one().copied()?;
        let timestamp = MidiTimestamp(value.timestamp);
        let value = value.value;

        if let Some(last_read_at) = last_read_at {
            if timestamp > last_read_at {
                Some((value, timestamp))
            } else {
                None
            }
        } else {
            Some((value, timestamp))
        }
    }

    fn read_cc(&self, channel: Channel, note: u8) -> Option<MidiValue> {
        self.read(&MidiControlType::ControlChange(channel, note))
    }

    fn read(&self, control_type: &MidiControlType) -> Option<MidiValue> {
        let guard = self.data.get(control_type)?;
        let value = guard.get_one().copied();

        value.map(|value| *value)
    }
}

#[derive(Debug, Clone, Copy, Eq, PartialEq, Hash)]
enum MidiControlType {
    Note(Channel, u8),
    ControlChange(Channel, u8),
}
