use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::*;

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct NumberToDataNode;

impl PipelineNode for NumberToDataNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "NumberToDataNode".into(),
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
                    ..Default::default()
                },
            ),
            (
                "value".into(),
                PortMetadata {
                    port_type: PortType::Data,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::NumberToData
    }
}

impl ProcessingNode for NumberToDataNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let value = context.read_port::<_, f64>("value");

        if let Some(value) = value {
            context.write_port("value", StructuredData::Float(value));
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, _config: &Self) {}
}
