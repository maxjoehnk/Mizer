use ::sacn::DmxSource;

use super::DmxOutput;
use crate::buffer::DmxBuffer;

pub struct SacnOutput {
    pub priority: u8,
    source: DmxSource,
}

impl SacnOutput {
    pub fn new(priority: Option<u8>) -> Self {
        Self {
            source: DmxSource::new("mizer").unwrap(),
            priority: priority.unwrap_or(100),
        }
    }
}

impl Default for SacnOutput {
    fn default() -> Self {
        Self::new(None)
    }
}

impl DmxOutput for SacnOutput {
    fn name(&self) -> String {
        format!("sACN ({})", self.source.name())
    }

    fn flush(&self, buffer: &DmxBuffer) {
        profiling::scope!("SacnOutput::flush");
        for (universe, buffer) in buffer.iter() {
            if let Err(err) = self
                .source
                .send_with_priority(universe, &buffer, self.priority)
            {
                tracing::error!("Unable to send dmx universe {:?}", err);
            }
        }
    }
}
