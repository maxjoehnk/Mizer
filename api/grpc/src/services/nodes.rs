use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};
use protobuf::SingularPtrField;

use crate::protos::{AddNodeRequest, NodePosition, NodesApi};
use crate::protos::{
    ChannelProtocol, Node, NodeConnection, Node_NodeType, Nodes, NodesRequest, Port,
};
use mizer_node::{NodeDesigner, NodeType, PortType};
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
                inputNode: channel.source.to_string(),
                outputNode: channel.target.to_string(),
                ..Default::default()
            };
            let input_port = Port {
                protocol: ChannelProtocol::Single,
                name: channel.source_port.to_string(),
                ..Default::default()
            };
            conn.set_inputPort(input_port);
            let output_port = Port {
                protocol: ChannelProtocol::Single,
                name: channel.target_port.to_string(),
                ..Default::default()
            };
            conn.set_outputPort(output_port);
            res.channels.push(conn);
        }
        resp.finish(res)
    }

    fn add_node(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<AddNodeRequest>,
        _: ServerResponseUnarySink<Node>,
    ) -> grpc::Result<()> {
        todo!()
        // let node = self.pipeline_view.add_node(req.message).unwrap();
        //
        // resp.finish(node.into())
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

// impl From<AddNodeRequest> for NodeTemplate {
//     fn from(req: AddNodeRequest) -> Self {
//         let position = req.position.unwrap();
//         NodeTemplate {
//             designer: NodeDesigner {
//                 x: position.x,
//                 y: position.y,
//                 scale: 1.
//             },
//             node_type: req.field_type.into()
//         }
//     }
// }
//
impl From<NodeDescriptor<'_>> for Node {
    fn from(descriptor: NodeDescriptor<'_>) -> Self {
        let node_type = descriptor.node_type();
        let node = Node {
            path: descriptor.path.to_string(),
            field_type: node_type.into(),
            designer: SingularPtrField::some(descriptor.designer.into()),
            ..Default::default()
        };
        // for input in definition.inputs {
        //     node.inputs.push(input.into());
        // }
        // for output in definition.outputs {
        //     node.outputs.push(output.into());
        // }

        println!("{:?}", node);

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
