use serde::{Deserialize, Serialize};

use mizer_node::edge::Edge;
use mizer_node::*;
use mizer_timecode::{TimecodeId, TimecodeManager};

const TIMECODE_INPUT: &str = "Clock";
const PLAYBACK_INPUT: &str = "Playback";
const RECORDING_INPUT: &str = "Recording";

const TIMECODE_ID_SETTING: &str = "Timecode";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct TimecodeControlNode {
    pub timecode_id: TimecodeId,
}

impl ConfigurableNode for TimecodeControlNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let manager = injector.get::<TimecodeManager>().unwrap();
        let timecodes = manager
            .timecodes()
            .into_iter()
            .map(|timecode| IdVariant {
                value: timecode.id.into(),
                label: timecode.name,
            })
            .collect();

        vec![setting!(id TIMECODE_ID_SETTING, self.timecode_id, timecodes)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, TIMECODE_ID_SETTING, self.timecode_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for TimecodeControlNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Timecode Control".into(),
            preview_type: PreviewType::Timecode,
            category: NodeCategory::Standard,
        }
    }

    fn display_name(&self, injector: &Injector) -> String {
        if let Some(timecode) = injector
            .get::<TimecodeManager>()
            .and_then(|timecode_manager| {
                timecode_manager
                    .timecodes()
                    .into_iter()
                    .find(|timecode| timecode.id == self.timecode_id)
            })
        {
            format!("Timecode Control ({})", timecode.name)
        } else {
            format!("Timecode Control (ID {})", self.timecode_id)
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(TIMECODE_INPUT, PortType::Clock),
            input_port!(PLAYBACK_INPUT, PortType::Single),
            input_port!(RECORDING_INPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TimecodeControl
    }
}

impl ProcessingNode for TimecodeControlNode {
    type State = TimecodeControlState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let manager = context
            .inject::<TimecodeManager>()
            .ok_or_else(|| anyhow::anyhow!("Missing Timecode Module"))?;
        if let Some(value) = context.read_port_changes::<_, port_types::CLOCK>(TIMECODE_INPUT) {
            if let Some(state) = manager.get_state_access(self.timecode_id) {
                if state.is_playing() {
                    manager.write_timestamp(self.timecode_id, value);
                }
            }
        }
        if let Some(playback) = context
            .read_port(PLAYBACK_INPUT)
            .and_then(|value| state.playback_edge.update(value))
        {
            if playback {
                manager.start_timecode_track(self.timecode_id);
            } else {
                manager.stop_timecode_track(self.timecode_id);
            }
        }
        if let Some(recording) = context
            .read_port(RECORDING_INPUT)
            .and_then(|value| state.recording_edge.update(value))
        {
            if recording {
                manager.start_timecode_track_recording(self.timecode_id);
            } else {
                manager.stop_timecode_track_recording(self.timecode_id);
            }
        }
        if let Some(timecode) = manager
            .get_state_access(self.timecode_id)
            .and_then(|access| access.get_timecode())
        {
            context.write_timecode_preview(timecode);
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default)]
pub struct TimecodeControlState {
    playback_edge: Edge,
    recording_edge: Edge,
}
