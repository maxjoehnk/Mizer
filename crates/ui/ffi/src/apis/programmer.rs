use crate::types::{drop_pointer, Array, FFIFromPointer};
use mizer_fixtures::definition::FixtureControlValue;
use mizer_fixtures::programmer::{
    ProgrammedEffect, ProgrammerChannel, ProgrammerState, ProgrammerView,
};
use mizer_fixtures::FixtureId;
use parking_lot::Mutex;
use std::collections::HashMap;
use std::ffi::CString;
use std::os::raw::c_char;
use std::sync::Arc;

pub struct Programmer {
    view: ProgrammerView,
    ffi_state: Mutex<ProgrammerFFIState>,
}

#[derive(Default)]
struct ProgrammerFFIState {
    generic_channels: HashMap<*const c_char, CString>,
}

impl Programmer {
    pub fn new(view: ProgrammerView) -> Self {
        Self {
            view,
            ffi_state: Mutex::new(Default::default()),
        }
    }
}

#[no_mangle]
pub extern "C" fn read_programmer_state(ptr: *const Programmer) -> FFIProgrammerState {
    let ffi = Arc::from_pointer(ptr);

    let state = ffi.view.read();

    let state = {
        let mut ffi_state = ffi.ffi_state.lock();

        FFIProgrammerState::from(state, &mut ffi_state)
    };

    std::mem::forget(ffi);

    state
}

#[no_mangle]
pub extern "C" fn drop_programmer_pointer(ptr: *const Programmer) {
    drop_pointer(ptr);
}

// TODO: currently this is not used, investigate if we're currently leaking memory here
#[no_mangle]
pub extern "C" fn drop_generic_channel(ptr: *const Programmer, channel: FFIGenericValue) {
    let ffi = Arc::from_pointer(ptr);
    {
        let mut ffi_state = ffi.ffi_state.lock();
        ffi_state.generic_channels.remove(&channel.channel);
    }
    std::mem::forget(ffi);
}

#[repr(C)]
pub struct FFIProgrammerState {
    pub active_fixtures: Array<FFIFixtureId>,
    pub active_groups: Array<u32>,
    pub fixtures: Array<FFIFixtureId>,
    pub selection: Array<Array<FFIFixtureId>>,
    pub channels: Array<FFIProgrammerChannel>,
    pub effects: Array<FFIEffectProgrammerState>,
    pub highlight: u8,
    pub block_size: u32,
    pub groups: u32,
    pub wings: u32,
}

impl FFIProgrammerState {
    fn from(state: ProgrammerState, ffi_state: &mut ProgrammerFFIState) -> Self {
        Self {
            active_fixtures: state
                .active_fixtures
                .into_iter()
                .map(FFIFixtureId::from)
                .collect::<Vec<_>>()
                .into(),
            active_groups: state
                .active_groups
                .into_iter()
                .map(u32::from)
                .collect::<Vec<_>>()
                .into(),
            fixtures: state
                .tracked_fixtures
                .into_iter()
                .map(FFIFixtureId::from)
                .collect::<Vec<_>>()
                .into(),
            selection: state
                .selection
                .into_iter()
                .map(|group| {
                    group
                        .into_iter()
                        .map(FFIFixtureId::from)
                        .collect::<Vec<_>>()
                        .into()
                })
                .collect::<Vec<_>>()
                .into(),
            channels: state
                .channels
                .into_iter()
                .map(|chan| FFIProgrammerChannel::from(chan, ffi_state))
                .collect::<Vec<_>>()
                .into(),
            highlight: u8::from(state.highlight),
            block_size: state.selection_block_size.unwrap_or_default() as u32,
            groups: state.selection_groups.unwrap_or_default() as u32,
            wings: state.selection_wings.unwrap_or_default() as u32,
            effects: state
                .effects
                .into_iter()
                .map(FFIEffectProgrammerState::from)
                .collect(),
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

impl FFIProgrammerChannel {
    fn from(channel: ProgrammerChannel, ffi_state: &mut ProgrammerFFIState) -> Self {
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
            Generic(channel, value) => {
                let channel = CString::new(channel).unwrap();
                let channel_pointer = channel.as_ptr();
                ffi_state.generic_channels.insert(channel_pointer, channel);
                (
                    FFIFixtureFaderControl::Generic,
                    ProgrammerChannelValue {
                        generic: FFIGenericValue {
                            channel: channel_pointer,
                            value,
                        },
                    },
                )
            }
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

#[repr(C)]
pub union ProgrammerChannelValue {
    pub fader: f64,
    pub color: FFIColorValue,
    pub generic: FFIGenericValue,
}

#[derive(Clone, Copy)]
#[repr(C)]
pub struct FFIColorValue {
    pub red: f64,
    pub green: f64,
    pub blue: f64,
}

#[repr(C)]
#[derive(Clone, Copy)]
pub struct FFIGenericValue {
    pub channel: *const c_char,
    pub value: f64,
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
    Generic = 12,
}

#[repr(C)]
pub struct FFIEffectProgrammerState {
    pub effect_id: u32,
    pub rate: f64,
    pub has_offset: u8,
    pub effect_offset: f64,
}

impl From<ProgrammedEffect> for FFIEffectProgrammerState {
    fn from(effect: ProgrammedEffect) -> Self {
        Self {
            effect_id: effect.effect_id,
            rate: effect.rate,
            has_offset: effect.offset.is_some().into(),
            effect_offset: effect.offset.unwrap_or_default(),
        }
    }
}
