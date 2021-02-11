use mizer_node_api::{ProcessingNode, NodeDetails, NodeOutput, NodeChannel, SourceNode, DestinationNode, ConnectionResult, ConnectionError, LaserChannel, LaserSender};
use mizer_protocol_laser::ilda::IldaMediaReader;
use mizer_protocol_laser::LaserFrame;

pub struct IldaNode {
    reader: IldaMediaReader,
    outputs: Vec<LaserSender>,
    frames: Option<Vec<LaserFrame>>,
}

impl IldaNode {
    pub fn new(path: &str) -> anyhow::Result<Self> {
        Ok(IldaNode {
            reader: IldaMediaReader::open_file(path)?,
            outputs: Default::default(),
            frames: Default::default(),
        })
    }
}

impl Default for IldaNode {
    fn default() -> Self {
        unimplemented!()
    }
}

impl ProcessingNode for IldaNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("IldaNode")
            .with_outputs(vec![NodeOutput::new("frames", NodeChannel::Laser)])
    }

    fn process(&mut self) {
        if self.frames.is_none() {
            let frames = self.reader.read_frames().unwrap();
            self.frames = Some(frames);
        }
        if let Some(ref frames) = self.frames {
            for output in self.outputs.iter() {
                output.send(frames.clone());
            }
        };
    }
}

impl SourceNode for IldaNode {
}

impl DestinationNode for IldaNode {
    fn connect_to_laser_input(
        &mut self,
        output: &str,
        node: &mut impl SourceNode,
        input: &str,
    ) -> ConnectionResult {
        if output == "frames" {
            let (sender, channel) = LaserChannel::new();
            node.connect_laser_input(input, channel)?;
            self.outputs.push(sender);
            Ok(())
        }else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}
