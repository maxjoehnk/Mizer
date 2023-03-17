use serde::{Deserialize, Serialize};

use mizer_clock::*;
use mizer_node::*;

#[derive(Clone, Deserialize, Serialize, PartialEq)]
pub struct ClockNode {
    /// BPM
    pub speed: f64,
}

impl std::fmt::Debug for ClockNode {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct("ClockNode")
            .field("speed", &format!("{} BPM", &self.speed))
            .finish()
    }
}

impl Default for ClockNode {
    fn default() -> Self {
        ClockNode { speed: 90. }
    }
}

impl PipelineNode for ClockNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "ClockNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::Clock
    }
}

impl ProcessingNode for ClockNode {
    type State = SystemClock;

    fn process(&self, _: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let speed = state.speed_mut();
        *speed = self.speed;
        state.tick();
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        let mut clock = SystemClock::default();
        *clock.speed_mut() = self.speed;

        clock
    }

    fn update(&mut self, config: &Self) {
        self.speed = config.speed;
    }

    fn debug_ui(&self, ui: &mut DebugUiDrawHandle, state: &Self::State) {
        ui.collapsing_header("Config", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("BPM");
                columns[1].label(self.speed.to_string());
            });
        });
        ui.collapsing_header("State", |ui| {
            ui.columns(2, |columns| {
                columns[0].label("Speed");
                columns[1].label(state.speed().to_string());

                let snapshot = state.snapshot();
                columns[0].label("Timecode");
                columns[1].label(snapshot.time.to_string());
            });
        });
    }
}
