use anyhow::Context;
use serde::{Deserialize, Serialize};

use mizer_devices::{DeviceManager, DeviceRef};
pub use mizer_node::*;
use mizer_protocol_laser::{Laser, LaserFrame};

const INPUT_PORT: &str = "Frames";

const DEVICE_SETTING: &str = "Device";

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

impl ConfigurableNode for LaserNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let device_manager = injector.get::<DeviceManager>().unwrap();
        let devices = device_manager
            .current_devices()
            .into_iter()
            .filter_map(|device| match device {
                DeviceRef::EtherDream(ether_dream) => Some(SelectVariant::from(ether_dream.name)),
                DeviceRef::Helios(helios) => Some(SelectVariant::from(helios.name)),
                _ => None,
            })
            .collect();

        vec![setting!(select DEVICE_SETTING, &self.device_id, devices)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for LaserNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(LaserNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(INPUT_PORT, PortType::Laser)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Laser
    }
}

impl ProcessingNode for LaserNode {
    type State = LaserState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(frames) = context.read_port::<_, Vec<LaserFrame>>(INPUT_PORT) {
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
}
