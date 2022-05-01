use crate::types::{drop_pointer, Array, FFIFromPointer};
use mizer_fixtures::definition::FixtureControlValue;
use mizer_fixtures::programmer::{ProgrammerChannel, ProgrammerState, ProgrammerView};
use mizer_fixtures::FixtureId;
use std::sync::Arc;

pub struct Programmer {
    pub view: ProgrammerView,
}

#[no_mangle]
pub extern "C" fn read_programmer_state(ptr: *const Programmer) -> FFIProgrammerState {
    let ffi = Arc::from_pointer(ptr);

    let state = ffi.view.read();

    std::mem::forget(ffi);

    state.into()
}

#[no_mangle]
pub extern "C" fn drop_programmer_pointer(ptr: *const Programmer) {
    drop_pointer(ptr);
}

#[repr(C)]
pub struct FFIProgrammerState {
    pub active_fixtures: Array<FFIFixtureId>,
    pub fixtures: Array<FFIFixtureId>,
    pub channels: Array<FFIProgrammerChannel>,
    pub highlight: u8,
}

impl From<ProgrammerState> for FFIProgrammerState {
    fn from(state: ProgrammerState) -> Self {
        Self {
            active_fixtures: state
                .active_fixtures
                .into_iter()
                .map(FFIFixtureId::from)
                .collect::<Vec<_>>()
                .into(),
            fixtures: state
                .tracked_fixtures
                .into_iter()
                .map(FFIFixtureId::from)
                .collect::<Vec<_>>()
                .into(),
            channels: state
                .channels
                .into_iter()
                .map(FFIProgrammerChannel::from)
                .collect::<Vec<_>>()
                .into(),
            highlight: if state.highlight { 1 } else { 0 },
        }
    }
}

#[repr(C)]
pub struct FFIFixtureId {
    pub fixture_id: u32,
    pub sub_fixture_id: u32,
}

impl From<FixtureId> for FFIFixtureId {
    fn from(id: FixtureId) -> Self {
        match id {
            FixtureId::Fixture(id) => FFIFixtureId {
                fixture_id: id,
                sub_fixture_id: 0,
            },
            FixtureId::SubFixture(fixture, sub_fixture) => FFIFixtureId {
                fixture_id: fixture,
                sub_fixture_id: sub_fixture,
            },
        }
    }
}

#[repr(C)]
pub struct FFIProgrammerChannel {
    pub value: ProgrammerChannelValue,
    pub control: FFIFixtureFaderControl,
    pub fixtures: Array<FFIFixtureId>,
}

#[repr(C)]
pub union ProgrammerChannelValue {
    pub fader: f64,
    pub color: FFIColorValue,
}

#[derive(Clone, Copy)]
#[repr(C)]
pub struct FFIColorValue {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
}

#[repr(C)]
pub enum FFIFixtureFaderControl {
    Intensity = 0,
    Shutter = 1,
    ColorMixer = 2,
    ColorWheel = 3,
    Pan = 4,
    Tilt = 5,
    Focus = 6,
    Zoom = 7,
    Prism = 8,
    Iris = 9,
    Frost = 10,
    Gobo = 11,
}

impl From<ProgrammerChannel> for FFIProgrammerChannel {
    fn from(channel: ProgrammerChannel) -> Self {
        use FixtureControlValue::*;
        let (control, value) = match channel.value {
            Intensity(value) => (
                FFIFixtureFaderControl::Intensity,
                ProgrammerChannelValue { fader: value },
            ),
            Shutter(value) => (
                FFIFixtureFaderControl::Shutter,
                ProgrammerChannelValue { fader: value },
            ),
            Pan(value) => (
                FFIFixtureFaderControl::Pan,
                ProgrammerChannelValue { fader: value },
            ),
            Tilt(value) => (
                FFIFixtureFaderControl::Tilt,
                ProgrammerChannelValue { fader: value },
            ),
            Focus(value) => (
                FFIFixtureFaderControl::Focus,
                ProgrammerChannelValue { fader: value },
            ),
            Zoom(value) => (
                FFIFixtureFaderControl::Zoom,
                ProgrammerChannelValue { fader: value },
            ),
            Prism(value) => (
                FFIFixtureFaderControl::Prism,
                ProgrammerChannelValue { fader: value },
            ),
            Iris(value) => (
                FFIFixtureFaderControl::Iris,
                ProgrammerChannelValue { fader: value },
            ),
            Frost(value) => (
                FFIFixtureFaderControl::Frost,
                ProgrammerChannelValue { fader: value },
            ),
            Gobo(value) => (
                FFIFixtureFaderControl::Gobo,
                ProgrammerChannelValue { fader: value },
            ),
            ColorMixer(red, green, blue) => (
                FFIFixtureFaderControl::ColorMixer,
                ProgrammerChannelValue {
                    color: FFIColorValue { red, green, blue },
                },
            ),
            ColorWheel(value) => (
                FFIFixtureFaderControl::ColorWheel,
                ProgrammerChannelValue { fader: value },
            ),
            Generic(_, _) => todo!(),
        };

        Self {
            value,
            control,
            fixtures: channel
                .fixtures
                .into_iter()
                .map(FFIFixtureId::from)
                .collect(),
        }
    }
}
