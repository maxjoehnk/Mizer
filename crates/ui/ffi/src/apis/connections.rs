use crate::types::FFIFromPointer;
use bitflags::bitflags;
use mizer_gamepads::{Axis, Button, GamepadRef, GamepadState};
use std::sync::Arc;

pub struct GamepadConnectionRef(pub GamepadRef);

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
