use mizer_node::*;
use mizer_protocol_midi::*;

#[derive(Clone, Debug, Default)]
pub struct MidiInputNode {}

impl PipelineNode for MidiInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "MidiInputNode".into()
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::MidiInput
    }
}

impl ProcessingNode for MidiInputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
