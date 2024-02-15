use serde::{Deserialize, Serialize};

use mizer_node::*;

const OUTPUT_4_4_PORT: &str = "4/4";
const OUTPUT_2_4_PORT: &str = "2/4";
const OUTPUT_1_4_PORT: &str = "1/4";
const OUTPUT_1_8_PORT: &str = "1/8";
const OUTPUT_1_16_PORT: &str = "1/16";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct BeatsNode {}

impl ConfigurableNode for BeatsNode {}

impl PipelineNode for BeatsNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Beats".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            output_port!(OUTPUT_4_4_PORT, PortType::Single),
            output_port!(OUTPUT_2_4_PORT, PortType::Single),
            output_port!(OUTPUT_1_4_PORT, PortType::Single),
            output_port!(OUTPUT_1_8_PORT, PortType::Single),
            output_port!(OUTPUT_1_16_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Beats
    }
}

impl ProcessingNode for BeatsNode {
    type State = BeatsState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let frame = context.clock();
        context.write_port::<_, f64>(OUTPUT_4_4_PORT, frame.downbeat.into());
        write_port(context, OUTPUT_2_4_PORT, 2.0, &mut state.value_2_4);
        write_port(context, OUTPUT_1_4_PORT, 1.0, &mut state.value_1_4);
        write_port(context, OUTPUT_1_8_PORT, 0.5, &mut state.value_1_8);
        write_port(context, OUTPUT_1_16_PORT, 0.25, &mut state.value_1_16);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default, Clone, Copy)]
pub struct BeatsState {
    value_2_4: f64,
    value_1_4: f64,
    value_1_8: f64,
    value_1_16: f64,
}

fn write_port(context: &impl NodeContext, port: &str, frame: f64, state: &mut f64) {
    let value = context.clock().beat % frame;
    let result = if value < *state { 1f64 } else { 0f64 };
    context.write_port::<_, f64>(port, result);
    *state = value;
}
