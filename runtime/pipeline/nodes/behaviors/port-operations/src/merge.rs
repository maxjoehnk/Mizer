use mizer_node::*;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq)]
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
            name: "MergeNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
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
}
