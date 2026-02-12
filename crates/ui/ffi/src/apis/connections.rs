use std::ffi::CStr;
use std::os::raw::c_char;
use std::sync::Arc;

use bitflags::bitflags;

use mizer_api::proto::connections::PioneerCdjConnection;
use mizer_api::Message;
use mizer_devices::DeviceManager;
use mizer_gamepads::{Axis, Button, GamepadRef, GamepadState};
use mizer_connections::ConnectionStorageView;

use crate::types::{Array, FFIFromPointer};

pub struct GamepadConnectionRef(pub GamepadRef);
pub struct ConnectionsRef(pub DeviceManager);
pub struct ConnectionViewRef(pub ConnectionStorageView);

#[no_mangle]
pub extern "C" fn read_gamepad_state(ptr: *const GamepadConnectionRef) -> FFIGamepadState {
    let ffi = Arc::from_pointer(ptr);
    let state = ffi.0.state();

    std::mem::forget(ffi);

    FFIGamepadState {
        left_stick_x: state.axis_value(Axis::LeftStickX).unwrap_or_default(),
        left_stick_y: state.axis_value(Axis::LeftStickY).unwrap_or_default(),
        right_stick_x: state.axis_value(Axis::RightStickX).unwrap_or_default(),
        right_stick_y: state.axis_value(Axis::RightStickY).unwrap_or_default(),
        left_trigger: state.axis_value(Axis::LeftTrigger).unwrap_or_default(),
        right_trigger: state.axis_value(Axis::RightTrigger).unwrap_or_default(),
        left_shoulder: button(&state, Button::LeftShoulder),
        right_shoulder: button(&state, Button::RightShoulder),
        south: button(&state, Button::South),
        north: button(&state, Button::North),
        east: button(&state, Button::East),
        west: button(&state, Button::West),
        select: button(&state, Button::Select),
        start: button(&state, Button::Start),
        mode: button(&state, Button::Mode),
        left_stick: button(&state, Button::LeftStick),
        right_stick: button(&state, Button::RightStick),
        dpad: dpad(&state),
    }
}

#[no_mangle]
pub extern "C" fn read_cdj_state(ptr: *const ConnectionsRef, id: *const c_char) -> Array<u8> {
    Vec::default().into()

    // let id = unsafe { CStr::from_ptr(id) };
    // let id = id.to_str().unwrap();
    // let ffi = Arc::from_pointer(ptr);
    // let cdj = ffi.0.get_cdj(id);
    // let state = cdj.map(|cdj_ref| PioneerCdjConnection::from(cdj_ref.clone()));
    //
    // std::mem::forget(ffi);
    //
    // if let Some(state) = state {
    //     state.encode_to_vec().into()
    // } else {
    //     Vec::default().into()
    // }
}

#[no_mangle]
pub extern "C" fn read_transmission_state(ptr: *const ConnectionViewRef, id: *const c_char) -> FFITransmissionState {
    let id = unsafe { CStr::from_ptr(id) };
    let id = id.to_str().unwrap();
    let ffi = Arc::from_pointer(ptr);
    let is_sending = ffi.0.is_sending(id);
    let is_receiving = ffi.0.is_receiving(id);
    let state = is_sending.zip(is_receiving);

    std::mem::forget(ffi);

    if let Some((sending, receiving)) = state {
        FFITransmissionState {
            has_state: 1,
            sending: sending.into(),
            receiving: receiving.into(),
        }
    }else {
        FFITransmissionState::default()
    }
}

#[derive(Clone, Copy, Debug, Default)]
#[repr(C)]
pub struct FFITransmissionState {
    pub has_state: u8,
    pub sending: u8,
    pub receiving: u8,
}

fn button(state: &GamepadState, button: Button) -> u8 {
    state.is_button_pressed(button).unwrap_or_default().into()
}

fn dpad(state: &GamepadState) -> FFIDpadState {
    let left = dpad_button(state, Button::DPadLeft);
    let right = dpad_button(state, Button::DPadRight);
    let up = dpad_button(state, Button::DPadUp);
    let down = dpad_button(state, Button::DPadDown);

    let mut state = FFIDpadState::default();
    state.set(FFIDpadState::LEFT, left);
    state.set(FFIDpadState::RIGHT, right);
    state.set(FFIDpadState::UP, up);
    state.set(FFIDpadState::DOWN, down);

    state
}

fn dpad_button(state: &GamepadState, button: Button) -> bool {
    state.is_button_pressed(button).unwrap_or_default()
}

#[derive(Clone, Copy, Debug, Default)]
#[repr(C)]
pub struct FFIGamepadState {
    pub dpad: FFIDpadState,
    pub left_stick_x: f64,
    pub left_stick_y: f64,
    pub left_stick: u8,
    pub right_stick_x: f64,
    pub right_stick_y: f64,
    pub right_stick: u8,
    pub left_trigger: f64,
    pub left_shoulder: u8,
    pub right_trigger: f64,
    pub right_shoulder: u8,
    pub north: u8,
    pub east: u8,
    pub south: u8,
    pub west: u8,
    pub select: u8,
    pub start: u8,
    pub mode: u8,
}

bitflags! {
    #[derive(Debug, Default, Clone, Copy, PartialEq, Eq)]
    #[repr(C)]
    pub struct FFIDpadState: u8 {
        const UP = 0b0001;
        const RIGHT = 0b0010;
        const DOWN = 0b0100;
        const LEFT = 0b1000;
    }
}
