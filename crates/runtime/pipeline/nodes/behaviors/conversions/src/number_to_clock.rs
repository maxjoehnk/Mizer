use std::time::Duration;

use serde::{Deserialize, Serialize};

use mizer_clock::Timecode;
use mizer_node::*;

const VALUE_INPUT: &str = "Input";
const VALUE_OUTPUT: &str = "Output";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct NumberToClockNode;

impl ConfigurableNode for NumberToClockNode {}

impl PipelineNode for NumberToClockNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Number to Clock".into(),
            preview_type: PreviewType::Timecode,
            category: NodeCategory::Conversions,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(VALUE_INPUT, PortType::Single),
            output_port!(VALUE_OUTPUT, PortType::Clock),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::NumberToClock
    }
}

impl ProcessingNode for NumberToClockNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let value = context.read_port::<_, port_types::SINGLE>(VALUE_INPUT);

        if let Some(value) = value {
            let value: port_types::CLOCK = Duration::from_secs_f64(value);
            context.write_port(VALUE_OUTPUT, value);
            context.write_timecode_preview(Timecode::from_duration(value, context.fps()));
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
