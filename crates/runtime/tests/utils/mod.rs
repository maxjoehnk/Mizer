use mizer_commander::{Command, ExtractDependencies};
use mizer_execution_planner::{ExecutionNode, ExecutionPlanner};
use mizer_module::{Injector, Runtime};
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType};
pub use mizer_nodes::test_sink::TestSink;
use mizer_nodes::Node;
use mizer_ports::{PortId, PortType};
use mizer_runtime::commands::{AddLinkCommand, AddNodeCommand, StaticNodeDescriptor};
use mizer_runtime::pipeline_access::PipelineAccess;
use mizer_runtime::CoordinatorRuntime;
pub use mizer_util::clock::*;

pub fn add_node(
    runtime: &mut CoordinatorRuntime<TestClock>,
    node_type: NodeType,
    node: Option<Node>,
    sink: TestSink,
    source_port: impl Into<PortId>,
) {
    let (oscillator_node, output_path) =
        add_node_command(node_type, node, sink, runtime.injector_mut());
    runtime.read_node_ports();
    add_link(
        source_port,
        oscillator_node,
        output_path,
        runtime.injector_mut(),
    );
}

fn add_node_command(
    node_type: NodeType,
    node: Option<Node>,
    sink: TestSink,
    injector: &mut Injector,
) -> (StaticNodeDescriptor, NodePath) {
    let deps = <AddNodeCommand as Command<'_>>::Dependencies::extract(injector);
    let oscillator_add_node = AddNodeCommand {
        node_type,
        designer: NodeDesigner::default(),
        node,
        parent: None,
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
    (oscillator_node, output_path)
}

fn add_link(
    source_port: impl Into<PortId> + Sized,
    oscillator_node: StaticNodeDescriptor,
    output_path: NodePath,
    injector: &mut Injector,
) {
    let add_link_command = AddLinkCommand {
        link: NodeLink {
            source: oscillator_node.path,
            source_port: source_port.into(),
            target: output_path,
            target_port: "input".into(),
            local: false,
            port_type: PortType::Single,
        },
    };
    let deps = <AddLinkCommand as Command<'_>>::Dependencies::extract(injector);
    add_link_command.apply(deps).unwrap();
}
