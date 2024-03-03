use serde::{Deserialize, Serialize};

use mizer_devices::DeviceManager;
use mizer_node::*;

use crate::get_cdjs;

const BPM_OUTPUT: &str = "Tempo";

const SOURCE_SETTING: &str = "Source";

const MASTER_ID: &str = "master";

#[derive(Default, Debug, Clone, Deserialize, Serialize, Eq, PartialEq)]
pub enum ClockSource {
    #[default]
    Master,
    Device(String),
}

impl TryFrom<String> for ClockSource {
    type Error = anyhow::Error;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        match value.as_str() {
            MASTER_ID => Ok(ClockSource::Master),
            _ => Ok(ClockSource::Device(value)),
        }
    }
}

#[derive(Clone, Default, Debug, Deserialize, Serialize, Eq, PartialEq)]
pub struct ProDjLinkClockNode {
    pub source: ClockSource,
}

impl ConfigurableNode for ProDjLinkClockNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let device_manager = injector.get::<DeviceManager>().unwrap();
        let sources = get_cdjs(device_manager);
        let current_source = match self.source {
            ClockSource::Master => MASTER_ID.to_string(),
            ClockSource::Device(ref id) => id.clone(),
        };

        vec![setting!(select SOURCE_SETTING, current_source, sources)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, SOURCE_SETTING, self.source);

        update_fallback!(setting)
    }
}

impl PipelineNode for ProDjLinkClockNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Pro DJ Link Clock".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(BPM_OUTPUT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ProDjLinkClock
    }
}

impl ProcessingNode for ProDjLinkClockNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let device_manager = context.try_inject::<DeviceManager>().unwrap();
        let speed = match &self.source {
            ClockSource::Master => None,
            ClockSource::Device(id) => {
                let cdj = device_manager
                    .get_cdj(id)
                    .ok_or_else(|| anyhow::anyhow!("No such device {id}"))?;
                Some(cdj.current_bpm())
            }
        };
        if let Some(speed) = speed {
            context.write_port(BPM_OUTPUT, speed);
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
