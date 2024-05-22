use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_laser::LaserFrame;
use mizer_util::StructuredData;
use mizer_wgpu::TextureHandle;

const CONDITION_INPUT: &str = "Condition";
const VALUE_INPUT: &str = "Value";
const VALUE_OUTPUT: &str = "Value";

const THRESHOLD_SETTING: &str = "Threshold";
const PORT_TYPE_SETTING: &str = "Port Type";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct ConditionalNode {
    pub threshold: f64,
    #[serde(default)]
    pub port_type: PortType,
}

impl Default for ConditionalNode {
    fn default() -> Self {
        Self { threshold: 0.5, port_type: PortType::default() }
    }
}

impl ConfigurableNode for ConditionalNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(THRESHOLD_SETTING, self.threshold)
            .min_hint(0.)
            .max_hint(1.),
            setting!(enum PORT_TYPE_SETTING, self.port_type)
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, THRESHOLD_SETTING, self.threshold);
        update!(enum setting, PORT_TYPE_SETTING, self.port_type);

        update_fallback!(setting)
    }
}

impl PipelineNode for ConditionalNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Conditional".into(),
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
            input_port!(CONDITION_INPUT, PortType::Single),
            input_port!(VALUE_INPUT, self.port_type),
            output_port!(VALUE_OUTPUT, self.port_type),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Conditional
    }
}

impl ProcessingNode for ConditionalNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(condition) = context.read_port::<_, f64>(CONDITION_INPUT) {
            let is_active = condition >= self.threshold;
            match self.port_type {
                PortType::Single => {
                    transfer_port::<f64>(context, is_active);

                    if let Some(value) = is_active.then_some(()).and_then(|_| context.read_port(VALUE_INPUT)) {
                        context.push_history_value(value);
                    }
                }
                PortType::Color => {
                    transfer_port::<Color>(context, is_active);

                    if let Some(value) = is_active.then_some(()).and_then(|_| context.read_port(VALUE_INPUT)) {
                        context.write_color_preview(value);
                    }
                }
                PortType::Multi => transfer_port::<Vec<f64>>(context, is_active),
                PortType::Laser => transfer_port::<Vec<LaserFrame>>(context, is_active),
                PortType::Data => {
                    transfer_port::<StructuredData>(context, is_active);

                    if let Some(value) = is_active.then_some(()).and_then(|_| context.read_port(VALUE_INPUT)) {
                        context.write_data_preview(value);
                    }
                }
                PortType::Clock => transfer_port::<u64>(context, is_active),
                PortType::Texture => transfer_port::<TextureHandle>(context, is_active),
                _ => {}
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

fn transfer_port<TValue: PortValue + 'static>(context: &impl NodeContext, condition: bool) {
    if condition {
        let value = context.read_port::<_, TValue>(VALUE_INPUT);

        if let Some(value) = value {
            context.write_port(VALUE_OUTPUT, value);
            // if TValue::type_id() == f64::type_id() {
            //     context.push_history_value(value);
            // }
        }
    }else {
        context.clear_port::<_, TValue>(VALUE_OUTPUT)
    }
}
