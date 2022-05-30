use mizer_commander::{Command, ExtractDependencies};
use mizer_execution_planner::{ExecutionNode, ExecutionPlanner};
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType};
pub use mizer_nodes::test_sink::TestSink;
use mizer_nodes::Node;
use mizer_ports::PortType;
use mizer_processing::Injector;
use mizer_runtime::commands::{AddLinkCommand, AddNodeCommand};
use mizer_runtime::pipeline_access::PipelineAccess;
pub use mizer_util::clock::*;

pub fn add_node(injector: &mut Injector, node_type: NodeType, node: Option<Node>, sink: TestSink) {
    let deps = <AddNodeCommand as Command<'_>>::Dependencies::extract(injector);
    let oscillator_add_node = AddNodeCommand {
        node_type,
        designer: NodeDesigner::default(),
        node,
    };
    let (oscillator_node, _) = oscillator_add_node.apply(deps).unwrap();
    let output_path = NodePath("/output1".into());
    injector
        .get_mut::<PipelineAccess>()
        .unwrap()
        .add_node(output_path.clone(), sink);
    injector
        .get_mut::<ExecutionPlanner>()
        .unwrap()
        .add_node(ExecutionNode {
            path: output_path.clone(),
            attached_executor: None,
        });
    let add_link_command = AddLinkCommand {
        link: NodeLink {
            source: oscillator_node.path,
            source_port: "value".into(),
            target: output_path,
            target_port: "input".into(),
            local: false,
            port_type: PortType::Single,
        },
    };
    let deps = <AddLinkCommand as Command<'_>>::Dependencies::extract(injector);
    add_link_command.apply(deps).unwrap();
}
