use serde::{Deserialize, Serialize};

use mizer_devices::DeviceManager;
use mizer_g13::Keys;
use mizer_node::*;

const KEY_COLOR: &str = "Key Color";
const M1: &str = "M1";
const M2: &str = "M2";
const M3: &str = "M3";
const MR: &str = "MR";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct G13OutputNode {
    #[serde(rename = "device")]
    pub device_id: String,
}

impl PipelineNode for G13OutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(G13OutputNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                KEY_COLOR.into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Color,
                    ..Default::default()
                },
            ),
            (
                M1.into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                M2.into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                M3.into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
            (
                MR.into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Single,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::G13Output
    }
}

impl ProcessingNode for G13OutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(device_manager) = context.inject::<DeviceManager>() {
            if let Some(g13) = device_manager.get_g13_mut(&self.device_id) {
                if let Some(color) = context.read_port::<_, Color>(KEY_COLOR) {
                    g13.write_key_color(color.red, color.green, color.blue)?;
                }
                let m1 = context
                    .read_port::<_, f64>(M1)
                    .map(|value| value > 0.)
                    .unwrap_or_default();
                let m2 = context
                    .read_port::<_, f64>(M2)
                    .map(|value| value > 0.)
                    .unwrap_or_default();
                let m3 = context
                    .read_port::<_, f64>(M3)
                    .map(|value| value > 0.)
                    .unwrap_or_default();
                let mr = context
                    .read_port::<_, f64>(MR)
                    .map(|value| value > 0.)
                    .unwrap_or_default();

                g13.set_key_state(m1, m2, m3, mr)?;
            }
        } else {
            anyhow::bail!("G13 Output node is missing DeviceManager");
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.device_id = config.device_id.clone();
    }
}
