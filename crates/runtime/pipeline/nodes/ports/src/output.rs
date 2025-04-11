use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_node_ports::{NodePortId, NodePortState};

const VALUE_OUTPUT: &str = "Value";

const PORT_ID_SETTING: &str = "Port";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct PortOutputNode {
    pub port_id: NodePortId,
}

impl ConfigurableNode for PortOutputNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let manager = injector.get::<NodePortState>().unwrap();
        let controls = manager
            .list_ports()
            .into_iter()
            .map(|port| IdVariant {
                value: port.id.0,
                label: port.label.clone().to_string(),
            })
            .collect();

        vec![setting!(id PORT_ID_SETTING, self.port_id.0, controls)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, PORT_ID_SETTING, self.port_id, |id| NodePortId(id));

        update_fallback!(setting)
    }
}

impl PipelineNode for PortOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Port Output".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn display_name(&self, injector: &Injector) -> String {
        if self.port_id.0 == 0 {
            return "Port Output".to_string();
        }
        if let Some(control) = injector
            .get::<NodePortState>()
            .and_then(|port_state| port_state.get_port(&self.port_id))
        {
            format!("Port Output ({})", control.label)
        } else {
            "Port Output".to_string()
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_OUTPUT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::PortOutput
    }
}

impl ProcessingNode for PortOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let ports_state = context
            .try_inject::<NodePortState>()
            .ok_or_else(|| anyhow::anyhow!("Missing Ports Module"))?;
        if self.port_id.is_default() {
            return Ok(());
        }
        if let Some(value) = ports_state.read_value(self.port_id) {
            context.write_port(VALUE_OUTPUT, value);
            context.push_history_value(value);
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
