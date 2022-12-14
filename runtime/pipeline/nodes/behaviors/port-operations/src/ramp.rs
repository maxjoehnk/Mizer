use bezier_nd::Bezier;
use geo_nd::{FArray, Vector};
use itertools::Itertools;
use serde::{Deserialize, Serialize};

use mizer_node::{
    NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata,
    PortType, PreviewType, ProcessingNode,
};

const VALUE_INPUT: &str = "value";
const VALUE_OUTPUT: &str = "value";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct RampNode {
    pub steps: Vec<RampStep>,
}

impl Default for RampNode {
    fn default() -> Self {
        Self {
            steps: vec![
                RampStep {
                    x: 0.,
                    y: 0.,
                    c0a: 0.5,
                    c0b: 0.5,
                    c1a: 0.5,
                    c1b: 0.5,
                },
                RampStep {
                    x: 1.,
                    y: 1.,
                    c0a: 0.5,
                    c0b: 0.5,
                    c1a: 0.5,
                    c1b: 0.5,
                },
            ],
        }
    }
}

#[derive(Clone, Copy, Debug, Deserialize, Serialize, PartialEq)]
pub struct RampStep {
    pub x: f64,
    pub y: f64,
    pub c0a: f64,
    pub c0b: f64,
    pub c1a: f64,
    pub c1b: f64,
}

impl PipelineNode for RampNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "RampNode".into(),
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
            let value = self.translate(value);
            context.write_port(VALUE_OUTPUT, value);
            context.push_history_value(value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.steps = config.steps.clone();
    }
}

impl RampNode {
    fn translate(&self, input: f64) -> f64 {
        let input = input.clamp(0., 1.);
        let bezier = self
            .steps
            .iter()
            .tuple_windows()
            .find_or_last(|(a, b)| a.x <= input && b.x > input)
            .map(Self::tuple_to_bezier);

        if let Some(bezier) = bezier {
            bezier.point_at(input)[1]
        } else {
            log::warn!("BVxroken ramp configuration, unable to find bezier step for input {input}");
            0.
        }
    }

    fn tuple_to_bezier((a, b): (&RampStep, &RampStep)) -> Bezier<f64, FArray<f64, 2>, 2> {
        Bezier::cubic(
            &FArray::from_array([a.x, a.y]),
            &FArray::from_array([b.c0a, b.c0b]),
            &FArray::from_array([b.c1a, b.c1b]),
            &FArray::from_array([b.x, b.y]),
        )
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use crate::{RampNode, RampStep};

    #[test_case(0f64)]
    #[test_case(0.5f64)]
    #[test_case(1f64)]
    fn process_should_translate_values_of_basic_ramp(value: f64) {
        let node = RampNode::default();

        let result = node.translate(value);

        assert_eq!(result, value);
    }

    #[test_case(0f64, 1f64, 0f64, 1f64, 1f64, 1f64)]
    #[test_case(0f64, 1f64, 0f64, 1f64, 0f64, 0f64)]
    #[test_case(0f64, 1f64, 0f64, 1f64, 0.5f64, 0f64)]
    fn process_should_translate_values_of_two_step_ramp(
        y1: f64,
        x2: f64,
        y2: f64,
        y3: f64,
        value: f64,
        expected: f64,
    ) {
        let node = RampNode {
            steps: vec![
                RampStep {
                    x: 0.,
                    y: y1,
                    c0a: 0.,
                    c0b: 0.,
                    c1a: 0.,
                    c1b: 0.,
                },
                RampStep {
                    x: x2,
                    y: y2,
                    c0a: 0.,
                    c0b: y1,
                    c1a: 0.,
                    c1b: y1,
                },
                RampStep {
                    x: 1.,
                    y: y3,
                    c0a: x2,
                    c0b: y2,
                    c1a: 1.,
                    c1b: y3,
                },
            ],
        };

        let result = node.translate(value);

        assert_eq!(result, expected);
    }
}
