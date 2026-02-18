use chrono::{DateTime, Duration, Local, NaiveTime, Utc};
use serde::{Deserialize, Serialize};

use mizer_clock::*;
use mizer_node::*;

const MINUTE: u64 = 60;
const HOUR: u64 = 60 * MINUTE;

const TIMECODE_OUTPUT: &str = "Timecode";

#[derive(Clone, Default, Debug, Deserialize, Serialize, PartialEq)]
pub struct ClockNode {}

impl ConfigurableNode for ClockNode {}

impl PipelineNode for ClockNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "System Clock".into(),
            preview_type: PreviewType::Timecode,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(TIMECODE_OUTPUT, PortType::Clock)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Clock
    }
}

impl ProcessingNode for ClockNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let now = self.now();
        let duration = now.signed_duration_since(self.today());
        let timecode = to_timecode(duration);

        context.write_timecode_preview(timecode);

        context.write_port::<_, port_types::CLOCK>(TIMECODE_OUTPUT, duration.to_std()?);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl ClockNode {
    fn now(&self) -> DateTime<Local> {
        Local::now()
    }

    fn today(&self) -> DateTime<Local> {
        Local::now().with_time(NaiveTime::default()).unwrap()
    }
}

fn to_timecode(duration: Duration) -> Timecode {
    let seconds = duration.num_seconds() as u64;
    let hours = seconds / HOUR;
    let seconds = seconds.saturating_sub(hours * HOUR);
    let minutes = seconds / MINUTE;
    let seconds = seconds.saturating_sub(minutes * MINUTE);

    Timecode {
        frames: 0,
        seconds,
        minutes,
        hours,
        negative: true,
    }
}
