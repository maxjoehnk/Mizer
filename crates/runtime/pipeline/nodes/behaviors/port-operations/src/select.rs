use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_laser::LaserFrame;
use mizer_util::StructuredData;
use mizer_wgpu::TextureHandle;

const CHANNEL_PORT: &str = "Channel";
const INPUT_PORT: &str = "Inputs";
const OUTPUT_PORT: &str = "Output";

const PORT_TYPE_SETTING: &str = "Port Type";

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq, Eq)]
pub struct SelectNode {
    #[serde(default)]
    pub port_type: PortType,
}

impl ConfigurableNode for SelectNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(enum PORT_TYPE_SETTING, self.port_type)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, PORT_TYPE_SETTING, self.port_type);

        update_fallback!(setting)
    }
}

impl PipelineNode for SelectNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Select".into(),
            preview_type: match self.port_type {
                PortType::Single => PreviewType::History,
                PortType::Multi => PreviewType::Multiple,
                PortType::Color => PreviewType::Color,
                PortType::Data => PreviewType::Data,
                PortType::Texture => PreviewType::Texture,
                PortType::Clock => PreviewType::Timecode,
                _ => PreviewType::None,
            },
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(CHANNEL_PORT, PortType::Single),
            input_port!(INPUT_PORT, self.port_type, multiple),
            output_port!(OUTPUT_PORT, self.port_type),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Select
    }
}

impl ProcessingNode for SelectNode {
    type State = Option<usize>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let channel = context.read_port::<_, f64>(CHANNEL_PORT);
        if let Some(channel) = channel {
            let port_count = context.input_port_count(INPUT_PORT);
            *state = Some((port_count.saturating_sub(1) as f64 * channel).round() as usize);
        }
        if let Some(channel) = state {
            match self.port_type {
                PortType::Single => {
                    transfer_port::<f64>(context, *channel);
                    let ports = context.read_ports::<_, _>(INPUT_PORT);
                    let value = ports.get(*channel).copied().flatten();

                    if let Some(value) = value {
                        context.push_history_value(value);
                    }
                }
                PortType::Color => {
                    transfer_port::<Color>(context, *channel);
                    let ports = context.read_ports::<_, _>(INPUT_PORT);
                    let value = ports.get(*channel).copied().flatten();

                    if let Some(value) = value {
                        context.write_color_preview(value);
                    }
                }
                PortType::Multi => {
                    transfer_port::<Vec<f64>>(context, *channel);
                    let ports = context.read_ports::<_, _>(INPUT_PORT);
                    let value = ports.get(*channel).cloned().flatten();

                    if let Some(value) = value {
                        context.write_multi_preview(value);
                    }
                }
                PortType::Laser => transfer_port::<Vec<LaserFrame>>(context, *channel),
                PortType::Data => {
                    transfer_port::<StructuredData>(context, *channel);
                    let ports = context.read_ports::<_, _>(INPUT_PORT);
                    let value = ports.get(*channel).cloned().flatten();

                    if let Some(value) = value {
                        context.write_data_preview(value);
                    }
                }
                PortType::Clock => transfer_port::<u64>(context, *channel),
                PortType::Texture => transfer_port::<TextureHandle>(context, *channel),
                _ => {}
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

fn transfer_port<TValue: PortValue + 'static>(context: &impl NodeContext, channel: usize) {
    let mut ports = context.read_ports::<_, TValue>(INPUT_PORT);
    if channel >= ports.len() {
        return;
    }
    let value = ports.remove(channel);

    if let Some(value) = value {
        context.write_port(OUTPUT_PORT, value);
        // if TValue::type_id() == f64::type_id() {
        //     context.push_history_value(value);
        // }
    }
}
