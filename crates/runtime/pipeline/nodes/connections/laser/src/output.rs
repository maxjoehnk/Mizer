use anyhow::Context;
use serde::{Deserialize, Serialize};
use mizer_connections::{ConnectionId, ConnectionStorage, Name, StableConnectionId, Either};
pub use mizer_node::*;
use mizer_protocol_laser::{EtherDreamLaser, HeliosLaser, Laser, LaserFrame};

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
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let device_manager = injector.inject::<ConnectionStorage>();
        let devices = device_manager
            .fetch::<(ConnectionId, Name, Either<HeliosLaser, EtherDreamLaser>)>()
            .into_iter()
            .map(|(id, name)| SelectVariant::Item {
                value: id.to_stable().to_string().into(),
                label: name.clone().into(),
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
            node_type_name: "Laser Output".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Laser,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
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
            tracing::trace!("LaserNode got frames: {:?}", frames);
            state.frames = frames;
            state.current_frame = 0;
        }
        if self.device_id.is_empty() {
            return Ok(());
        };
        let connection_storage = context.inject::<ConnectionStorage>();
        let stable_id = self.device_id.parse::<StableConnectionId>().context("Error parsing laser device id")?;
        let mut laser: Option<Box<&mut dyn Laser>> = None;
        anyhow::bail!("TODO: request mutable access to connection storage in node processing");

        // if let Some(helios) = connection_storage.get_connection_by_stable_mut::<HeliosLaser>(&stable_id) {
        //     laser = Some(Box::new(helios));
        // }
        // if let Some(ether_dream) = connection_storage.get_connection_by_stable_mut::<EtherDreamLaser>(&stable_id) {
        //     laser = Some(Box::new(ether_dream));
        // }
        // if let Some(mut laser) = laser {
        //     if state.current_frame >= state.frames.len() {
        //         state.current_frame = 0;
        //     }
        //     let frame = &state.frames[state.current_frame];
        //     laser
        //         .write_frame(frame.clone())
        //         .context("Error writing frame to laser dac")?;
        //     state.current_frame += 1;
        // }
        // Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
