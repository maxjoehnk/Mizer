use anyhow::Context;
use serde::{Deserialize, Serialize};

use mizer_devices::DeviceManager;
pub use mizer_node::*;
use mizer_protocol_laser::{Laser, LaserFrame};

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct LaserNode {
    #[serde(rename = "device")]
    pub device_id: String,
}

#[derive(Debug, Clone, Default)]
pub struct LaserState {
    current_frame: usize,
    frames: Vec<LaserFrame>,
}

impl PipelineNode for LaserNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "LaserNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "input".into(),
            PortMetadata {
                port_type: PortType::Laser,
                direction: PortDirection::Input,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Laser
    }
}

impl ProcessingNode for LaserNode {
    type State = LaserState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(frames) = context.read_port::<_, Vec<LaserFrame>>("input") {
            log::trace!("LaserNode got frames: {:?}", frames);
            state.frames = frames;
            state.current_frame = 0;
        }
        if let Some(device_manager) = context.inject::<DeviceManager>() {
            if let Some(mut laser) = device_manager.get_laser_mut(&self.device_id) {
                if state.current_frame >= state.frames.len() {
                    state.current_frame = 0;
                }
                let frame = &state.frames[state.current_frame];
                laser
                    .write_frame(frame.clone())
                    .context("Error writing frame to laser dac")?;
                state.current_frame += 1;
            }
        } else {
            log::warn!("Laser node is missing DeviceManager");
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.device_id = config.device_id.clone();
    }
}
