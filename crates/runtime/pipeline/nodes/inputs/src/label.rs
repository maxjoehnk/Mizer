use serde::{Deserialize, Serialize};
use std::sync::Arc;

use mizer_node::*;

const TEXT_SETTING: &str = "Text";

const INPUT_TEXT_PORT: &str = "Text";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct LabelNode {
    #[serde(default)]
    pub text: Arc<String>,
}

impl ConfigurableNode for LabelNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(TEXT_SETTING, self.text.to_string())]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, TEXT_SETTING, self.text);

        update_fallback!(setting)
    }
}

impl PipelineNode for LabelNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Label".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Controls,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(INPUT_TEXT_PORT, PortType::Text)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Label
    }
}

impl ProcessingNode for LabelNode {
    type State = Arc<String>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        *state = context
            .text_input(INPUT_TEXT_PORT)
            .read()
            .unwrap_or_else(|| self.text.clone());

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        self.text.clone()
    }

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, _state: &Self::State) {
        ui.collapsing_header("Config", None, |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Text");
                columns[1].label(self.text.to_string());
            });
        });
    }
}

impl LabelNode {
    pub fn label(&self, state: &<Self as ProcessingNode>::State) -> Arc<String> {
        state.clone()
    }
}
