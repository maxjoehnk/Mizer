use mizer_clock::Timecode;
use mizer_node::*;
use serde::{Deserialize, Serialize};

const INPUT_CLOCK_PORT: &str = "Clock";

#[derive(Clone, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
pub struct TimecodeNode {}

impl ConfigurableNode for TimecodeNode {}

impl PipelineNode for TimecodeNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Timecode".into(),
            preview_type: PreviewType::Timecode,
            category: NodeCategory::Controls,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(INPUT_CLOCK_PORT, PortType::Clock)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Timecode
    }
}

impl ProcessingNode for TimecodeNode {
    type State = Option<Timecode>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(clock) = context.clock_input(INPUT_CLOCK_PORT).read() {
            let timecode = Timecode::from_duration(clock, context.fps());
            context.write_timecode_preview(timecode);
            *state = Some(timecode);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl TimecodeNode {
    pub fn timecode(&self, state: &<Self as ProcessingNode>::State) -> Option<Timecode> {
        *state
    }
}
