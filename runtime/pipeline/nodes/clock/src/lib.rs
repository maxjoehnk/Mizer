use serde::{Deserialize, Serialize};

use mizer_clock::*;
use mizer_node::*;

#[derive(Clone, Deserialize, Serialize, PartialEq)]
pub struct ClockNode {
    /// BPM
    speed: f64,
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
        ClockNode {
            speed: 90.
        }
    }
}

impl PipelineNode for ClockNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "ClockNode".into()
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
}
