use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};
use std::fmt::{Display, Formatter};

use mizer_node::*;

const INPUT_PORT: &str = "Inputs";
const OUTPUT_PORT: &str = "Output";

const MODE_SETTING: &str = "Mode";

#[derive(Clone, Debug, Default, Deserialize, Serialize, PartialEq, Eq)]
pub struct MergeNode {
    pub mode: MergeMode,
}

impl ConfigurableNode for MergeNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(enum MODE_SETTING, self.mode)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, MODE_SETTING, self.mode);

        update_fallback!(setting)
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
                let ports = context.read_changed_ports::<_, f64>(INPUT_PORT);
                ports.into_iter().flatten().last()
            }
            MergeMode::Lowest | MergeMode::Highest => {
                let ports = context.read_ports::<_, f64>(INPUT_PORT);
                let ports_with_value = ports.into_iter().flatten();

                if self.mode == MergeMode::Highest {
                    ports_with_value.max_by(|lhs, rhs| lhs.partial_cmp(rhs).unwrap())
                } else {
                    ports_with_value.min_by(|lhs, rhs| lhs.partial_cmp(rhs).unwrap())
                }
            }
        };
        if let Some(value) = value {
            context.write_port(OUTPUT_PORT, value);
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(
    Clone,
    Copy,
    Debug,
    Default,
    Deserialize,
    Serialize,
    PartialEq,
    Eq,
    Sequence,
    TryFromPrimitive,
    IntoPrimitive,
)]
#[serde(rename_all = "lowercase")]
#[repr(u8)]
pub enum MergeMode {
    #[default]
    Latest,
    Highest,
    Lowest,
}

impl Display for MergeMode {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}
