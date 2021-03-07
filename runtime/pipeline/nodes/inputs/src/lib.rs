use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq)]
pub struct FaderNode {
    #[serde(default)]
    pub value: f64,
}

impl PipelineNode for FaderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "FaderNode".into(),
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "value".into(),
            PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Output,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Fader
    }
}

impl ProcessingNode for FaderNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        context.write_port("value", self.value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
