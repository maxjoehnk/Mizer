use serde::{Deserialize, Serialize};

use mizer_node::*;

const VALUE_INPUT: &str = "Value";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct LabelNode {
    #[serde(default)]
    pub text: String,
}

impl PipelineNode for LabelNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(LabelNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::Label
    }
}

impl ProcessingNode for LabelNode {
    type State = ();

    fn process(&self, _context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.text = config.text.clone();
    }
}

impl LabelNode {
    pub fn label(&self, _state: &<Self as ProcessingNode>::State) -> String {
        self.text.clone()
    }
}
