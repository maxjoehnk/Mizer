use serde::{Deserialize, Serialize};

use mizer_node::{
    NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata,
    PortType, PreviewType, ProcessingNode,
};
use mizer_util::{Spline, SplineStep};

const VALUE_INPUT: &str = "value";
const VALUE_OUTPUT: &str = "value";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct RampNode {
    #[serde(flatten)]
    pub spline: Spline,
}

impl Default for RampNode {
    fn default() -> Self {
        Self {
            spline: Spline {
                steps: vec![
                    SplineStep {
                        x: 0.,
                        y: 0.,
                        c0a: 0.5,
                        c0b: 0.5,
                        c1a: 0.5,
                        c1b: 0.5,
                    },
                    SplineStep {
                        x: 1.,
                        y: 1.,
                        c0a: 0.5,
                        c0b: 0.5,
                        c1a: 0.5,
                        c1b: 0.5,
                    },
                ],
            },
        }
    }
}

impl PipelineNode for RampNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(RampNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                VALUE_INPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                VALUE_OUTPUT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Ramp
    }
}

impl ProcessingNode for RampNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port::<_, f64>(VALUE_INPUT) {
            let value = self.spline.sample(value, 1.);
            context.write_port(VALUE_OUTPUT, value);
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.spline = config.spline.clone();
    }
}
