use std::fmt::{Display, Formatter};

use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_devices::{DeviceManager, DeviceRef};
use mizer_gamepads::{Axis, Button};
pub use mizer_node::*;
use mizer_util::LerpExt;

const VALUE: &str = "Value";

const DEVICE_SETTING: &str = "Device";
const CONTROL_SETTING: &str = "Control";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct GamepadNode {
    #[serde(rename = "device")]
    pub device_id: String,
    pub control: GamepadControl,
}

impl ConfigurableNode for GamepadNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let device_manager = injector.get::<DeviceManager>().unwrap();

        let devices = device_manager
            .current_devices()
            .into_iter()
            .flat_map(|device| {
                if let DeviceRef::Gamepad(gamepad) = device {
                    Some(SelectVariant::Item {
                        value: gamepad.id.into(),
                        label: gamepad.name.into(),
                    })
                } else {
                    None
                }
            })
            .collect();

        vec![
            setting!(enum CONTROL_SETTING, self.control),
            setting!(select DEVICE_SETTING, &self.device_id, devices),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device_id);
        update!(enum setting, CONTROL_SETTING, self.control);

        update_fallback!(setting)
    }
}

impl PipelineNode for GamepadNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Gamepad".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Gamepad
    }
}

impl ProcessingNode for GamepadNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let Some(device_manager) = context.inject::<DeviceManager>() else {
            log::error!("Gamepad node is missing DeviceManager");

            return Ok(())
        };

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
                GamepadControl::Mode => state
                    .is_button_pressed(Button::Mode)
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
                GamepadControl::LeftShoulder => state
                    .is_button_pressed(Button::LeftShoulder)
                    .map(TogglePort::to_value),
                GamepadControl::RightShoulder => state
                    .is_button_pressed(Button::RightShoulder)
                    .map(TogglePort::to_value),
            };
            if let Some(value) = value {
                context.write_port(VALUE, value);
                context.push_history_value(value);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(
    Debug,
    Clone,
    Copy,
    Default,
    Serialize,
    Deserialize,
    PartialEq,
    Eq,
    Sequence,
    IntoPrimitive,
    TryFromPrimitive,
)]
#[repr(u8)]
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
    Mode,
    DpadUp,
    DpadDown,
    DpadLeft,
    DpadRight,
    LeftStick,
    RightStick,
}

fn axis(value: f64) -> f64 {
    value.linear_extrapolate((-1., 1.), (0., 1.))
}

impl Display for GamepadControl {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}
