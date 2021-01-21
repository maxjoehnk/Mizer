use mizer_node_api::*;

pub struct SequenceNode {

}

impl ProcessingNode for SequenceNode {
    fn get_details(&self) -> NodeDetails {
        unimplemented!()
    }
}
impl SourceNode for SequenceNode {}
impl DestinationNode for SequenceNode {}
