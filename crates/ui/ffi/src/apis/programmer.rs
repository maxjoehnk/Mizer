use crate::types::{drop_pointer, Array, FFIFromPointer};
use mizer_fixtures::programmer::{
    PresetId, ProgrammedEffect, ProgrammerChannel, ProgrammerControlValue, ProgrammerState,
    ProgrammerView,
};
use mizer_fixtures::FixtureId;
use parking_lot::Mutex;
use std::os::raw::c_char;
use std::sync::Arc;
use mizer_fixtures::channels::{FixtureChannel, FixtureColorChannel};
use crate::pointer_inventory::PointerInventory;

pub struct Programmer {
    view: ProgrammerView,
    ffi_state: Mutex<ProgrammerFFIState>,
}

#[derive(Default)]
struct ProgrammerFFIState {
    channels: PointerInventory,
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
    pub offline: u8,
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
            offline: u8::from(state.offline),
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
    pub preset: u8,
    pub control: *const c_char,
    pub fixtures: Array<FFIFixtureId>,
}

impl FFIProgrammerChannel {
    fn from(channel: ProgrammerChannel, ffi_state: &mut ProgrammerFFIState) -> Self {
        use ProgrammerControlValue::*;
        let preset = matches!(channel.value, Preset(_));
        let (control, value) = match channel.value {
            Control(channel) => {
                let fixture_channel = channel.channel;
                let value = ProgrammerChannelValue {
                    percent: channel.value.get_percent(),
                };

                (fixture_channel, value)
            }
            Preset(preset_id) if preset_id.is_intensity() => (
                FixtureChannel::Intensity,
                ProgrammerChannelValue {
                    preset: preset_id.into(),
                },
            ),
            Preset(preset_id) if preset_id.is_shutter() => (
                FixtureChannel::Shutter(1),
                ProgrammerChannelValue {
                    preset: preset_id.into(),
                },
            ),
            Preset(preset_id) if preset_id.is_color() => (
                FixtureChannel::ColorMixer(FixtureColorChannel::Red),
                ProgrammerChannelValue {
                    preset: preset_id.into(),
                },
            ),
            Preset(preset_id) if preset_id.is_position() => (
                FixtureChannel::Pan,
                ProgrammerChannelValue {
                    preset: preset_id.into(),
                },
            ),
            Preset(_) => unreachable!(),
        };
        
        let control = ffi_state.channels.allocate_string(control.to_string());

        Self {
            value,
            control,
            preset: preset.into(),
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
    pub percent: f64,
    pub preset: FFIPresetId,
}

#[repr(C)]
#[derive(Clone, Copy)]
pub union FFIPresetId {
    pub intensity: u32,
    pub shutter: u32,
    pub color: u32,
    pub position: u32,
}

impl From<PresetId> for FFIPresetId {
    fn from(id: PresetId) -> Self {
        match id {
            PresetId::Intensity(id) => FFIPresetId { intensity: id },
            PresetId::Shutter(id) => FFIPresetId { shutter: id },
            PresetId::Color(id) => FFIPresetId { color: id },
            PresetId::Position(id) => FFIPresetId { position: id },
        }
    }
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
