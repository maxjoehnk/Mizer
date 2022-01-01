#![allow(dead_code)]
pub const NOTE_OFF: u8 = 8;
pub const NOTE_ON: u8 = 9;
pub const POLYPHONIC_PRESSURE: u8 = 10;
pub const CONTROL_CHANGE: u8 = 11;
pub const PROGRAM_CHANGE: u8 = 12;
pub const CHANNEL_PRESSURE: u8 = 13;
pub const PITCH_BEND: u8 = 14;

pub const SYSEX: u8 = 240;
pub const MTC_QUARTER_FRAME: u8 = 241;
pub const SONG_POSITION_POINTER: u8 = 242;
pub const SONG_SELECT: u8 = 243;
pub const TUNE_REQUEST: u8 = 246;
pub const SYSEX_EOX: u8 = 247;
pub const TIMING_CLOCK: u8 = 248;
pub const START: u8 = 250;
pub const CONTINUE: u8 = 251;
pub const STOP: u8 = 252;
pub const ACTIVE_SENSING: u8 = 254;
pub const SYSTEM_RESET: u8 = 255;

pub const CC_RPN_MSB: u8 = 101;
pub const CC_RPN_LSB: u8 = 100;
pub const CC_NRPN_MSB: u8 = 99;
pub const CC_NRPN_LSB: u8 = 98;
pub const CC_DATA_ENTRY_MSB: u8 = 6;
pub const CC_DATA_ENTRY_LSB: u8 = 38;
