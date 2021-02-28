use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_laser::ilda::IldaMediaReader;
use mizer_protocol_laser::LaserFrame;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct IldaFileNode {
    file: String,
}

#[derive(Default)]
pub struct IldaFileState {
    frames: Option<Vec<LaserFrame>>,
}

impl PipelineNode for IldaFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "IldaFileNode".into(),
        }
    }

    fn introspect_port(&self, port: &PortId) -> PortMetadata {
        PortMetadata {
            port_type: PortType::Laser,
            ..Default::default()
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::IldaFile
    }
}

impl ProcessingNode for IldaFileNode {
    type State = IldaFileState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if state.frames.is_none() {
            log::debug!("reading laser frames from {}", &self.file);
            let mut reader = IldaMediaReader::open_file(&self.file)?;
            let frames = reader.read_frames()?;
            state.frames = Some(frames);
        }
        if let Some(frames) = &state.frames {
            // TODO: only write when new frames arrive or when a new listener is attached
            context.write_port("frames", frames.clone());
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
