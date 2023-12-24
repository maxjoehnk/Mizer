use std::f64::consts::PI;
use std::fmt::{Display, Formatter};

use enum_iterator::Sequence;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};

use mizer_node::*;

const LHS_INPUT: &str = "LHS";
const RHS_INPUT: &str = "RHS";
const VALUE_INPUT: &str = "Value";
const VALUE_OUTPUT: &str = "Value";

const MODE_SETTING: &str = "Mode";

#[derive(Default, Clone, Debug, Deserialize, Serialize, PartialEq, Eq)]
pub struct MathNode {
    pub mode: MathMode,
}

impl ConfigurableNode for MathNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(enum MODE_SETTING, self.mode)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, MODE_SETTING, self.mode);

        update_fallback!(setting)
    }
}

impl PipelineNode for MathNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Math".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn display_name(&self, _injector: &Injector) -> String {
        match self.mode {
            MathMode::Addition => "Add".into(),
            MathMode::Subtraction => "Subtract".into(),
            MathMode::Multiplication => "Multiply".into(),
            MathMode::Division => "Divide".into(),
            mode => mode.to_string(),
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        let mut ports = vec![output_port!(VALUE_OUTPUT, PortType::Single)];
        if self.mode.single_parameter() {
            ports.push(input_port!(VALUE_INPUT, PortType::Single));
        } else {
            ports.push(input_port!(LHS_INPUT, PortType::Single));
            ports.push(input_port!(RHS_INPUT, PortType::Single));
        }

        ports
    }

    fn node_type(&self) -> NodeType {
        NodeType::Math
    }
}

impl ProcessingNode for MathNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let value = if self.mode.single_parameter() {
            if let Some(value) = context.read_port::<_, f64>(VALUE_INPUT) {
                let value = match self.mode {
                    MathMode::Invert => 1f64 - value,
                    MathMode::Sine => (value * PI).sin(),
                    MathMode::Cosine => (value * PI).cos(),
                    MathMode::Tangent => (value * PI).tan(),
                    _ => unreachable!(),
                };
                Some(value)
            } else {
                None
            }
        } else if let Some((lhs, rhs)) = context
            .read_port::<_, f64>(LHS_INPUT)
            .zip(context.read_port::<_, f64>(RHS_INPUT))
        {
            let value = match self.mode {
                MathMode::Addition => lhs + rhs,
                MathMode::Subtraction => lhs - rhs,
                MathMode::Multiplication => lhs * rhs,
                MathMode::Division => lhs / rhs,
                _ => unreachable!(),
            };

            Some(value)
        } else {
            None
        };

        if let Some(value) = value {
            context.write_port(VALUE_OUTPUT, value);
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(
    Default,
    Clone,
    Copy,
    Debug,
    Deserialize,
    Serialize,
    PartialEq,
    Eq,
    Sequence,
    TryFromPrimitive,
    IntoPrimitive,
)]
#[repr(u8)]
pub enum MathMode {
    #[default]
    Addition,
    Subtraction,
    Multiplication,
    Division,
    Invert,
    Sine,
    Cosine,
    Tangent,
}

impl MathMode {
    fn single_parameter(&self) -> bool {
        matches!(
            self,
            MathMode::Invert | MathMode::Sine | MathMode::Cosine | MathMode::Tangent
        )
    }
}

impl Display for MathMode {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}
