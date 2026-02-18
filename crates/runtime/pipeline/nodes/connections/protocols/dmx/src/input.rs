use mizer_connections::ConnectionStorage;
use mizer_node::*;
use mizer_protocol_dmx::{ArtnetInput, DmxInput};
use serde::{Deserialize, Serialize};

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
    fn settings(&self, injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        let connection_storage = injector.try_inject::<ConnectionStorage>().unwrap();
        let inputs = connection_storage
            .query::<ArtnetInput>()
            .into_iter()
            .map(|(id, name, connection)| SelectVariant::Item {
                value: id.to_stable().to_string().into(),
                label: name
                    .cloned()
                    .unwrap_or_else(|| connection.config.name.clone().into()),
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

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(OUTPUT_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::DmxInput
    }
}

impl ProcessingNode for DmxInputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let connection_storage = context.inject::<ConnectionStorage>();
        if self.input.is_empty() {
            return Ok(());
        }
        let id = self.input.parse()?;
        if let Some(value) = connection_storage
            .get_connection_by_stable::<ArtnetInput>(&id)
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
