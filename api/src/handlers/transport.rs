use mizer_runtime::RuntimeApi;
use futures::stream::Stream;
use futures::StreamExt;
use crate::models::transport::Transport;
use mizer_clock::ClockSnapshot;
use crate::models::TransportState;

#[derive(Clone)]
pub struct TransportHandler {
    runtime: RuntimeApi,
}

impl TransportHandler {
    pub fn new(runtime: RuntimeApi) -> Self {
        Self { runtime }
    }

    pub fn transport_stream(&self) -> TransportStream {
        TransportStream(self.runtime.clock_recv.clone())
    }

    pub fn set_state(&self, state: TransportState) {
        let clock_state = state.into();
        self.runtime.set_clock_state(clock_state);
    }
}

pub struct TransportStream(flume::Receiver<ClockSnapshot>);

impl TransportStream {
    pub fn stream(&self) -> impl Stream<Item = Transport> + '_ {
        self.0.stream().map(Transport::from)
    }
}
