use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_laser::ilda::IldaMediaReader;
use mizer_protocol_laser::LaserFrame;

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct IldaFileNode {
    pub file: String,
}

#[derive(Default)]
pub struct IldaFileState {
    frames: Option<Vec<LaserFrame>>,
}

impl PipelineNode for IldaFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(IldaFileNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!("frames", PortType::Laser)]
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

    fn update(&mut self, config: &Self) {
        self.file = config.file.clone();
    }
}
