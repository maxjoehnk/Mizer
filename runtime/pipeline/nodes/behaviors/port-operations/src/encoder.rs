use mizer_node::edge::Edge;
use mizer_node::{
    NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata,
    PortType, PreviewType, ProcessingNode,
};
use serde::{Deserialize, Serialize};

const INCREASE_INPUT: &str = "Increase";
const DECREASE_INPUT: &str = "Decrease";
const RESET_INPUT: &str = "Reset";
const VALUE_OUTPUT: &str = "Value";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct EncoderNode {
    pub hold_rate: f64,
}

impl Default for EncoderNode {
    fn default() -> Self {
        Self { hold_rate: 0.01 }
    }
}

impl PipelineNode for EncoderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "EncoderNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                INCREASE_INPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                DECREASE_INPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                RESET_INPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                VALUE_OUTPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Encoder
    }
}

impl ProcessingNode for EncoderNode {
    type State = EncoderState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(reset) = context.read_port_changes::<_, f64>(RESET_INPUT) {
            if let Some(true) = state.reset.update(reset) {
                state.value = 0f64;
            }
        }
        if let Some(value) = context.read_port::<_, f64>(INCREASE_INPUT) {
            if value > 0f64 {
                state.value = (state.value + (self.hold_rate * value)).min(1f64);
            }
        }
        if let Some(value) = context.read_port::<_, f64>(DECREASE_INPUT) {
            if value > 0f64 {
                state.value = (state.value - (self.hold_rate * value)).max(0f64);
            }
        }

        context.write_port(VALUE_OUTPUT, state.value);
        context.push_history_value(state.value);
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.hold_rate = config.hold_rate;
    }
}

#[derive(Default)]
pub struct EncoderState {
    value: f64,
    reset: Edge,
}
