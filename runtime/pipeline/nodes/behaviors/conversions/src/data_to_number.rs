use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::*;

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct DataToNumberNode;

impl PipelineNode for DataToNumberNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "DataToNumberNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                "value".into(),
                PortMetadata {
                    port_type: PortType::Data,
                    direction: PortDirection::Input,
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
        NodeType::DataToNumber
    }
}

impl ProcessingNode for DataToNumberNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let data = context.read_port::<_, StructuredData>("value");
        let value = match data {
            Some(StructuredData::Float(value)) => Some(value),
            Some(StructuredData::Int(value)) => Some(value as f64),
            _ => None,
        };

        if let Some(value) = value {
            context.write_port("value", value);
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
