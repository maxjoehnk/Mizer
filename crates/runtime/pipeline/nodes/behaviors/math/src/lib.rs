use mizer_node::*;
use serde::{Deserialize, Serialize};
use std::f64::consts::PI;

const LHS_INPUT: &str = "LHS";
const RHS_INPUT: &str = "RHS";
const VALUE_INPUT: &str = "Value";
const VALUE_OUTPUT: &str = "Value";

#[derive(Default, Clone, Debug, Deserialize, Serialize, PartialEq, Eq)]
pub struct MathNode {
    pub mode: MathMode,
}

#[derive(Default, Clone, Copy, Debug, Deserialize, Serialize, PartialEq, Eq)]
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

impl PipelineNode for MathNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "MathNode".into(),
            preview_type: PreviewType::History,
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

    fn update(&mut self, config: &Self) {
        self.mode = config.mode;
    }
}
