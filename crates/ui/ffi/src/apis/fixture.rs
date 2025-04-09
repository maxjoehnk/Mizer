use crate::types::{drop_pointer, Array, FFIFromPointer};
use mizer_fixtures::{FixtureId, FixtureState, FixtureStates};
use std::sync::Arc;
use crate::apis::programmer::{FFIColorValue, FFIFixtureId};

pub struct FixturesRef(pub FixtureStates);

#[no_mangle]
pub extern "C" fn read_fixture_state(
    ptr: *const FixturesRef,
    fixture_id: u32,
    sub_fixture_id: u32,
) -> FFIFixtureState {
    let ffi = Arc::from_pointer(ptr);

    let state = ffi.0.read();
    let id = if sub_fixture_id != 0 {
        FixtureId::SubFixture(fixture_id, sub_fixture_id)
    } else {
        FixtureId::Fixture(fixture_id)
    };

    let state = state.get(&id);

    std::mem::forget(ffi);

    state.map(|state| (*state).into()).unwrap_or_default()
}

#[no_mangle]
pub extern "C" fn read_fixture_states(
    ptr: *const FixturesRef
) -> FFIFixtureStates {
    let ffi = Arc::from_pointer(ptr);

    let state = ffi.0.read();
    let fixture_values = state
        .iter()
        .map(|(id, state)| {
            let id = (*id).into();

            FFIFixtureValues {
                fixture_id: id,
                has_intensity: state.brightness.is_some().into(),
                intensity: state.brightness.unwrap_or_default(),
                has_color: state.color.is_some().into(),
                color: FFIColorValue::from(state.color.unwrap_or_default()),
                has_pan: state.pan.is_some().into(),
                pan: state.pan.unwrap_or_default(),
                has_tilt: state.tilt.is_some().into(),
                tilt: state.tilt.unwrap_or_default(),
            }
        })
        .collect();

    std::mem::forget(ffi);

    FFIFixtureStates {
        fixture_values,
    }
}

#[no_mangle]
pub extern "C" fn drop_fixture_pointer(ptr: *const FixturesRef) {
    drop_pointer(ptr);
}

#[derive(Default)]
#[repr(C)]
pub struct FFIFixtureState {
    pub has_brightness: u8,
    pub brightness: f64,
    pub has_color: u8,
    pub color_red: f64,
    pub color_green: f64,
    pub color_blue: f64,
}

impl From<FixtureState> for FFIFixtureState {
    fn from(state: FixtureState) -> Self {
        let (red, green, blue) = state.color.unwrap_or_default();

        Self {
            has_brightness: state.brightness.is_some().into(),
            brightness: state.brightness.unwrap_or_default(),
            has_color: state.color.is_some().into(),
            color_red: red,
            color_green: green,
            color_blue: blue,
        }
    }
}

#[repr(C)]
pub struct FFIFixtureStates {
    pub fixture_values: Array<FFIFixtureValues>,
}

#[repr(C)]
pub struct FFIFixtureValues {
    pub fixture_id: FFIFixtureId,
    pub has_intensity: u8,
    pub intensity: f64,
    pub has_color: u8,
    pub color: FFIColorValue,
    pub has_pan: u8,
    pub pan: f64,
    pub has_tilt: u8,
    pub tilt: f64,
}
