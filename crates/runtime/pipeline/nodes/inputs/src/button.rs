use serde::{Deserialize, Serialize};

use mizer_node::edge::Edge;
use mizer_node::*;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const SET_PORT: &str = "Set";
const RESET_PORT: &str = "Reset";

const TOGGLE_SETTING: &str = "Toggle";
const HIGH_VALUE_SETTING: &str = "High Value";
const LOW_VALUE_SETTING: &str = "Low Value";

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
pub struct ButtonNode {
    #[serde(default)]
    pub toggle: bool,
    #[serde(default = "default_high_value")]
    pub high_value: f64,
    #[serde(default = "default_low_value")]
    pub low_value: f64,
}

impl Default for ButtonNode {
    fn default() -> Self {
        Self {
            toggle: false,
            high_value: default_high_value(),
            low_value: default_low_value(),
        }
    }
}

fn default_high_value() -> f64 {
    1f64
}

fn default_low_value() -> f64 {
    0f64
}

impl ConfigurableNode for ButtonNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(TOGGLE_SETTING, self.toggle),
            setting!(HIGH_VALUE_SETTING, self.high_value)
                .min_hint(0f64)
                .max_hint(1f64),
            setting!(LOW_VALUE_SETTING, self.low_value)
                .min_hint(0f64)
                .max_hint(1f64),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(bool setting, TOGGLE_SETTING, self.toggle);
        update!(float setting, HIGH_VALUE_SETTING, self.high_value);
        update!(float setting, LOW_VALUE_SETTING, self.low_value);

        update_fallback!(setting)
    }
}

impl PipelineNode for ButtonNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Button".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Controls,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Single),
            input_port!(SET_PORT, PortType::Single),
            input_port!(RESET_PORT, PortType::Single),
            output_port!(OUTPUT_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Button
    }
}

impl ProcessingNode for ButtonNode {
    type State = ButtonState;

    fn process(
        &self,
        context: &impl NodeContext,
        ButtonState {
            state,
            input_edge,
            reset_edge,
            set_edge,
        }: &mut Self::State,
    ) -> anyhow::Result<()> {
        if let Some(value) = context.read_port::<_, f64>(INPUT_PORT) {
            if self.toggle {
                if let Some(true) = input_edge.update(value) {
                    *state = !*state;
                }
            } else {
                *state = value > 0f64;
            }
        }
        if let Some(value) = context.read_port(SET_PORT) {
            if let Some(true) = set_edge.update(value) {
                *state = true;
            }
        }
        if let Some(value) = context.read_port(RESET_PORT) {
            if let Some(true) = reset_edge.update(value) {
                *state = false;
            }
        }
        let output_value = if *state {
            self.high_value
        } else {
            self.low_value
        };
        context.write_port(OUTPUT_PORT, output_value);
        context.push_history_value(output_value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn debug_ui<'a>(
        &self,
        ui: &mut impl DebugUiDrawHandle<'a>,
        ButtonState {
            state,
            input_edge,
            reset_edge,
            set_edge,
        }: &Self::State,
    ) {
        ui.collapsing_header("Config", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Toggle");
                columns[1].label(self.toggle.to_string());

                columns[0].label("High Value");
                columns[1].label(self.high_value.to_string());

                columns[0].label("Low Value");
                columns[1].label(self.low_value.to_string());
            });
        });
        ui.collapsing_header("State", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Value");
                columns[1].label(state.to_string());

                columns[0].label("Input Edge");
                columns[1].label(format!("{input_edge:?}"));

                columns[0].label("Reset Edge");
                columns[1].label(format!("{reset_edge:?}"));

                columns[0].label("Set Edge");
                columns[1].label(format!("{set_edge:?}"));
            });
        });
    }
}

#[derive(Default, Debug, Clone, Copy)]
pub struct ButtonState {
    state: bool,
    input_edge: Edge,
    reset_edge: Edge,
    set_edge: Edge,
}

impl ButtonState {
    pub fn value(&self) -> bool {
        self.state
    }
}
