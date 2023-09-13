use serde::{Deserialize, Serialize};

use mizer_node::*;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct FaderNode;

impl ConfigurableNode for FaderNode {}

impl PipelineNode for FaderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Fader".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Controls,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Single),
            output_port!(OUTPUT_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Fader
    }
}

impl ProcessingNode for FaderNode {
    type State = f64;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port_changes::<_, f64>(INPUT_PORT) {
            *state = value;
        }
        context.write_port(OUTPUT_PORT, *state);
        context.push_history_value(*state);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, state: &Self::State) {
        ui.collapsing_header("State", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Value");
                columns[1].label(state.to_string());
            });
        });
    }
}
