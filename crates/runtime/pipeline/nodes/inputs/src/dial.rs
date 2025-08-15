use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::LerpExt;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";

const START_VALUE_SETTING: &str = "Start Value";
const END_VALUE_SETTING: &str = "End Value";
const DEFAULT_VALUE_SETTING: &str = "Default Value";
const SHOW_PERCENTAGE_SETTING: &str = "Show Percentage";

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
pub struct DialNode {
    #[serde(default = "default_start_value")]
    pub start_value: f64,
    #[serde(default = "default_end_value")]
    pub end_value: f64,
    #[serde(default)]
    pub default_value: f64,
    #[serde(default = "default_show_percentage")]
    pub show_percentage: bool,
}

impl Default for DialNode {
    fn default() -> Self {
        Self {
            start_value: default_start_value(),
            end_value: default_end_value(),
            default_value: Default::default(),
            show_percentage: default_show_percentage(),
        }
    }
}

fn default_start_value() -> f64 {
    0f64
}

fn default_end_value() -> f64 {
    1f64
}

fn default_show_percentage() -> bool {
    true
}

impl ConfigurableNode for DialNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(DEFAULT_VALUE_SETTING, self.default_value)
                .min(0f64)
                .max(1f64),
            setting!(START_VALUE_SETTING, self.start_value)
                .min_hint(0f64)
                .max_hint(1f64),
            setting!(END_VALUE_SETTING, self.end_value)
                .min_hint(0f64)
                .max_hint(1f64),
            setting!(SHOW_PERCENTAGE_SETTING, self.show_percentage)
                .category("Layout")
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, DEFAULT_VALUE_SETTING, self.default_value);
        update!(float setting, START_VALUE_SETTING, self.start_value);
        update!(float setting, END_VALUE_SETTING, self.end_value);
        update!(bool setting, SHOW_PERCENTAGE_SETTING, self.show_percentage);

        update_fallback!(setting)
    }
}

impl PipelineNode for DialNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Dial".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Controls,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Single),
            output_port!(OUTPUT_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Dial
    }
}

impl ProcessingNode for DialNode {
    type State = Option<f64>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port_changes::<_, f64>(INPUT_PORT) {
            *state = Some(value);
        }
        let value = self.value(state);
        context.push_history_value(value);
        let value: f64 = value.linear_extrapolate((0., 1.), (self.start_value, self.end_value));
        context.write_port(OUTPUT_PORT, value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, state: &Self::State) {
        ui.collapsing_header("State", None, |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Value");
                columns[1].label(self.value(state).to_string());
            });
        });
    }
}

impl DialNode {
    pub fn value(&self, state: &<DialNode as ProcessingNode>::State) -> f64 {
        if self.show_percentage {
            state.unwrap_or(self.default_value)
        }else {
            state.unwrap_or(self.default_value).linear_extrapolate((0., 1.), (self.start_value, self.end_value))
        }
    }

    pub fn range(&self) -> (f64, f64) {
        (self.start_value, self.end_value)
    }

    pub fn percentage(&self) -> bool {
        self.show_percentage
    }
}
