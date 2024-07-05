use serde::{Deserialize, Serialize};
use mizer_node::*;
use mizer_node::edge::Edge;
use mizer_ui_api::dialog::{Dialog, DialogService};

const TITLE_SETTING: &str = "Title";
const TEXT_SETTING: &str = "Text";

const TRIGGER_PORT: &str = "Trigger";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct DialogNode {
    title: String,
    text: String,
}

impl ConfigurableNode for DialogNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(TITLE_SETTING, &self.title),
            setting!(TEXT_SETTING, &self.text).multiline(),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, TITLE_SETTING, self.title);
        update!(text setting, TEXT_SETTING, self.text);

        update_fallback!(setting)
    }
}

impl PipelineNode for DialogNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Dialog".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Ui,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(TRIGGER_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Dialog
    }
}

impl ProcessingNode for DialogNode {
    type State = DialogState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(true) = context.single_input(TRIGGER_PORT).read().and_then(|v| state.trigger_edge.update(v)) {
            let Some(dialog_service) = context.try_inject::<DialogService>() else {
                return Ok(());
            };
            
            let dialog = Dialog::builder()
                .title(self.title.clone())
                .text(self.text.clone())
                .build()?;
            
            dialog_service.show_dialog(dialog)?;
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default, Clone, Copy)]
pub struct DialogState {
    trigger_edge: Edge,
}
