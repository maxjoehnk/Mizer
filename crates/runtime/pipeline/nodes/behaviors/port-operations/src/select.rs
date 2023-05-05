use mizer_node::*;
use serde::{Deserialize, Serialize};

const CHANNEL_PORT: &str = "Channel";
const INPUT_PORT: &str = "Inputs";
const OUTPUT_PORT: &str = "Output";

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq, Eq)]
pub struct SelectNode {}

impl PipelineNode for SelectNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(SelectNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(CHANNEL_PORT, PortType::Single),
            input_port!(INPUT_PORT, PortType::Single, multiple),
            output_port!(OUTPUT_PORT, PortType::Single),
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
            let ports = context.read_ports::<_, f64>(INPUT_PORT);
            let value = ports.get(*channel).copied().flatten();

            if let Some(value) = value {
                context.write_port(OUTPUT_PORT, value);
                context.push_history_value(value);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, _config: &Self) {}
}
