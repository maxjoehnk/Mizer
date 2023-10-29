use std::str::FromStr;

use chrono::{DateTime, Duration, Utc};
use cron::Schedule;
use serde::{Deserialize, Serialize};

use mizer_clock::Timecode;
use mizer_node::*;

const MINUTE: u64 = 60;
const HOUR: u64 = 60 * MINUTE;

const VALUE_OUTPUT: &str = "Value";

const SECOND_SETTING: &str = "Second";
const MINUTE_SETTING: &str = "Minute";
const HOUR_SETTING: &str = "Hour";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct TimeTriggerNode {
    pub seconds: u64,
    pub minutes: u64,
    pub hours: u64,
}

impl Default for TimeTriggerNode {
    fn default() -> Self {
        Self {
            seconds: 0,
            minutes: 0,
            hours: 12,
        }
    }
}

impl ConfigurableNode for TimeTriggerNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(SECOND_SETTING, self.seconds as u32)
                .min(0u32)
                .max(60u32),
            setting!(MINUTE_SETTING, self.minutes as u32)
                .min(0u32)
                .max(60u32),
            setting!(HOUR_SETTING, self.hours as u32)
                .min(0u32)
                .max(24u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(uint setting, SECOND_SETTING, self.seconds);
        update!(uint setting, MINUTE_SETTING, self.minutes);
        update!(uint setting, HOUR_SETTING, self.hours);

        update_fallback!(setting)
    }
}

impl PipelineNode for TimeTriggerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Time Trigger".into(),
            preview_type: PreviewType::Timecode,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_OUTPUT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::TimeTrigger
    }
}

impl ProcessingNode for TimeTriggerNode {
    type State = DateTime<Utc>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let schedule = self.get_schedule();
        let next_time = schedule.after(state).next();
        *state = self.now();
        if let Some(next_time) = next_time {
            let duration = next_time.signed_duration_since(state);
            let timecode = Self::to_timecode(duration);

            let has_passed = duration <= Duration::zero();

            context.write_port(
                VALUE_OUTPUT,
                if has_passed { SINGLE_HIGH } else { SINGLE_LOW },
            );
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        self.now()
    }
}

impl TimeTriggerNode {
    fn get_schedule(&self) -> Schedule {
        let expression = format!(
            "{} {} {} * * * *",
            self.seconds,
            self.minutes,
            self.hours - 1
        );
        Schedule::from_str(&expression).unwrap()
    }

    fn now(&self) -> DateTime<Utc> {
        DateTime::<Utc>::from_naive_utc_and_offset(Utc::now().naive_utc(), Utc)
    }

    fn to_timecode(duration: Duration) -> Timecode {
        let seconds = duration.num_seconds() as u64;
        let hours = seconds / HOUR;
        let seconds = seconds - (hours * HOUR);
        let minutes = seconds / MINUTE;
        let seconds = seconds - (minutes * MINUTE);

        Timecode {
            frames: 0,
            seconds,
            minutes,
            hours,
            negative: true,
        }
    }
}
