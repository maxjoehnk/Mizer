use serde::{Deserialize, Serialize};

use mizer_node::edge::Edge;
use mizer_node::*;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

const TOGGLE_SETTING: &str = "Toggle";
const ROWS_SETTING: &str = "Rows";
const COLUMNS_SETTING: &str = "Columns";

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
pub struct ButtonGridNode {
    #[serde(default)]
    pub toggle: bool,
    pub rows: u32,
    pub columns: u32,
}

impl Default for ButtonGridNode {
    fn default() -> Self {
        Self {
            toggle: false,
            rows: 2,
            columns: 4,
        }
    }
}

impl ConfigurableNode for ButtonGridNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(TOGGLE_SETTING, self.toggle),
            setting!(ROWS_SETTING, self.rows)
                .min(1u32)
                .max_hint(16u32),
            setting!(COLUMNS_SETTING, self.columns)
                .min(1u32)
                .max_hint(16u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(bool setting, TOGGLE_SETTING, self.toggle);
        update!(uint setting, ROWS_SETTING, self.rows);
        update!(uint setting, COLUMNS_SETTING, self.columns);

        update_fallback!(setting)
    }
}

impl PipelineNode for ButtonGridNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Button Grid".into(),
            preview_type: PreviewType::Multiple,
            category: NodeCategory::Controls,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Multi),
            output_port!(OUTPUT_PORT, PortType::Multi),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ButtonGrid
    }
}

impl ProcessingNode for ButtonGridNode {
    type State = Vec<ButtonState>;

    fn process(
        &self,
        context: &impl NodeContext,
        state: &mut Self::State,
    ) -> anyhow::Result<()> {
        let buttons = self.rows * self.columns;
        if state.len() != buttons as usize {
            state.resize(buttons as usize, Default::default());
        }
        if let Some(values) = context.multi_input(INPUT_PORT).read() {
            if state.len() != values.len() {
                // TODO: report issue to ui, but we don't have to pad anything because of how the grid implementation works
                tracing::warn!("Mismatch between grid size and input values size");
            }

            if self.toggle {
                for (state, value) in state.iter_mut().zip(values.iter()) {
                    if let Some(true) = state.input_edge.update(*value) {
                        state.state = !state.state;
                    }
                }
            } else {
                for (state, value) in state.iter_mut().zip(values.iter()) {
                    state.state = *value > 0f64;
                }
            }
        }
        let values: port_types::MULTI = state.iter().map(|state| if state.value() { 1f64 } else { 0f64 }).collect();
        context.write_port(OUTPUT_PORT, values.clone());
        context.write_multi_preview(values);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default, Debug, Clone, Copy)]
pub struct ButtonState {
    state: bool,
    input_edge: Edge,
}

impl ButtonState {
    fn value(&self) -> bool {
        self.state
    }
}
