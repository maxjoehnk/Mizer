use crate::protos::NodesApi;
use crate::protos::{
    ChannelProtocol, Node, NodeConnection, Node_NodeType, Nodes, NodesRequest, Port,
};
use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};
use mizer_pipeline::{PipelineView, NodeType, NodeDesigner};
use protobuf::SingularPtrField;

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

        for (id, node) in &nodes {
            let mut node = Node {
                id: id.clone(),
                field_type: get_node_type(&node.node_type),
                title: id.clone(),
                designer: SingularPtrField::some(node.designer.clone().into()),
                // properties: project_node.properties.clone(),
                ..Default::default()
            };
            node.inputs.push(Port {
                protocol: ChannelProtocol::Dmx,
                name: "dmx".to_string(),
                ..Default::default()
            });
            node.inputs.push(Port {
                protocol: ChannelProtocol::Clock,
                name: "clock".to_string(),
                ..Default::default()
            });
            node.outputs.push(Port {
                protocol: ChannelProtocol::Numeric,
                name: "value".into(),
                ..Default::default()
            });
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
}

fn get_node_type(node: &NodeType) -> Node_NodeType {
    match &node {
        NodeType::Fader { .. } => Node_NodeType::Fader,
        NodeType::ConvertToDmx { .. } => Node_NodeType::ConvertToDmx,
        NodeType::ArtnetOutput { .. } => Node_NodeType::ArtnetOutput,
        NodeType::StreamingAcnOutput { .. } => Node_NodeType::SacnOutput,
        NodeType::Oscillator { .. } => Node_NodeType::Oscillator,
        NodeType::Clock { .. } => Node_NodeType::Clock,
        NodeType::OscInput { .. } => Node_NodeType::OscInput,
        NodeType::VideoFile { .. } => Node_NodeType::VideoFile,
        NodeType::VideoOutput { .. } => Node_NodeType::VideoOutput,
        NodeType::VideoEffect { .. } => Node_NodeType::VideoEffect,
        NodeType::VideoColorBalance { .. } => Node_NodeType::VideoColorBalance,
        NodeType::VideoTransform { .. } => Node_NodeType::VideoTransform,
        NodeType::Scripting { .. } => Node_NodeType::Script,
        NodeType::PixelOutput { .. } => Node_NodeType::PixelToDmx,
        NodeType::PixelPattern { .. } => Node_NodeType::PixelPattern,
        NodeType::OpcOutput { .. } => Node_NodeType::OpcOutput,
        NodeType::Fixture { .. } => Node_NodeType::Fixture,
        NodeType::Sequence { .. } => Node_NodeType::Sequence,
        NodeType::MidiInput { .. } => Node_NodeType::MidiInput,
        NodeType::MidiOutput { .. } => Node_NodeType::MidiOutput,
        NodeType::Laser { .. } => Node_NodeType::Laser,
        NodeType::Ilda { .. } => Node_NodeType::IldaFile,
    }
}

impl From<mizer_pipeline::NodeDesigner> for crate::protos::NodeDesigner {
    fn from(designer: NodeDesigner) -> Self {
        crate::protos::NodeDesigner {
            scale: designer.scale,
            x: designer.x,
            y: designer.y,
            ..Default::default()
        }
    }
}
