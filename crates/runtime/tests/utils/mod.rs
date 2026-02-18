use mizer_commander::{Command, ExtractDependencies};
use mizer_module::{InjectionScope, Runtime};
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType};
pub use mizer_nodes::test_sink::TestSink;
use mizer_nodes::Node;
use mizer_ports::{PortId, PortType};
use mizer_runtime::commands::{AddLinkCommand, AddNodeCommand, StaticNodeDescriptor};
use mizer_runtime::{CoordinatorRuntime, Pipeline, RuntimeProcessor};
pub use mizer_util::clock::*;

pub fn run_node(
    runtime: &mut CoordinatorRuntime,
    node_type: NodeType,
    node: Option<Node>,
    sink: TestSink,
    source_port: impl Into<PortId>,
) {
    runtime.provide(Pipeline::new());
    runtime.add_processor(RuntimeProcessor);
    let output_path = setup_sink(sink, &runtime.injector());
    let oscillator_node = add_node_command(node_type, node, &runtime.injector());
    add_link(
        source_port,
        oscillator_node,
        output_path,
        &runtime.injector(),
    );
}

fn add_node_command(
    node_type: NodeType,
    node: Option<Node>,
    injector: &InjectionScope,
) -> StaticNodeDescriptor {
    let deps = <AddNodeCommand as Command<'_>>::Dependencies::extract(injector);
    let oscillator_add_node = AddNodeCommand {
        node_type,
        designer: NodeDesigner::default(),
        node,
        parent: None,
        template: None,
    };
    let (oscillator_node, _) = oscillator_add_node.apply(deps).unwrap();
    oscillator_node
}

fn add_link(
    source_port: impl Into<PortId>,
    oscillator_node: StaticNodeDescriptor,
    output_path: NodePath,
    injector: &InjectionScope,
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

fn setup_sink(sink: TestSink, injector: &InjectionScope) -> NodePath {
    let deps = <AddNodeCommand as Command<'_>>::Dependencies::extract(injector);
    let sink_add_node = AddNodeCommand {
        node_type: NodeType::TestSink,
        designer: NodeDesigner::default(),
        node: Some(Node::TestSink(sink)),
        parent: None,
        template: None,
    };
    let (descriptor, _) = sink_add_node.apply(deps).unwrap();

    descriptor.path
}
