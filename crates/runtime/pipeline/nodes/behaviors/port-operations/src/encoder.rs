use mizer_node::edge::Edge;
use mizer_node::*;
use serde::{Deserialize, Serialize};

const INCREASE_INPUT: &str = "Increase";
const DECREASE_INPUT: &str = "Decrease";
const RESET_INPUT: &str = "Reset";
const VALUE_OUTPUT: &str = "Value";

const HOLD_RATE_SETTING: &str = "Hold Rate";
const HOLD_SETTING: &str = "Hold";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct EncoderNode {
    pub hold_rate: f64,
    #[serde(default = "backwards_compatible_hold")]
    pub hold: bool,
}

fn backwards_compatible_hold() -> bool {
    true
}

impl Default for EncoderNode {
    fn default() -> Self {
        Self {
            hold_rate: 0.01,
            hold: false,
        }
    }
}

impl ConfigurableNode for EncoderNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(HOLD_RATE_SETTING, self.hold_rate)
                .min(0.)
                .max_hint(1.),
            setting!(HOLD_SETTING, self.hold),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, HOLD_RATE_SETTING, self.hold_rate);
        update!(bool setting, HOLD_SETTING, self.hold);

        update_fallback!(setting)
    }
}

impl PipelineNode for EncoderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Encoder".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INCREASE_INPUT, PortType::Single),
            input_port!(DECREASE_INPUT, PortType::Single),
            input_port!(RESET_INPUT, PortType::Single),
            output_port!(VALUE_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Encoder
    }
}

impl ProcessingNode for EncoderNode {
    type State = EncoderState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(reset) = context.read_port_changes::<_, f64>(RESET_INPUT) {
            if let Some(true) = state.reset.update(reset) {
                state.value = 0f64;
            }
        }
        if let Some(value) = self.read_port(context, INCREASE_INPUT) {
            if value > 0f64 {
                state.value = (state.value + (self.hold_rate * value)).min(1f64);
            }
        }
        if let Some(value) = self.read_port(context, DECREASE_INPUT) {
            if value > 0f64 {
                state.value = (state.value - (self.hold_rate * value)).max(0f64);
            }
        }

        context.write_port(VALUE_OUTPUT, state.value);
        context.push_history_value(state.value);
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl EncoderNode {
    fn read_port(&self, context: &impl NodeContext, port: impl Into<PortId>) -> Option<f64> {
        if self.hold {
            context.read_port::<_, f64>(port)
        } else {
            context.read_port_changes::<_, f64>(port)
        }
    }
}

#[derive(Default)]
pub struct EncoderState {
    value: f64,
    reset: Edge,
}
