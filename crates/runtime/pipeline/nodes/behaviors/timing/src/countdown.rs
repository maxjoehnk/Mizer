use std::time::{Duration, Instant};

use serde::{Deserialize, Serialize};

use mizer_node::*;

const START_INPUT: &str = "Start";
const STOP_INPUT: &str = "Stop";

const ACTIVE_OUTPUT: &str = "Active";
const FINISHED_OUTPUT: &str = "Finished";

const SECONDS_SETTING: &str = "Seconds";
const MINUTES_SETTING: &str = "Minutes";
const HOURS_SETTING: &str = "Hours";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct CountdownNode {
    pub seconds: u64,
    pub minutes: u64,
    pub hours: u64,
}

impl Default for CountdownNode {
    fn default() -> Self {
        Self {
            seconds: 0,
            minutes: 1,
            hours: 0,
        }
    }
}

impl ConfigurableNode for CountdownNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(SECONDS_SETTING, self.seconds as u32)
                .min(0u32)
                .max_hint(60u32),
            setting!(MINUTES_SETTING, self.minutes as u32)
                .min(0u32)
                .max_hint(60u32),
            setting!(HOURS_SETTING, self.hours as u32)
                .min(0u32)
                .max_hint(24u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(uint setting, SECONDS_SETTING, self.seconds);
        update!(uint setting, MINUTES_SETTING, self.minutes);
        update!(uint setting, HOURS_SETTING, self.hours);

        update_fallback!(setting)
    }
}

impl PipelineNode for CountdownNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Countdown".into(),
            preview_type: PreviewType::Timecode,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(START_INPUT, PortType::Single),
            input_port!(STOP_INPUT, PortType::Single),
            output_port!(ACTIVE_OUTPUT, PortType::Single),
            output_port!(FINISHED_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Countdown
    }
}

impl ProcessingNode for CountdownNode {
    type State = Option<Instant>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(true) = context.single_input(START_INPUT).is_high() {
            self.start_timer(state);
        }
        if let Some(true) = context.single_input(STOP_INPUT).is_high() {
            self.stop_timer(state);
        }

        if let Some(start) = state {
            let elapsed = start.elapsed();
            let duration = self.duration();
            if elapsed >= duration {
                self.stop_timer(state);
                context.write_port(FINISHED_OUTPUT, SINGLE_HIGH);
                context.write_port(ACTIVE_OUTPUT, SINGLE_LOW);
            } else {
                context.write_port(FINISHED_OUTPUT, SINGLE_LOW);
                context.write_port(ACTIVE_OUTPUT, SINGLE_HIGH);
            }
        } else {
            context.write_port(ACTIVE_OUTPUT, SINGLE_LOW);
            context.write_port(FINISHED_OUTPUT, SINGLE_LOW);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl CountdownNode {
    fn duration(&self) -> Duration {
        Duration::from_secs(self.seconds + self.minutes * 60 + self.hours * 60 * 60)
    }

    fn start_timer(&self, state: &mut Option<Instant>) {
        *state = Some(Instant::now());
    }

    fn stop_timer(&self, state: &mut Option<Instant>) {
        *state = None;
    }
}
