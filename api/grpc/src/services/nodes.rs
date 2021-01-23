use mizer_project_files::{Project, NodeConfig};
use crate::protos::NodesApi;
use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};
use mizer_proto::nodes::{NodesRequest, Nodes, Node, NodeConnection, Port, Node_NodeType, ChannelProtocol};

pub struct NodesApiImpl {
    projects: Vec<Project>
}

impl NodesApiImpl {
    pub fn new(projects: Vec<Project>) -> Self {
        NodesApiImpl {
            projects
        }
    }
}

impl NodesApi for NodesApiImpl {
    fn get_nodes(&self, _: ServerHandlerContext, req: ServerRequestSingle<NodesRequest>, resp: ServerResponseUnarySink<Nodes>) -> grpc::Result<()> {
        let mut res = Nodes::new();
        for project in &self.projects {
            for project_node in &project.nodes {
                let mut node = Node {
                    id: project_node.id.clone(),
                    field_type: get_node_type(&project_node),
                    title: project_node.id.clone(),
                    properties: project_node.properties.clone(),
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
            for channel in &project.channels {
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
        }
        resp.finish(res)
    }
}

fn get_node_type(node: &mizer_project_files::Node) -> Node_NodeType {
    match &node.config {
        NodeConfig::Fader { .. } => Node_NodeType::Fader,
        NodeConfig::ConvertToDmx { .. } => Node_NodeType::ConvertToDmx,
        NodeConfig::ArtnetOutput { .. } => Node_NodeType::ArtnetOutput,
        NodeConfig::SacnOutput { .. } => Node_NodeType::SacnOutput,
        NodeConfig::Oscillator { .. } => Node_NodeType::Oscillator,
        NodeConfig::Clock { .. } => Node_NodeType::Clock,
        NodeConfig::OscInput { .. } => Node_NodeType::OscInput,
        NodeConfig::VideoFile { .. } => Node_NodeType::VideoFile,
        NodeConfig::VideoOutput { .. } => Node_NodeType::VideoOutput,
        NodeConfig::VideoEffect { .. } => Node_NodeType::VideoEffect,
        NodeConfig::VideoColorBalance { .. } => Node_NodeType::VideoColorBalance,
        NodeConfig::VideoTransform { .. } => Node_NodeType::VideoTransform,
        NodeConfig::Script { .. } => Node_NodeType::Script,
        NodeConfig::PixelDmx { .. } => Node_NodeType::PixelToDmx,
        NodeConfig::PixelPattern { .. } => Node_NodeType::PixelPattern,
        NodeConfig::OpcOutput { .. } => Node_NodeType::OpcOutput,
        NodeConfig::Fixture { .. } => Node_NodeType::Fixture,
        NodeConfig::Sequence { .. } => Node_NodeType::Sequence,
    }
}
