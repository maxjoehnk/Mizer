use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};
use protobuf::SingularPtrField;

use mizer_pipeline::{NodeChannel, NodeDefinition, NodeDesigner, NodePortDefinition, NodeTemplate, NodeType, PipelineView};

use crate::protos::{AddNodeRequest, NodePosition, NodesApi};
use crate::protos::{
    ChannelProtocol, Node, Node_NodeType, NodeConnection, Nodes, NodesRequest, Port,
};

pub struct NodesApiImpl {
    pipeline_view: PipelineView
}

impl NodesApiImpl {
    pub fn new(pipeline_view: PipelineView) -> Self {
        NodesApiImpl { pipeline_view }
    }
}

impl NodesApi for NodesApiImpl {
    fn get_nodes(
        &self,
        _: ServerHandlerContext,
        req: ServerRequestSingle<NodesRequest>,
        resp: ServerResponseUnarySink<Nodes>,
    ) -> grpc::Result<()> {
        let mut res = Nodes::new();

        let nodes = self.pipeline_view.get_nodes();

        for (id, definition) in nodes {
            let node: Node = (id, definition).into();
            res.nodes.push(node);
        }
        for channel in self.pipeline_view.get_channels() {
            let mut conn = NodeConnection {
                inputNode: channel.from_id.clone(),
                outputNode: channel.to_id.clone(),
                ..Default::default()
            };
            let input_port = Port {
                protocol: ChannelProtocol::Dmx,
                name: channel.from_channel.clone(),
                ..Default::default()
            };
            conn.set_inputPort(input_port);
            let output_port = Port {
                protocol: ChannelProtocol::Dmx,
                name: channel.to_channel.clone(),
                ..Default::default()
            };
            conn.set_outputPort(output_port);
            res.channels.push(conn);
        }
        resp.finish(res)
    }

    fn add_node(&self, _: ServerHandlerContext, req: ServerRequestSingle<AddNodeRequest>, resp: ServerResponseUnarySink<Node>) -> grpc::Result<()> {
        let node = self.pipeline_view.add_node(req.message).unwrap();

        resp.finish(node.into())
    }
}

impl From<&NodeType> for Node_NodeType {
    fn from(node: &NodeType) -> Self {
        match *node {
            NodeType::Fader => Node_NodeType::Fader,
            NodeType::ConvertToDmx => Node_NodeType::ConvertToDmx,
            NodeType::ArtnetOutput => Node_NodeType::ArtnetOutput,
            NodeType::StreamingAcnOutput => Node_NodeType::SacnOutput,
            NodeType::Oscillator => Node_NodeType::Oscillator,
            NodeType::Clock => Node_NodeType::Clock,
            NodeType::OscInput => Node_NodeType::OscInput,
            NodeType::VideoFile => Node_NodeType::VideoFile,
            NodeType::VideoOutput => Node_NodeType::VideoOutput,
            NodeType::VideoEffect => Node_NodeType::VideoEffect,
            NodeType::VideoColorBalance => Node_NodeType::VideoColorBalance,
            NodeType::VideoTransform => Node_NodeType::VideoTransform,
            NodeType::Scripting => Node_NodeType::Script,
            NodeType::PixelOutput => Node_NodeType::PixelToDmx,
            NodeType::PixelPattern => Node_NodeType::PixelPattern,
            NodeType::OpcOutput => Node_NodeType::OpcOutput,
            NodeType::Fixture => Node_NodeType::Fixture,
            NodeType::Sequence => Node_NodeType::Sequence,
            NodeType::MidiInput => Node_NodeType::MidiInput,
            NodeType::MidiOutput => Node_NodeType::MidiOutput,
            NodeType::Laser => Node_NodeType::Laser,
            NodeType::Ilda => Node_NodeType::IldaFile,
        }
    }
}

impl From<Node_NodeType> for NodeType {
    fn from(node: Node_NodeType) -> Self {
        match node {
            Node_NodeType::Fader => NodeType::Fader,
            Node_NodeType::ConvertToDmx => NodeType::ConvertToDmx,
            Node_NodeType::ArtnetOutput => NodeType::ArtnetOutput,
            Node_NodeType::SacnOutput => NodeType::StreamingAcnOutput,
            Node_NodeType::Oscillator => NodeType::Oscillator,
            Node_NodeType::Clock => NodeType::Clock,
            Node_NodeType::OscInput => NodeType::OscInput,
            Node_NodeType::VideoFile => NodeType::VideoFile,
            Node_NodeType::VideoOutput => NodeType::VideoOutput,
            Node_NodeType::VideoEffect => NodeType::VideoEffect,
            Node_NodeType::VideoColorBalance => NodeType::VideoColorBalance,
            Node_NodeType::VideoTransform => NodeType::VideoTransform,
            Node_NodeType::Script => NodeType::Scripting,
            Node_NodeType::PixelToDmx => NodeType::PixelOutput,
            Node_NodeType::PixelPattern => NodeType::PixelPattern,
            Node_NodeType::OpcOutput => NodeType::OpcOutput,
            Node_NodeType::Fixture => NodeType::Fixture,
            Node_NodeType::Sequence => NodeType::Sequence,
            Node_NodeType::MidiInput => NodeType::MidiInput,
            Node_NodeType::MidiOutput => NodeType::MidiOutput,
            Node_NodeType::Laser => NodeType::Laser,
            Node_NodeType::IldaFile => NodeType::Ilda,
        }
    }
}

impl From<AddNodeRequest> for NodeTemplate {
    fn from(req: AddNodeRequest) -> Self {
        let position = req.position.unwrap();
        NodeTemplate {
            designer: NodeDesigner {
                x: position.x,
                y: position.y,
                scale: 1.
            },
            node_type: req.field_type.into()
        }
    }
}

impl From<(String, NodeDefinition)> for Node {
    fn from((id, definition): (String, NodeDefinition)) -> Self {
        let mut node = Node {
            id: id.clone(),
            title: id.clone(),
            field_type: (&definition.node_type).into(),
            designer: SingularPtrField::some(definition.designer.clone().into()),
            ..Default::default()
        };
        for input in definition.inputs {
            node.inputs.push(input.into());
        }
        for output in definition.outputs {
            node.outputs.push(output.into());
        }

        println!("{:?}", node);

        node
    }
}

impl From<mizer_pipeline::NodeDesigner> for crate::protos::NodeDesigner {
    fn from(designer: NodeDesigner) -> Self {
        crate::protos::NodeDesigner {
            scale: designer.scale,
            position: SingularPtrField::some(NodePosition {
                x: designer.x,
                y: designer.y,
                ..Default::default()
            }),
            ..Default::default()
        }
    }
}

impl From<NodePortDefinition> for Port {
    fn from(port: NodePortDefinition) -> Self {
        Port {
            name: port.name,
            protocol: port.channel.into(),
            ..Default::default()
        }
    }
}

impl From<NodeChannel> for ChannelProtocol {
    fn from(channel: NodeChannel) -> Self {
        match channel {
            NodeChannel::Dmx => ChannelProtocol::Dmx,
            NodeChannel::Numeric => ChannelProtocol::Numeric,
            NodeChannel::Trigger => ChannelProtocol::Trigger,
            NodeChannel::Clock => ChannelProtocol::Clock,
            NodeChannel::Video => ChannelProtocol::Video,
            NodeChannel::Color => ChannelProtocol::Color,
            NodeChannel::Vector => ChannelProtocol::Vector,
            NodeChannel::Text => ChannelProtocol::Text,
            NodeChannel::Midi => ChannelProtocol::Midi,
            NodeChannel::Timecode => ChannelProtocol::Timecode,
            NodeChannel::Boolean => ChannelProtocol::Boolean,
            NodeChannel::Select => ChannelProtocol::Select,
            NodeChannel::Pixels => ChannelProtocol::Pixels,
            NodeChannel::Laser => ChannelProtocol::Laser,
        }
    }
}
