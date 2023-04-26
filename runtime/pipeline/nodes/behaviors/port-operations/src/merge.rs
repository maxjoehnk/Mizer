use mizer_node::*;
use serde::{Deserialize, Serialize};

const INPUT_PORT: &str = "input";
const OUTPUT_PORT: &str = "output";

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq, Eq)]
pub struct MergeNode {
    pub mode: MergeMode,
}

#[derive(Clone, Copy, Debug, Deserialize, Serialize, PartialEq, Eq)]
#[serde(rename_all = "lowercase")]
pub enum MergeMode {
    Latest,
    Highest,
    Lowest,
}

impl Default for MergeMode {
    fn default() -> Self {
        Self::Latest
    }
}

impl PipelineNode for MergeNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(MergeNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Single, multiple),
            output_port!(OUTPUT_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Merge
    }
}

impl ProcessingNode for MergeNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let value: Option<f64> = match self.mode {
            MergeMode::Latest => {
                let ports = context.read_changed_ports::<_, f64>("input");
                ports.into_iter().flatten().last()
            }
            MergeMode::Lowest | MergeMode::Highest => {
                let ports = context.read_ports::<_, f64>("input");
                let ports_with_value = ports.into_iter().flatten();

                if self.mode == MergeMode::Highest {
                    ports_with_value.max_by(|lhs, rhs| lhs.partial_cmp(rhs).unwrap())
                } else {
                    ports_with_value.min_by(|lhs, rhs| lhs.partial_cmp(rhs).unwrap())
                }
            }
        };
        if let Some(value) = value {
            context.write_port("output", value);
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.mode = config.mode;
    }
}
