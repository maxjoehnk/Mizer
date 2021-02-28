use mizer_node::*;
use mizer_protocol_midi::*;

#[derive(Clone, Debug, Default)]
pub struct MidiOutputNode {}

impl PipelineNode for MidiOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "MidiOutputNode".into(),
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::MidiOutput
    }
}

impl ProcessingNode for MidiOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
