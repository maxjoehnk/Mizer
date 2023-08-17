use serde::{Deserialize, Serialize};

use mizer_devices::{DeviceManager, DeviceRef};
use mizer_node::*;

const ORIGINAL_TEMPO_OUTPUT: &str = "Original Tempo";
const CURRENT_TEMPO_OUTPUT: &str = "Current Tempo";
const PITCH_OUTPUT: &str = "Pitch";
const PLAYING_OUTPUT: &str = "Playing";
const LIVE_OUTPUT: &str = "Live";

const DEVICE_SETTING: &str = "Player Number";

#[derive(Clone, Default, Debug, Deserialize, Serialize, Eq, PartialEq)]
pub struct PioneerCdjNode {
    pub device_id: u32,
}

impl ConfigurableNode for PioneerCdjNode {
    fn settings(&self, _: &Injector) -> Vec<NodeSetting> {
        let devices = vec![
            IdVariant {
                label: "1".into(),
                value: 1,
            },
            IdVariant {
                label: "2".into(),
                value: 2,
            },
            IdVariant {
                label: "3".into(),
                value: 3,
            },
            IdVariant {
                label: "4".into(),
                value: 4,
            },
        ];

        vec![setting!(id DEVICE_SETTING, self.device_id, devices)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, DEVICE_SETTING, self.device_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for PioneerCdjNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Pioneer CDJ".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            output_port!(ORIGINAL_TEMPO_OUTPUT, PortType::Single),
            output_port!(CURRENT_TEMPO_OUTPUT, PortType::Single),
            output_port!(PITCH_OUTPUT, PortType::Single),
            output_port!(PLAYING_OUTPUT, PortType::Single),
            output_port!(LIVE_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::PioneerCdj
    }
}

impl ProcessingNode for PioneerCdjNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let device_manager = context.inject::<DeviceManager>().unwrap();
        let cdj = device_manager
            .current_devices()
            .into_iter()
            .find_map(|device| {
                if let DeviceRef::PioneerCDJ(cdj) = device {
                    if cdj.device.device_id as u32 == self.device_id {
                        Some(cdj)
                    } else {
                        None
                    }
                } else {
                    None
                }
            });

        if let Some(cdj) = cdj {
            context.write_port(CURRENT_TEMPO_OUTPUT, cdj.current_bpm());
            context.write_port(ORIGINAL_TEMPO_OUTPUT, cdj.original_bpm() as f64);
            context.write_port(PITCH_OUTPUT, cdj.pitch() as f64);
            context.write_port(PLAYING_OUTPUT, if cdj.is_playing() { 1f64 } else { 0f64 });
            context.write_port(LIVE_OUTPUT, if cdj.is_live() { 1f64 } else { 0f64 });
        } else {
            log::trace!("No CDJ found with player number {}", self.device_id)
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
