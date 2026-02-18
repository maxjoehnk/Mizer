use std::fmt::{Display, Formatter};

use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_devices::DeviceManager;
use mizer_g13::Keys;
use mizer_node::*;

use crate::G13InjectorExt;

const VALUE_PORT: &str = "Value";

const KEY_SETTING: &str = "Key";
const DEVICE_SETTING: &str = "Device";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct G13InputNode {
    #[serde(rename = "device")]
    pub device_id: String,
    pub key: G13Key,
}

impl ConfigurableNode for G13InputNode {
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let devices = injector.get_devices();

        vec![
            setting!(enum KEY_SETTING, self.key),
            setting!(select DEVICE_SETTING, &self.device_id, devices),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, KEY_SETTING, self.key);
        update!(select setting, DEVICE_SETTING, self.device_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for G13InputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "G13 Input".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::G13Input
    }
}

impl ProcessingNode for G13InputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(device_manager) = context.try_inject::<DeviceManager>() {
            if let Some(g13) = device_manager.get_g13_mut(&self.device_id) {
                let value: Option<f32> = match self.key {
                    G13Key::JoystickX => g13.joystick_x(),
                    G13Key::JoystickY => g13.joystick_y(),
                    G13Key::G1 => g13.is_key_pressed(Keys::G1).then_some(1.).or(Some(0.)),
                    G13Key::G2 => g13.is_key_pressed(Keys::G2).then_some(1.).or(Some(0.)),
                    G13Key::G3 => g13.is_key_pressed(Keys::G3).then_some(1.).or(Some(0.)),
                    G13Key::G4 => g13.is_key_pressed(Keys::G4).then_some(1.).or(Some(0.)),
                    G13Key::G5 => g13.is_key_pressed(Keys::G5).then_some(1.).or(Some(0.)),
                    G13Key::G6 => g13.is_key_pressed(Keys::G6).then_some(1.).or(Some(0.)),
                    G13Key::G7 => g13.is_key_pressed(Keys::G7).then_some(1.).or(Some(0.)),
                    G13Key::G8 => g13.is_key_pressed(Keys::G8).then_some(1.).or(Some(0.)),
                    G13Key::G9 => g13.is_key_pressed(Keys::G9).then_some(1.).or(Some(0.)),
                    G13Key::G10 => g13.is_key_pressed(Keys::G10).then_some(1.).or(Some(0.)),
                    G13Key::G11 => g13.is_key_pressed(Keys::G11).then_some(1.).or(Some(0.)),
                    G13Key::G12 => g13.is_key_pressed(Keys::G12).then_some(1.).or(Some(0.)),
                    G13Key::G13 => g13.is_key_pressed(Keys::G13).then_some(1.).or(Some(0.)),
                    G13Key::G14 => g13.is_key_pressed(Keys::G14).then_some(1.).or(Some(0.)),
                    G13Key::G15 => g13.is_key_pressed(Keys::G15).then_some(1.).or(Some(0.)),
                    G13Key::G16 => g13.is_key_pressed(Keys::G16).then_some(1.).or(Some(0.)),
                    G13Key::G17 => g13.is_key_pressed(Keys::G17).then_some(1.).or(Some(0.)),
                    G13Key::G18 => g13.is_key_pressed(Keys::G18).then_some(1.).or(Some(0.)),
                    G13Key::G19 => g13.is_key_pressed(Keys::G19).then_some(1.).or(Some(0.)),
                    G13Key::G20 => g13.is_key_pressed(Keys::G20).then_some(1.).or(Some(0.)),
                    G13Key::G21 => g13.is_key_pressed(Keys::G21).then_some(1.).or(Some(0.)),
                    G13Key::G22 => g13.is_key_pressed(Keys::G22).then_some(1.).or(Some(0.)),
                    G13Key::M1 => g13.is_key_pressed(Keys::M1).then_some(1.).or(Some(0.)),
                    G13Key::M2 => g13.is_key_pressed(Keys::M2).then_some(1.).or(Some(0.)),
                    G13Key::M3 => g13.is_key_pressed(Keys::M3).then_some(1.).or(Some(0.)),
                    G13Key::MR => g13.is_key_pressed(Keys::MR).then_some(1.).or(Some(0.)),
                    G13Key::BD => g13.is_key_pressed(Keys::BD).then_some(1.).or(Some(0.)),
                    G13Key::L1 => g13.is_key_pressed(Keys::L1).then_some(1.).or(Some(0.)),
                    G13Key::L2 => g13.is_key_pressed(Keys::L2).then_some(1.).or(Some(0.)),
                    G13Key::L3 => g13.is_key_pressed(Keys::L3).then_some(1.).or(Some(0.)),
                    G13Key::L4 => g13.is_key_pressed(Keys::L4).then_some(1.).or(Some(0.)),
                    G13Key::Joystick => g13
                        .is_key_pressed(Keys::JOYSTICK)
                        .then_some(1.)
                        .or(Some(0.)),
                    G13Key::Down => g13.is_key_pressed(Keys::DOWN).then_some(1.).or(Some(0.)),
                    G13Key::Left => g13.is_key_pressed(Keys::LEFT).then_some(1.).or(Some(0.)),
                };
                if let Some(value) = value {
                    let value = value as f64;
                    context.write_port(VALUE_PORT, value);
                    context.push_history_value(value);
                }
            }
        } else {
            anyhow::bail!("G13 Input node is missing DeviceManager");
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
    TryFromPrimitive,
    IntoPrimitive,
)]
#[repr(u8)]
pub enum G13Key {
    #[default]
    G1,
    G2,
    G3,
    G4,
    G5,
    G6,
    G7,
    G8,
    G9,
    G10,
    G11,
    G12,
    G13,
    G14,
    G15,
    G16,
    G17,
    G18,
    G19,
    G20,
    G21,
    G22,
    M1,
    M2,
    M3,
    MR,
    L1,
    L2,
    L3,
    L4,
    JoystickX,
    JoystickY,
    Joystick,
    Left,
    Down,
    BD,
}

impl Display for G13Key {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}
