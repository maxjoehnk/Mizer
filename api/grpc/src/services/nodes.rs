use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};
use protobuf::SingularPtrField;

use crate::protos::{AddNodeRequest, NodePosition, NodesApi};
use crate::protos::{
    ChannelProtocol, Node, NodeConnection, Node_NodeType, Nodes, NodesRequest, Port,
};
use mizer_node::{NodeDesigner, NodeType, PortDirection, PortId, PortMetadata, PortType};
use mizer_runtime::{NodeDescriptor, RuntimeApi};

pub struct NodesApiImpl {
    runtime: RuntimeApi,
}

impl NodesApiImpl {
    pub fn new(runtime: RuntimeApi) -> Self {
        NodesApiImpl { runtime }
    }
}

impl NodesApi for NodesApiImpl {
    fn get_nodes(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<NodesRequest>,
        resp: ServerResponseUnarySink<Nodes>,
    ) -> grpc::Result<()> {
        let mut res = Nodes::new();

        let nodes = self.runtime.nodes();

        for node in nodes {
            let node: Node = node.into();
            res.nodes.push(node);
        }
        for channel in self.runtime.links() {
            let mut conn = NodeConnection {
                sourceNode: channel.source.to_string(),
                targetNode: channel.target.to_string(),
                ..Default::default()
            };
            let source_port = Port {
                protocol: ChannelProtocol::Single,
                name: channel.source_port.to_string(),
                ..Default::default()
            };
            conn.set_sourcePort(source_port);
            let target_port = Port {
                protocol: ChannelProtocol::Single,
                name: channel.target_port.to_string(),
                ..Default::default()
            };
            conn.set_targetPort(target_port);
            res.channels.push(conn);
        }
        resp.finish(res)
    }

    fn add_node(
        &self,
        context: ServerHandlerContext,
        req: ServerRequestSingle<AddNodeRequest>,
        resp: ServerResponseUnarySink<Node>,
    ) -> grpc::Result<()> {
        let position = req.message.position.unwrap();
        let designer = NodeDesigner {
            position: mizer_node::NodePosition {
                x: position.x,
                y: position.y,
            },
            scale: 1.,
        };

        let node = self
            .runtime
            .add_node(req.message.field_type.into(), designer)
            .unwrap();

        resp.finish(node.into())
    }
}

impl From<NodeType> for Node_NodeType {
    fn from(node: NodeType) -> Self {
        match node {
            NodeType::Fader => Node_NodeType::Fader,
            NodeType::DmxOutput => Node_NodeType::DmxOutput,
            NodeType::Oscillator => Node_NodeType::Oscillator,
            NodeType::Clock => Node_NodeType::Clock,
            NodeType::OscInput => Node_NodeType::OscInput,
            NodeType::VideoFile => Node_NodeType::VideoFile,
            NodeType::VideoOutput => Node_NodeType::VideoOutput,
            NodeType::VideoEffect => Node_NodeType::VideoEffect,
            NodeType::VideoColorBalance => Node_NodeType::VideoColorBalance,
            NodeType::VideoTransform => Node_NodeType::VideoTransform,
            NodeType::Scripting => Node_NodeType::Script,
            NodeType::PixelDmx => Node_NodeType::PixelToDmx,
            NodeType::PixelPattern => Node_NodeType::PixelPattern,
            NodeType::OpcOutput => Node_NodeType::OpcOutput,
            NodeType::Fixture => Node_NodeType::Fixture,
            NodeType::Sequence => Node_NodeType::Sequence,
            NodeType::MidiInput => Node_NodeType::MidiInput,
            NodeType::MidiOutput => Node_NodeType::MidiOutput,
            NodeType::Laser => Node_NodeType::Laser,
            NodeType::IldaFile => Node_NodeType::IldaFile,
        }
    }
}

impl From<Node_NodeType> for NodeType {
    fn from(node: Node_NodeType) -> Self {
        match node {
            Node_NodeType::Fader => NodeType::Fader,
            Node_NodeType::DmxOutput => NodeType::DmxOutput,
            Node_NodeType::Oscillator => NodeType::Oscillator,
            Node_NodeType::Clock => NodeType::Clock,
            Node_NodeType::OscInput => NodeType::OscInput,
            Node_NodeType::VideoFile => NodeType::VideoFile,
            Node_NodeType::VideoOutput => NodeType::VideoOutput,
            Node_NodeType::VideoEffect => NodeType::VideoEffect,
            Node_NodeType::VideoColorBalance => NodeType::VideoColorBalance,
            Node_NodeType::VideoTransform => NodeType::VideoTransform,
            Node_NodeType::Script => NodeType::Scripting,
            Node_NodeType::PixelToDmx => NodeType::PixelDmx,
            Node_NodeType::PixelPattern => NodeType::PixelPattern,
            Node_NodeType::OpcOutput => NodeType::OpcOutput,
            Node_NodeType::Fixture => NodeType::Fixture,
            Node_NodeType::Sequence => NodeType::Sequence,
            Node_NodeType::MidiInput => NodeType::MidiInput,
            Node_NodeType::MidiOutput => NodeType::MidiOutput,
            Node_NodeType::Laser => NodeType::Laser,
            Node_NodeType::IldaFile => NodeType::IldaFile,
        }
    }
}

impl From<NodeDescriptor<'_>> for Node {
    fn from(descriptor: NodeDescriptor<'_>) -> Self {
        let node_type = descriptor.node_type();
        let mut node = Node {
            path: descriptor.path.to_string(),
            field_type: node_type.into(),
            designer: SingularPtrField::some(descriptor.designer.into()),
            ..Default::default()
        };
        let (inputs, outputs) = descriptor
            .ports
            .into_iter()
            .partition::<Vec<_>, _>(|(_, port)| matches!(port.direction, PortDirection::Input));

        for input in inputs {
            node.inputs.push(input.into());
        }
        for output in outputs {
            node.outputs.push(output.into());
        }

        log::debug!("{:?}", node);

        node
    }
}

impl From<NodeDesigner> for crate::protos::NodeDesigner {
    fn from(designer: NodeDesigner) -> Self {
        crate::protos::NodeDesigner {
            scale: designer.scale,
            position: SingularPtrField::some(NodePosition {
                x: designer.position.x,
                y: designer.position.y,
                ..Default::default()
            }),
            ..Default::default()
        }
    }
}

impl From<PortType> for ChannelProtocol {
    fn from(port: PortType) -> Self {
        match port {
            PortType::Single => ChannelProtocol::Single,
            PortType::Multi => ChannelProtocol::Multi,
            PortType::Texture => ChannelProtocol::Texture,
            PortType::Vector => ChannelProtocol::Vector,
            PortType::Laser => ChannelProtocol::Laser,
            PortType::Poly => ChannelProtocol::Poly,
            PortType::Data => ChannelProtocol::Data,
            PortType::Material => ChannelProtocol::Material,
            PortType::Gstreamer => ChannelProtocol::Gst,
        }
    }
}

impl From<(PortId, PortMetadata)> for Port {
    fn from((id, metadata): (PortId, PortMetadata)) -> Self {
        Port {
            name: id.to_string(),
            protocol: metadata.port_type.into(),
            ..Default::default()
        }
    }
}
