use serde::{Deserialize, Serialize};

use mizer_node::*;

const TEXT_SETTING: &str = "Text";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct LabelNode {
    #[serde(default)]
    pub text: String,
}

impl ConfigurableNode for LabelNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(TEXT_SETTING, &self.text)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, TEXT_SETTING, self.text);

        update_fallback!(setting)
    }
}

impl PipelineNode for LabelNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Label".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Controls,
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

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, _state: &Self::State) {
        ui.collapsing_header("Config", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Text");
                columns[1].label(self.text.to_string());
            });
        });
    }
}

impl LabelNode {
    pub fn label(&self, _state: &<Self as ProcessingNode>::State) -> String {
        self.text.clone()
    }
}
