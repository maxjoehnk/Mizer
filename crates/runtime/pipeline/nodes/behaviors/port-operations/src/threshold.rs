use serde::{Deserialize, Serialize};

use mizer_node::*;

const VALUE_INPUT: &str = "Input";
const VALUE_OUTPUT: &str = "Output";

const LOWER_THRESHOLD_SETTING: &str = "Lower Threshold";
const UPPER_THRESHOLD_SETTING: &str = "Upper Threshold";
const INACTIVE_VALUE_SETTING: &str = "Inactive Value";
const ACTIVE_VALUE_SETTING: &str = "Active Value";

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

impl ConfigurableNode for ThresholdNode {
    fn settings(&self, _injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        vec![
            setting!(LOWER_THRESHOLD_SETTING, self.lower_threshold)
                .min_hint(0.)
                .max_hint(1.),
            setting!(UPPER_THRESHOLD_SETTING, self.upper_threshold)
                .min_hint(0.)
                .max_hint(1.),
            setting!(INACTIVE_VALUE_SETTING, self.inactive_value)
                .min_hint(0.)
                .max_hint(1.),
            setting!(ACTIVE_VALUE_SETTING, self.active_value)
                .min_hint(0.)
                .max_hint(1.),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, LOWER_THRESHOLD_SETTING, self.lower_threshold);
        update!(float setting, UPPER_THRESHOLD_SETTING, self.upper_threshold);
        update!(float setting, INACTIVE_VALUE_SETTING, self.inactive_value);
        update!(float setting, ACTIVE_VALUE_SETTING, self.active_value);

        update_fallback!(setting)
    }
}

impl PipelineNode for ThresholdNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Threshold".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
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
}
