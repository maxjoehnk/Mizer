use serde::{Deserialize, Serialize};
use mizer_node::{NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata, PortType, PreviewType, ProcessingNode};

const VALUE_INPUT: &str = "value";
const VALUE_OUTPUT: &str = "value";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct ThresholdNode {
    pub threshold: f64,
    pub active_value: f64,
    pub inactive_value: f64,
}

impl Default for ThresholdNode {
    fn default() -> Self {
        Self {
            threshold: 0.5,
            active_value: 1.,
            inactive_value: 0.,
        }
    }
}

impl PipelineNode for ThresholdNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "ThresholdNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (VALUE_INPUT.into(), PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Input,
                ..Default::default()
            }),
            (VALUE_OUTPUT.into(), PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Output,
                ..Default::default()
            }),
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
            let value = if value >= self.threshold {
                self.active_value
            }else {
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
