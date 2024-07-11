use serde::{Deserialize, Serialize};

use mizer_node::*;

const VALUE_PORT: &str = "Value";

const VALUE_SETTING: &str = "Value";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct ConstantNumberNode {
    pub value: f64,
}

impl ConfigurableNode for ConstantNumberNode {
    fn settings(&self, _injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        vec![setting!(VALUE_SETTING, self.value)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, VALUE_SETTING, self.value);

        update_fallback!(setting)
    }
}

impl PipelineNode for ConstantNumberNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Constant Number".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_PORT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::ConstantNumber
    }
}

impl ProcessingNode for ConstantNumberNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let value = self.value;

        context.write_port(VALUE_PORT, value);
        context.push_history_value(value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
