use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_dmx::{DmxConnectionManager, DmxInput};

const OUTPUT_PORT: &str = "Output";

const CONNECTION_SETTING: &str = "Connection";
const UNIVERSE_SETTING: &str = "Universe";
const CHANNEL_SETTING: &str = "Channel";

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct DmxInputNode {
    pub input: String,
    #[serde(default = "default_universe")]
    pub universe: u16,
    pub channel: u16,
}

impl Default for DmxInputNode {
    fn default() -> Self {
        Self {
            universe: default_universe(),
            channel: 1,
            input: Default::default(),
        }
    }
}

fn default_universe() -> u16 {
    1
}

impl ConfigurableNode for DmxInputNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let dmx_connections = injector.get::<DmxConnectionManager>().unwrap();
        let inputs = dmx_connections
            .list_inputs()
            .into_iter()
            .map(|(id, connection)| SelectVariant::Item {
                value: id.clone().into(),
                label: connection.name().into(),
            })
            .collect::<Vec<_>>();
        vec![
            setting!(select CONNECTION_SETTING, &self.input, inputs),
            setting!(UNIVERSE_SETTING, self.universe as u32)
                .min(1u32)
                .max(32768u32),
            setting!(CHANNEL_SETTING, self.channel as u32)
                .min(1u32)
                .max(512u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, CONNECTION_SETTING, self.input);
        update!(uint setting, UNIVERSE_SETTING, self.universe);
        update!(uint setting, CHANNEL_SETTING, self.channel);

        update_fallback!(setting)
    }
}

impl PipelineNode for DmxInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "DMX Input".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::DmxInput
    }
}

impl ProcessingNode for DmxInputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let dmx_connections = context.try_inject::<DmxConnectionManager>();
        if dmx_connections.is_none() {
            anyhow::bail!("Missing dmx module");
        }
        let dmx_connections = dmx_connections.unwrap();
        if let Some(value) = dmx_connections
            .get_input(&self.input)
            .and_then(|input| input.read_single(self.universe, self.channel))
        {
            let value = value as f64 / 255.0;
            context.push_history_value(value);
            context.write_port(OUTPUT_PORT, value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
