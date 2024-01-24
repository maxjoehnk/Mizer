use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::LerpExt;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

const START_VALUE_SETTING: &str = "Start Value";
const END_VALUE_SETTING: &str = "End Value";

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
pub struct FaderNode {
    #[serde(default = "default_start_value")]
    pub start_value: f64,
    #[serde(default = "default_end_value")]
    pub end_value: f64,
}

impl Default for FaderNode {
    fn default() -> Self {
        Self {
            start_value: default_start_value(),
            end_value: default_end_value(),
        }
    }
}

fn default_start_value() -> f64 {
    0f64
}

fn default_end_value() -> f64 {
    1f64
}

impl ConfigurableNode for FaderNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(START_VALUE_SETTING, self.start_value)
                .min_hint(0f64)
                .max_hint(1f64),
            setting!(END_VALUE_SETTING, self.end_value)
                .min_hint(0f64)
                .max_hint(1f64),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, START_VALUE_SETTING, self.start_value);
        update!(float setting, END_VALUE_SETTING, self.end_value);

        update_fallback!(setting)
    }
}

impl PipelineNode for FaderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Fader".into(),
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
        let value = *state;
        let value: f64 = value.linear_extrapolate((0., 1.), (self.start_value, self.end_value));
        context.write_port(OUTPUT_PORT, value);
        context.push_history_value(value);

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
