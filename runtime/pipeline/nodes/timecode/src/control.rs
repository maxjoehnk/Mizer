use serde::{Deserialize, Serialize};

use mizer_node::edge::Edge;
use mizer_node::*;
use mizer_timecode::{TimecodeId, TimecodeManager};

const TIMECODE_INPUT: &str = "Clock";
const PLAYBACK_INPUT: &str = "Playback";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct TimecodeControlNode {
    pub timecode_id: TimecodeId,
}

impl PipelineNode for TimecodeControlNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(TimecodeControlNode).into(),
            preview_type: PreviewType::Timecode,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(TIMECODE_INPUT, PortType::Clock),
            input_port!(PLAYBACK_INPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TimecodeControl
    }
}

impl ProcessingNode for TimecodeControlNode {
    type State = Edge;

    fn process(
        &self,
        context: &impl NodeContext,
        playback_edge: &mut Self::State,
    ) -> anyhow::Result<()> {
        let manager = context
            .inject::<TimecodeManager>()
            .ok_or_else(|| anyhow::anyhow!("Missing Timecode Module"))?;
        if let Some(value) = context.read_port::<_, u64>(TIMECODE_INPUT) {
            manager.write_timestamp(self.timecode_id, value);
        }
        if let Some(playback) = context
            .read_port(PLAYBACK_INPUT)
            .and_then(|value| playback_edge.update(value))
        {
            if playback {
                manager.start_timecode_track(self.timecode_id, context.clock());
            } else {
                manager.stop_timecode_track(self.timecode_id);
            }
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.timecode_id = config.timecode_id;
    }
}
