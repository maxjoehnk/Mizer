use mizer_node::*;
use serde::{Deserialize, Serialize};

const VALUE_INPUT: &str = "Input";
const VALUE_OUTPUT: &str = "Output";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct ThresholdNode {
    #[serde(alias = "threshold")]
    pub lower_threshold: f64,
    #[serde(default = "default_upper_threshold")]
    pub upper_threshold: f64,
    pub active_value: f64,
    pub inactive_value: f64,
}

fn default_upper_threshold() -> f64 {
    // We choose a very large value here so we don't break existing project files
    1_000_000f64
}

impl Default for ThresholdNode {
    fn default() -> Self {
        Self {
            lower_threshold: 0.5,
            upper_threshold: default_upper_threshold(),
            active_value: 1.,
            inactive_value: 0.,
        }
    }
}

impl PipelineNode for ThresholdNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(ThresholdNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(VALUE_INPUT, PortType::Single),
            output_port!(VALUE_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Threshold
    }
}

impl ProcessingNode for ThresholdNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port_changes::<_, f64>(VALUE_INPUT) {
            let value = if value >= self.lower_threshold && value < self.upper_threshold {
                self.active_value
            } else {
                self.inactive_value
            };
            context.write_port(VALUE_OUTPUT, value);
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.lower_threshold = config.lower_threshold;
        self.upper_threshold = config.upper_threshold;
        self.active_value = config.active_value;
        self.inactive_value = config.inactive_value;
    }
}
