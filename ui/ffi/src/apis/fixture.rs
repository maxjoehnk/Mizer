use std::sync::Arc;
use mizer_fixtures::{FixtureId, FixtureState, FixtureStates};
use crate::types::{drop_pointer, FFIFromPointer};

pub struct FixturesRef(pub FixtureStates);

#[no_mangle]
pub extern fn read_fixture_state(ptr: *const FixturesRef, fixture_id: u32, sub_fixture_id: u32) -> FFIFixtureState {
    let ffi = Arc::from_pointer(ptr);

    let state = ffi.0.read();
    let id = if sub_fixture_id != 0 {
        FixtureId::SubFixture(fixture_id, sub_fixture_id)
    }else {
        FixtureId::Fixture(fixture_id)
    };

    let state = state.get(&id);

    std::mem::forget(ffi);

    state.map(|state| (*state).into()).unwrap_or_default()
}

#[no_mangle]
pub extern fn drop_fixture_pointer(ptr: *const FixturesRef) {
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
            has_brightness: if state.brightness.is_some() { 1 } else { 0 },
            brightness: state.brightness.unwrap_or_default(),
            has_color: if state.color.is_some() { 1 } else { 0 },
            color_red: red,
            color_green: green,
            color_blue: blue
        }
    }
}
