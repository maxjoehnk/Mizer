use crate::consts::*;
use serde::{Deserialize, Serialize};
use std::convert::TryFrom;

/// Represents a Midi channel
///
/// Note that `Ch1 = 0`, `Ch2 = 1`, etc, as the actual protocol is 0-indexed.
#[derive(Debug, Copy, Clone, Eq, PartialEq, Ord, PartialOrd, Hash, Deserialize, Serialize)]
pub enum Channel {
    Ch1 = 0,
    Ch2 = 1,
    Ch3 = 2,
    Ch4 = 3,
    Ch5 = 4,
    Ch6 = 5,
    Ch7 = 6,
    Ch8 = 7,
    Ch9 = 8,
    Ch10 = 9,
    Ch11 = 10,
    Ch12 = 11,
    Ch13 = 12,
    Ch14 = 13,
    Ch15 = 14,
    Ch16 = 15,
}

impl Default for Channel {
    fn default() -> Self {
        Self::Ch1
    }
}

impl PartialEq<u8> for Channel {
    fn eq(&self, other: &u8) -> bool {
        match self {
            Channel::Ch1 => *other == 1,
            Channel::Ch2 => *other == 2,
            Channel::Ch3 => *other == 3,
            Channel::Ch4 => *other == 4,
            Channel::Ch5 => *other == 5,
            Channel::Ch6 => *other == 6,
            Channel::Ch7 => *other == 7,
            Channel::Ch8 => *other == 8,
            Channel::Ch9 => *other == 9,
            Channel::Ch10 => *other == 10,
            Channel::Ch11 => *other == 11,
            Channel::Ch12 => *other == 12,
            Channel::Ch13 => *other == 13,
            Channel::Ch14 => *other == 14,
            Channel::Ch15 => *other == 15,
            Channel::Ch16 => *other == 16,
        }
    }
}

impl Channel {
    fn try_parse(data: u8) -> Result<Self, ()> {
        match data & 0b00001111 {
            0 => Ok(Channel::Ch1),
            1 => Ok(Channel::Ch2),
            2 => Ok(Channel::Ch3),
            3 => Ok(Channel::Ch4),
            4 => Ok(Channel::Ch5),
            5 => Ok(Channel::Ch6),
            6 => Ok(Channel::Ch7),
            7 => Ok(Channel::Ch8),
            8 => Ok(Channel::Ch9),
            9 => Ok(Channel::Ch10),
            10 => Ok(Channel::Ch11),
            11 => Ok(Channel::Ch12),
            12 => Ok(Channel::Ch13),
            13 => Ok(Channel::Ch14),
            14 => Ok(Channel::Ch15),
            15 => Ok(Channel::Ch16),
            _ => Err(()),
        }
    }
}

impl TryFrom<u8> for Channel {
    type Error = ();

    fn try_from(channel: u8) -> Result<Self, Self::Error> {
        match channel {
            1 => Ok(Channel::Ch1),
            2 => Ok(Channel::Ch2),
            3 => Ok(Channel::Ch3),
            4 => Ok(Channel::Ch4),
            5 => Ok(Channel::Ch5),
            6 => Ok(Channel::Ch6),
            7 => Ok(Channel::Ch7),
            8 => Ok(Channel::Ch8),
            9 => Ok(Channel::Ch9),
            10 => Ok(Channel::Ch10),
            11 => Ok(Channel::Ch11),
            12 => Ok(Channel::Ch12),
            13 => Ok(Channel::Ch13),
            14 => Ok(Channel::Ch14),
            15 => Ok(Channel::Ch15),
            16 => Ok(Channel::Ch16),
            _ => Err(()),
        }
    }
}

#[derive(Debug, Clone, Eq, PartialEq)]
pub enum MidiMessage {
    ControlChange(Channel, u8, u8),
    NoteOff(Channel, u8, u8),
    NoteOn(Channel, u8, u8),
    Sysex((u8, u8, u8), u8, Vec<u8>),
    Timecode(MtcTimecode, FrameRate),
    /// Piece #	Data byte	Significance
    // 0	0000 ffff	Frame number lsbits
    // 1	0001 000f	Frame number msbit
    // 2	0010 ssss	Second lsbits
    // 3	0011 00ss	Second msbits
    // 4	0100 mmmm	Minute lsbits
    // 5	0101 00mm	Minute msbits
    // 6	0110 hhhh	Hour lsbits
    // 7	0111 0rrh	Rate and hour msbit
    TimecodeQuarterFrame(u8, u8),
    Unknown(Vec<u8>),
}

#[derive(Debug, Default, Clone, Copy, Eq, PartialEq)]
pub struct MtcTimecode {
    /// The position in frames, 0-29
    pub frames: u8,
    /// The position in seconds, 0-59
    pub seconds: u8,
    /// The position in minutes, 0-59
    pub minutes: u8,
    /// The position in hours, 0-23
    pub hours: u8,
}

impl MtcTimecode {
    pub fn to_bytes(&self, frame_rate: FrameRate) -> [u8; 4] {
        [
            (self.hours & 0b0001_1111) | ((frame_rate as u8) << 5),
            self.minutes & 0b0011_1111,
            self.seconds & 0b0011_1111,
            self.frames & 0b0001_1111,
        ]
    }
}

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
#[repr(u8)]
pub enum FrameRate {
    /// 24 frame/s
    FPS24 = 0,
    /// 25 frame/s
    FPS25 = 1,
    /// 29.97 frame/s
    DF30 = 2,
    /// 30 frame/s
    NDF30 = 3,
}

impl TryFrom<u8> for FrameRate {
    type Error = ();

    fn try_from(value: u8) -> Result<Self, Self::Error> {
        if value > 3 {
            return Err(());
        }

        Ok(unsafe { std::mem::transmute(value) })
    }
}

impl From<FrameRate> for u8 {
    fn from(value: FrameRate) -> Self {
        value as u8
    }
}

impl TryFrom<&[u8]> for MidiMessage {
    type Error = ();

    fn try_from(data: &[u8]) -> Result<Self, Self::Error> {
        match data {
            [status, note, value] if matches_status(status, NOTE_OFF) => {
                let channel = Channel::try_parse(*status).unwrap();
                Ok(MidiMessage::NoteOff(channel, *note, *value))
            }
            [status, note, value] if matches_status(status, NOTE_ON) => {
                let channel = Channel::try_parse(*status).unwrap();
                Ok(MidiMessage::NoteOn(channel, *note, *value))
            }
            [status, d1, d2] if matches_status(status, CONTROL_CHANGE) => {
                let channel = Channel::try_parse(*status).unwrap();
                Ok(MidiMessage::ControlChange(channel, *d1, *d2))
            }
            [MTC_QUARTER_FRAME, data] => {
                let frame = (0b1111_0000 & data) >> 4;
                let data = (0b0000_1111 & data);

                Ok(MidiMessage::TimecodeQuarterFrame(frame, data))
            }
            [SYSEX, 0x7F, 0x7F, 0x01, 0x01, hour, minute, second, frame, SYSEX_EOX] |
            // TODO: do any devices send timecode like this? this doesn't seem in spec
            [hour, minute, second, frame] => {
                let frame_rate = (hour & 0b0110_0000) >> 5;
                Ok(MidiMessage::Timecode(MtcTimecode {
                    hours: hour & 0b00011111,
                    minutes: minute & 0b00111111,
                    seconds: second & 0b00111111,
                    frames: frame & 0b00011111,
                }, FrameRate::try_from(frame_rate)?))
            },
            [SYSEX, manu1, manu2, manu3, model, data @ .., SYSEX_EOX] => Ok(MidiMessage::Sysex(
                (*manu1, *manu2, *manu3),
                *model,
                data.to_vec(),
            )),
            _ => {
                tracing::warn!("unimplemented: {:?}", data);
                Ok(MidiMessage::Unknown(data.to_vec()))
            }
        }
    }
}

impl From<MidiMessage> for Vec<u8> {
    fn from(msg: MidiMessage) -> Self {
        match msg {
            MidiMessage::NoteOn(channel, note, value) => {
                vec![status_byte(NOTE_ON, channel), note, value]
            }
            MidiMessage::NoteOff(channel, note, value) => {
                vec![status_byte(NOTE_OFF, channel), note, value]
            }
            MidiMessage::ControlChange(channel, note, value) => {
                vec![status_byte(CONTROL_CHANGE, channel), note, value]
            }
            MidiMessage::Sysex(manufacturer, model, mut data) => {
                let mut bytes = vec![SYSEX, manufacturer.0, manufacturer.1, manufacturer.2, model];
                bytes.append(&mut data);
                bytes.push(SYSEX_EOX);
                bytes
            }
            MidiMessage::Unknown(data) => data,
            MidiMessage::Timecode(timecode, frame_rate) => vec![
                SYSEX,
                0x7F,
                0x7F,
                0x01,
                0x01,
                (timecode.hours & 0b0001_1111) | ((frame_rate as u8) << 5),
                timecode.minutes & 0b0011_1111,
                timecode.seconds & 0b0011_1111,
                timecode.frames & 0b0001_1111,
                SYSEX_EOX,
            ],
            MidiMessage::TimecodeQuarterFrame(frame, data) => vec![MTC_QUARTER_FRAME, frame << 4 | data],
        }
    }
}

#[inline(always)]
fn matches_status(input: &u8, status: u8) -> bool {
    input & 0b11110000 == status << 4u8
}

/// Calculate the status byte for a given channel no.
#[inline(always)]
fn status_byte(status: u8, channel: Channel) -> u8 {
    (status & 0b00001111) * 16 + (channel as u8)
}

#[cfg(test)]
mod test {
    use std::convert::TryFrom;
    use super::*;
    use test_case::test_case;

    #[test]
    fn deserialize_note_off_ch1_0_0() {
        let data: &[u8] = &[128, 0, 0];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::NoteOff(Channel::Ch1, 0, 0));
    }

    #[test]
    fn serialize_note_off_ch1_0_0() {
        let msg = MidiMessage::NoteOff(Channel::Ch1, 0, 0);
        let expected = vec![128, 0, 0];

        let result: Vec<u8> = msg.into();

        assert_eq!(result, expected);
    }

    #[test]
    fn deserialize_note_off_ch2_127_127() {
        let data: &[u8] = &[129, 127, 127];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::NoteOff(Channel::Ch2, 127, 127));
    }

    #[test]
    fn serialize_note_off_ch2_127_127() {
        let expected = vec![129, 127, 127];
        let msg = MidiMessage::NoteOff(Channel::Ch2, 127, 127);

        let result: Vec<u8> = msg.into();

        assert_eq!(result, expected);
    }

    #[test]
    fn deserialize_note_off_ch3_0_0() {
        let data: &[u8] = &[130, 0, 0];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::NoteOff(Channel::Ch3, 0, 0));
    }

    #[test]
    fn deserialize_note_on_ch1_0_0() {
        let data: &[u8] = &[144, 0, 0];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::NoteOn(Channel::Ch1, 0, 0));
    }

    #[test]
    fn deserialize_note_on_ch2_127_127() {
        let data: &[u8] = &[145, 127, 127];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::NoteOn(Channel::Ch2, 127, 127));
    }

    #[test]
    fn deserialize_note_on_ch3_0_0() {
        let data: &[u8] = &[146, 0, 0];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::NoteOn(Channel::Ch3, 0, 0));
    }

    #[test]
    fn deserialize_cc_ch1_0_0() {
        let data: &[u8] = &[176, 0, 0];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::ControlChange(Channel::Ch1, 0, 0));
    }

    #[test]
    fn deserialize_cc_ch1_0_127() {
        let data: &[u8] = &[176, 0, 127];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::ControlChange(Channel::Ch1, 0, 127));
    }

    #[test]
    fn deserialize_cc_ch2_127_0() {
        let data: &[u8] = &[177, 127, 0];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::ControlChange(Channel::Ch2, 127, 0));
    }

    #[test]
    fn deserialize_sysex() {
        let data: &[u8] = &[240, 0, 32, 41, 2, 10, 119, 2, 247];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::Sysex((0, 32, 41), 2, vec![10, 119, 2]));
    }

    #[test]
    fn serialize_sysex() {
        let expected: [u8; 9] = [240, 0, 32, 41, 2, 10, 119, 2, 247];
        let msg = MidiMessage::Sysex((0, 32, 41), 2, vec![10, 119, 2]);

        let data: Vec<u8> = msg.into();

        assert_eq!(data, expected);
    }

    #[test_case([0x64, 0x01, 0x02, 0x03], 4, 1, 2, 3, FrameRate::NDF30)]
    #[test_case([0x46, 0x04, 0x08, 0x10], 6, 4, 8, 16, FrameRate::DF30)]
    #[test_case([0x3F, 0xFF, 0xFF, 0xFF], 31, 63, 63, 31, FrameRate::FPS25)]
    fn deserialize_timecode(data: [u8; 4], hours: u8, minutes: u8, seconds: u8, frames: u8, frame_rate: FrameRate) {
        let msg = MidiMessage::try_from(data.as_slice()).unwrap();

        assert_eq!(msg, MidiMessage::Timecode(MtcTimecode {
            hours,
            minutes,
            seconds,
            frames,
        }, frame_rate));
    }

    #[test_case([0x64, 0x01, 0x02, 0x03], 4, 1, 2, 3, FrameRate::NDF30)]
    #[test_case([0x46, 0x04, 0x08, 0x10], 6, 4, 8, 16, FrameRate::DF30)]
    #[test_case([0x1F, 0x3F, 0x3F, 0x1F], 255, 255, 255, 255, FrameRate::FPS24)]
    fn serialize_timecode(expected: [u8; 4], hours: u8, minutes: u8, seconds: u8, frames: u8, frame_rate: FrameRate) {
        let msg = MidiMessage::Timecode(MtcTimecode { hours, minutes, seconds, frames }, frame_rate);

        let data: Vec<u8> = msg.into();

        assert_eq!(data[5..9], expected);
        assert_eq!(data[0..5], [0xF0, 0x7F, 0x7F, 0x01, 0x01]);
        assert_eq!(data[9], 0xF7);
    }

    #[test_case([0x64, 0x01, 0x02, 0x03], 4, 1, 2, 3, FrameRate::NDF30)]
    #[test_case([0x46, 0x04, 0x08, 0x10], 6, 4, 8, 16, FrameRate::DF30)]
    #[test_case([0x3F, 0xFF, 0xFF, 0xFF], 31, 63, 63, 31, FrameRate::FPS25)]
    fn deserialize_full_timecode(timecode_data: [u8; 4], hours: u8, minutes: u8, seconds: u8, frames: u8, frame_rate: FrameRate) {
       let mut data = vec![0xF0, 0x7F, 0x7F, 0x01, 0x01];
        data.extend_from_slice(&timecode_data);
        data.push(0xF7);

       let msg = MidiMessage::try_from(data.as_slice()).unwrap();

       assert_eq!(msg, MidiMessage::Timecode(MtcTimecode {
           hours,
           minutes,
           seconds,
           frames,
       }, frame_rate));
    }

    #[test_case(0b0000_0010, 0, 0b0010)]
    #[test_case(0b0001_0001, 1, 0b0001)]
    fn deserialize_timecode_quarter_frames(frame_data: u8, frame: u8, value: u8) {
        let data: &[u8] = &[0xF1, frame_data];

        let msg = MidiMessage::try_from(data).unwrap();

        assert_eq!(msg, MidiMessage::TimecodeQuarterFrame(frame, value));
    }
}
