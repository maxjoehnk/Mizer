use super::DmxOutput;
use crate::buffer::DmxBuffer;
use mizer_connection_contracts::{IConnection, TransmissionStateSender};
use ::sacn::DmxSource;

pub struct SacnOutput {
    pub priority: u8,
    source: DmxSource,
    transmission_sender: TransmissionStateSender,
}

impl IConnection for SacnOutput {
    type Config = Option<u8>;
    const TYPE: &'static str = "dmx";

    fn create(
        priority: Self::Config,
        transmission_sender: TransmissionStateSender,
    ) -> anyhow::Result<Self> {
        Ok(Self {
            source: DmxSource::new("mizer")?,
            priority: priority.unwrap_or(100),
            transmission_sender,
        })
    }
}

impl SacnOutput {
    pub(crate) fn reconfigure(&mut self, mut priority: u8) -> u8 {
        std::mem::swap(&mut self.priority, &mut priority);

        priority
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
            } else {
                self.transmission_sender.sent_packet();
            }
        }
    }
}
