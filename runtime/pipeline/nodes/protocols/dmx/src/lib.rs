use mizer_node::*;
use mizer_protocol_dmx::DmxConnectionManager;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct DmxOutputNode {
    #[serde(default = "default_universe")]
    pub universe: u16,
    pub channel: u8,
}

impl Default for DmxOutputNode {
    fn default() -> Self {
        Self {
            universe: default_universe(),
            channel: 0,
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

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        (port == "value").then(|| PortMetadata {
            port_type: PortType::Single,
            direction: PortDirection::Input,
            ..Default::default()
        })
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
        let output = context
            .inject::<DmxConnectionManager>()
            // TODO: add output configuration
            .and_then(|connection| connection.get_output("output"));
        if output.is_none() {
            anyhow::bail!("Missing dmx output {}", "output");
        }
        let output = output.unwrap();

        if let Some(value) = value {
            context.push_history_value(value);
            let value = (value * u8::MAX as f64).min(255.).max(0.).floor() as u8;
            output.write_single(self.universe, self.channel, value);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
