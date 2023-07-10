use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_dmx::{DmxConnectionManager, DmxOutput};

const INPUT_PORT: &str = "Input";

const UNIVERSE_SETTING: &str = "Universe";
const CHANNEL_SETTING: &str = "Channel";

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct DmxOutputNode {
    #[serde(default = "default_universe")]
    pub universe: u16,
    pub channel: u16,
    pub output: Option<String>,
}

impl Default for DmxOutputNode {
    fn default() -> Self {
        Self {
            universe: default_universe(),
            channel: 0,
            output: None,
        }
    }
}

fn default_universe() -> u16 {
    1
}

impl ConfigurableNode for DmxOutputNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(UNIVERSE_SETTING, self.universe as u32)
                .min(1u32)
                .max(32768u32),
            setting!(CHANNEL_SETTING, self.channel as u32)
                .min(1u32)
                .max(512u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(int setting, UNIVERSE_SETTING, self.universe);
        update!(int setting, CHANNEL_SETTING, self.channel);

        update_fallback!(setting)
    }
}

impl PipelineNode for DmxOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "DMX Output".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(INPUT_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::DmxOutput
    }
}

impl ProcessingNode for DmxOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let value = context.read_port::<_, f64>(INPUT_PORT);
        let dmx_connections = context.inject::<DmxConnectionManager>();
        if dmx_connections.is_none() {
            anyhow::bail!("Missing dmx module");
        }
        let dmx_connections = dmx_connections.unwrap();

        if let Some(value) = value {
            context.push_history_value(value);
            let value = (value * u8::MAX as f64).min(255.).max(0.).floor() as u8;

            if let Some(output) = self
                .output
                .as_ref()
                .and_then(|output| dmx_connections.get_output(output))
            {
                output.write_single(self.universe, self.channel, value);
            } else {
                for (_, output) in dmx_connections.list_outputs() {
                    output.write_single(self.universe, self.channel, value);
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
