use serde::{Deserialize, Serialize};

use mizer_node::*;

const INPUT_PORT: &str = "Inputs";
const OUTPUT_PORT: &str = "Output";

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq, Eq)]
pub struct CombineNode {}

impl ConfigurableNode for CombineNode {}

impl PipelineNode for CombineNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Combine".into(),
            preview_type: PreviewType::Multiple,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Single, multiple),
            output_port!(OUTPUT_PORT, PortType::Multi),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Combine
    }
}

impl ProcessingNode for CombineNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let ports = context.read_ports::<_, f64>(INPUT_PORT);
        let values = ports
            .into_iter()
            .map(|value| value.unwrap_or_default())
            .collect::<Vec<_>>();
        context.write_port(OUTPUT_PORT, values.clone());
        context.write_multi_preview(values);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
