use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq)]
pub struct ButtonNode {
}

impl PipelineNode for ButtonNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "ButtonNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        Some(PortMetadata {
            port_type: PortType::Single,
            direction: PortDirection::Output,
            ..Default::default()
        })
    }


    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
             "value".into(),
            PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Input,
                ..Default::default()
            },
         ), (
             "value".into(),
             PortMetadata {
                 port_type: PortType::Single,
                 direction: PortDirection::Output,
                 ..Default::default()
             },
         )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Button
    }
}

impl ProcessingNode for ButtonNode {
    type State = f64;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port::<_, f64>("value") {
            *state = value;
        }
        context.write_port("value", *state);
        context.push_history_value(*state);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

