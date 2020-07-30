use mizer_node_api::*;

pub struct SequenceNode {

}

impl ProcessingNode for SequenceNode {
    fn get_details(&self) -> NodeDetails {
        unimplemented!()
    }
}
impl InputNode for SequenceNode {}
impl OutputNode for SequenceNode {}
