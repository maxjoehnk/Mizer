use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq)]
pub struct ButtonNode {
    #[serde(default)]
    pub toggle: bool,
}

impl PipelineNode for ButtonNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "ButtonNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                "value".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    edge: true,
                    ..Default::default()
                },
            ),
            (
                "value".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Button
    }
}

impl ProcessingNode for ButtonNode {
    type State = bool;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if self.toggle {
            if let Some(true) = context.read_edge("value") {
                *state = !*state;
            }
        } else {
            if let Some(value) = context.read_port::<_, f64>("value") {
                *state = value > 0f64;
            }
        }
        let output_value = if *state { 1f64 } else { 0f64 };
        context.write_port("value", output_value);
        context.push_history_value(output_value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
