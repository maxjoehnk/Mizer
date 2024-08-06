use std::sync::Arc;

use futures::stream::Stream;
use futures::StreamExt;
use pinboard::NonEmptyPinboard;

use mizer_clock::ClockSnapshot;

use crate::proto::transport::{Transport, TransportState};
use crate::RuntimeApi;

#[derive(Clone)]
pub struct TransportHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> TransportHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn transport_stream(&self) -> TransportStream {
        TransportStream(self.runtime.transport_recv())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn set_state(&self, state: TransportState) -> anyhow::Result<()> {
        let clock_state = state.into();
        self.runtime.set_clock_state(clock_state)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn set_bpm(&self, bpm: f64) -> anyhow::Result<()> {
        self.runtime.set_bpm(bpm)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn set_fps(&self, fps: f64) -> anyhow::Result<()> {
        self.runtime.set_fps(fps)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn clock_ref(&self) -> Arc<NonEmptyPinboard<ClockSnapshot>> {
        self.runtime.get_clock_snapshot_ref()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn tap(&self) -> anyhow::Result<()> {
        self.runtime.tap()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn resync(&self) -> anyhow::Result<()> {
        self.runtime.resync()
    }
}

pub struct TransportStream(flume::Receiver<ClockSnapshot>);

impl TransportStream {
    pub fn stream(self) -> impl Stream<Item = Transport> + 'static {
        self.0.into_stream().map(Transport::from)
    }
}
