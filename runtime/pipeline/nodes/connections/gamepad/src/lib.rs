use serde::{Deserialize, Serialize};

use mizer_devices::DeviceManager;
use mizer_gamepads::{Axis, Button};
pub use mizer_node::*;
use mizer_util::LerpExt;

const LEFT_STICK_X: &str = "Left Stick X";
const LEFT_STICK_Y: &str = "Left Stick Y";
const RIGHT_STICK_X: &str = "Right Stick X";
const RIGHT_STICK_Y: &str = "Right Stick Y";
const LEFT_TRIGGER: &str = "Left Trigger";
const RIGHT_TRIGGER: &str = "Right Trigger";
const LEFT_SHOULDER: &str = "Left Button";
const RIGHT_SHOULDER: &str = "Right Button";
const SOUTH: &str = "South";
const EAST: &str = "East";
const NORTH: &str = "North";
const WEST: &str = "West";
const SELECT: &str = "Select";
const START: &str = "Start";
const DPAD_UP: &str = "DPad Up";
const DPAD_RIGHT: &str = "DPad Right";
const DPAD_DOWN: &str = "DPad Down";
const DPAD_LEFT: &str = "DPad Left";
const LEFT_STICK: &str = "Left Stick Button";
const RIGHT_STICK: &str = "Right Stick Button";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct GamepadNode {
    #[serde(rename = "device")]
    pub device_id: String,
}

impl PipelineNode for GamepadNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "GamepadNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                LEFT_STICK_X.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                LEFT_STICK_Y.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                LEFT_STICK.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                RIGHT_STICK_X.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                RIGHT_STICK_Y.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                RIGHT_STICK.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                LEFT_TRIGGER.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                RIGHT_TRIGGER.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                LEFT_SHOULDER.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                RIGHT_SHOULDER.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                SOUTH.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                EAST.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                NORTH.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                WEST.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                SELECT.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                START.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                DPAD_UP.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                DPAD_RIGHT.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                DPAD_DOWN.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                DPAD_LEFT.into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Gamepad
    }
}

impl ProcessingNode for GamepadNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(device_manager) = context.inject::<DeviceManager>() {
            if let Some(gamepad) = device_manager.get_gamepad(&self.device_id) {
                let state = gamepad.state();
                if let Some(value) = state.axis_value(Axis::LeftStickX) {
                    let target: f64 = value.linear_extrapolate((-1., 1.), (0., 1.));
                    context.write_port(LEFT_STICK_X, target);
                }
                if let Some(value) = state.axis_value(Axis::LeftStickY) {
                    let target: f64 = value.linear_extrapolate((-1., 1.), (0., 1.));
                    context.write_port(LEFT_STICK_Y, target);
                }
                if let Some(value) = state.axis_value(Axis::RightStickX) {
                    let target: f64 = value.linear_extrapolate((-1., 1.), (0., 1.));
                    context.write_port(RIGHT_STICK_X, target);
                }
                if let Some(value) = state.axis_value(Axis::RightStickY) {
                    let target: f64 = value.linear_extrapolate((-1., 1.), (0., 1.));
                    context.write_port(RIGHT_STICK_Y, target);
                }
                if let Some(value) = state.axis_value(Axis::LeftTrigger) {
                    context.write_port(LEFT_TRIGGER, value);
                }
                if let Some(value) = state.axis_value(Axis::RightTrigger) {
                    context.write_port(RIGHT_TRIGGER, value);
                }
                if let Some(value) = state.is_button_pressed(Button::LeftShoulder) {
                    context.write_port(LEFT_SHOULDER, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::RightShoulder) {
                    context.write_port(RIGHT_SHOULDER, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::South) {
                    context.write_port(SOUTH, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::East) {
                    context.write_port(EAST, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::North) {
                    context.write_port(NORTH, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::West) {
                    context.write_port(WEST, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::Select) {
                    context.write_port(SELECT, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::Start) {
                    context.write_port(START, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::DPadUp) {
                    context.write_port(DPAD_UP, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::DPadRight) {
                    context.write_port(DPAD_RIGHT, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::DPadDown) {
                    context.write_port(DPAD_DOWN, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::DPadLeft) {
                    context.write_port(DPAD_LEFT, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::LeftStick) {
                    context.write_port(LEFT_STICK, value.to_value());
                }
                if let Some(value) = state.is_button_pressed(Button::RightStick) {
                    context.write_port(RIGHT_STICK, value.to_value());
                }
            }
        } else {
            log::error!("Gamepad node is missing DeviceManager");
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
