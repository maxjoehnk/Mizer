use mizer_node::*;
use mizer_timecode::{TimecodeControlId, TimecodeManager};
use serde::{Deserialize, Serialize};

const VALUE_OUTPUT: &str = "Value";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct TimecodeOutputNode {
    pub control_id: TimecodeControlId,
}

impl PipelineNode for TimecodeOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(TimecodeOutputNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_OUTPUT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TimecodeOutput
    }
}

impl ProcessingNode for TimecodeOutputNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let timecode = context
            .inject::<TimecodeManager>()
            .ok_or_else(|| anyhow::anyhow!("Missing Timecode Module"))?;
        if let Some(value) = timecode.get_control_value(self.control_id) {
            context.write_port(VALUE_OUTPUT, value);
            context.push_history_value(value);
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.control_id = config.control_id;
    }
}
