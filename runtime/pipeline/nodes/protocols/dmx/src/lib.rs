use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_dmx::DmxConnectionManager;

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct DmxOutputNode {
    #[serde(default = "default_universe")]
    pub universe: u16,
    pub channel: u8,
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

impl PipelineNode for DmxOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "DmxOutputNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "value".into(),
            PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Input,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::DmxOutput
    }
}

impl ProcessingNode for DmxOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let value = context.read_port::<_, f64>("value");
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
