use serde::{Deserialize, Serialize};

use mizer_node::*;

const CONDITION_INPUT: &str = "Condition";
const VALUE_INPUT: &str = "Value";
const VALUE_OUTPUT: &str = "Value";

const THRESHOLD_SETTING: &str = "Threshold";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct ConditionalNode {
    pub threshold: f64,
}

impl Default for ConditionalNode {
    fn default() -> Self {
        Self { threshold: 0.5 }
    }
}

impl ConfigurableNode for ConditionalNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(THRESHOLD_SETTING, self.threshold)
            .min_hint(0.)
            .max_hint(1.)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, THRESHOLD_SETTING, self.threshold);

        update_fallback!(setting)
    }
}

impl PipelineNode for ConditionalNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Conditional".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(CONDITION_INPUT, PortType::Single),
            input_port!(VALUE_INPUT, PortType::Single),
            output_port!(VALUE_OUTPUT, PortType::Single),
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
            if condition >= self.threshold {
                if let Some(value) = context.read_port(VALUE_INPUT) {
                    context.write_port(VALUE_OUTPUT, value);
                    context.push_history_value(value);
                }
            } else {
                context.clear_port::<_, f64>(VALUE_OUTPUT);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
