use std::sync::Arc;
use crate::models::transport::Transport;
use crate::models::TransportState;
use crate::RuntimeApi;
use futures::stream::Stream;
use futures::StreamExt;
use pinboard::NonEmptyPinboard;
use mizer_clock::ClockSnapshot;

#[derive(Clone)]
pub struct TransportHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> TransportHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    pub fn transport_stream(&self) -> TransportStream {
        TransportStream(self.runtime.transport_recv())
    }

    pub fn set_state(&self, state: TransportState) -> anyhow::Result<()> {
        let clock_state = state.into();
        self.runtime.set_clock_state(clock_state)?;

        Ok(())
    }

    pub fn clock_ref(&self) -> Arc<NonEmptyPinboard<ClockSnapshot>> {
        self.runtime.get_clock_snapshot_ref()
    }
}

pub struct TransportStream(flume::Receiver<ClockSnapshot>);

impl TransportStream {
    pub fn stream(self) -> impl Stream<Item = Transport> + 'static {
        self.0.into_stream().map(Transport::from)
    }
}
