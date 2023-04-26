use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct FaderNode {}

impl PipelineNode for FaderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(FaderNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!("value", PortType::Single),
            output_port!("value", PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Fader
    }
}

impl ProcessingNode for FaderNode {
    type State = f64;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port_changes::<_, f64>("value") {
            *state = value;
        }
        context.write_port("value", *state);
        context.push_history_value(*state);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, _config: &Self) {}

    fn debug_ui(&self, ui: &mut DebugUiDrawHandle, state: &Self::State) {
        ui.collapsing_header("State", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Value");
                columns[1].label(state.to_string());
            });
        });
    }
}
