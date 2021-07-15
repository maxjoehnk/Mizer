use mizer_node::*;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq)]
pub struct SelectNode {}

impl PipelineNode for SelectNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "SelectNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                "channel".into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Single,
                    ..PortMetadata::default()
                },
            ),
            (
                "input".into(),
                PortMetadata {
                    direction: PortDirection::Input,
                    port_type: PortType::Single,
                    multiple: true.into(),
                    ..PortMetadata::default()
                },
            ),
            (
                "output".into(),
                PortMetadata {
                    direction: PortDirection::Output,
                    port_type: PortType::Single,
                    ..PortMetadata::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Select
    }
}

impl ProcessingNode for SelectNode {
    type State = Option<usize>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let channel = context.read_port::<_, f64>("channel");
        if let Some(channel) = channel {
            let port_count = context.input_port_count("input");
            *state = Some(((port_count - 1) as f64 * channel).round() as usize);
        }
        if let Some(channel) = state {
            let ports = context.read_ports::<_, f64>("input");
            let value = ports.get(*channel).copied().flatten();

            if let Some(value) = value {
                context.write_port("output", value);
                context.push_history_value(value);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
