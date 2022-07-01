use serde::{Deserialize, Serialize};

use mizer_devices::DeviceManager;
use mizer_gamepads::{Axis, Button};
pub use mizer_node::*;
use mizer_util::LerpExt;

const VALUE: &str = "Value";

#[derive(Debug, Clone, Copy, Default, Serialize, Deserialize, PartialEq, Eq)]
pub enum GamepadControl {
    #[default]
    LeftStickX,
    LeftStickY,
    RightStickX,
    RightStickY,
    LeftTrigger,
    RightTrigger,
    LeftShoulder,
    RightShoulder,
    South,
    East,
    North,
    West,
    Select,
    Start,
    DpadUp,
    DpadDown,
    DpadLeft,
    DpadRight,
    LeftStick,
    RightStick,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct GamepadNode {
    #[serde(rename = "device")]
    pub device_id: String,
    pub control: GamepadControl,
}

impl PipelineNode for GamepadNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "GamepadNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            VALUE.into(),
            PortMetadata {
                direction: PortDirection::Output,
                port_type: PortType::Single,
                ..Default::default()
            },
        )]
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
                let value: Option<f64> = match self.control {
                    GamepadControl::LeftStickX => state.axis_value(Axis::LeftStickX).map(axis),
                    GamepadControl::LeftStickY => state.axis_value(Axis::LeftStickY).map(axis),
                    GamepadControl::RightStickX => state.axis_value(Axis::RightStickX).map(axis),
                    GamepadControl::RightStickY => state.axis_value(Axis::RightStickY).map(axis),
                    GamepadControl::LeftTrigger => state.axis_value(Axis::LeftTrigger),
                    GamepadControl::RightTrigger => state.axis_value(Axis::RightTrigger),
                    GamepadControl::South => state
                        .is_button_pressed(Button::South)
                        .map(TogglePort::to_value),
                    GamepadControl::East => state
                        .is_button_pressed(Button::East)
                        .map(TogglePort::to_value),
                    GamepadControl::North => state
                        .is_button_pressed(Button::North)
                        .map(TogglePort::to_value),
                    GamepadControl::West => state
                        .is_button_pressed(Button::West)
                        .map(TogglePort::to_value),
                    GamepadControl::Start => state
                        .is_button_pressed(Button::Start)
                        .map(TogglePort::to_value),
                    GamepadControl::Select => state
                        .is_button_pressed(Button::Select)
                        .map(TogglePort::to_value),
                    GamepadControl::DpadUp => state
                        .is_button_pressed(Button::DPadUp)
                        .map(TogglePort::to_value),
                    GamepadControl::DpadDown => state
                        .is_button_pressed(Button::DPadDown)
                        .map(TogglePort::to_value),
                    GamepadControl::DpadLeft => state
                        .is_button_pressed(Button::DPadLeft)
                        .map(TogglePort::to_value),
                    GamepadControl::DpadRight => state
                        .is_button_pressed(Button::DPadRight)
                        .map(TogglePort::to_value),
                    GamepadControl::LeftStick => state
                        .is_button_pressed(Button::LeftStick)
                        .map(TogglePort::to_value),
                    GamepadControl::RightStick => state
                        .is_button_pressed(Button::RightStick)
                        .map(TogglePort::to_value),
                    _ => None,
                };
                if let Some(value) = value {
                    context.write_port(VALUE, value);
                    context.push_history_value(value);
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

fn axis(value: f64) -> f64 {
    value.linear_extrapolate((-1., 1.), (0., 1.))
}
