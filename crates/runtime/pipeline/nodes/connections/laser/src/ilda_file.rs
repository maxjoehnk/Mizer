use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_laser::ilda::IldaMediaReader;
use mizer_protocol_laser::LaserFrame;

const OUTPUT_PORT: &str = "Frames";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct IldaFileNode {
    pub file: String,
}

#[derive(Default)]
pub struct IldaFileState {
    frames: Option<Vec<LaserFrame>>,
}

impl ConfigurableNode for IldaFileNode {}

impl PipelineNode for IldaFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "ILDA File".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Laser,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Laser)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::IldaFile
    }
}

impl ProcessingNode for IldaFileNode {
    type State = IldaFileState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if state.frames.is_none() {
            tracing::debug!("reading laser frames from {}", &self.file);
            let mut reader = IldaMediaReader::open_file(&self.file)?;
            let frames = reader.read_frames()?;
            state.frames = Some(frames);
        }
        if let Some(frames) = &state.frames {
            // TODO: only write when new frames arrive or when a new listener is attached
            context.write_port(OUTPUT_PORT, frames.clone());
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
