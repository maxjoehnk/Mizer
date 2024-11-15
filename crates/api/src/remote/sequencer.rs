use std::time::Duration;
use tonic::{Request, Response, Status};
use futures::{Stream, StreamExt};
use itertools::Itertools;
use tonic::codegen::BoxStream;
use tonic::codegen::tokio_stream::wrappers::IntervalStream;
use crate::handlers::SequencerHandler;
use crate::proto::sequencer::sequencer_remote_api_server::SequencerRemoteApi;
use crate::proto::sequencer::*;
use crate::RuntimeApi;

#[tonic::async_trait]
impl<R: RuntimeApi + 'static> SequencerRemoteApi for SequencerHandler<R> {
    type SubscribeToSequencesStream = BoxStream<SequencerState>;

    async fn subscribe_to_sequences(
        &self,
        _: Request<GetSequencesRequest>,
    ) -> Result<Response<Self::SubscribeToSequencesStream>, Status> {
        let stream = self.sequencer_stream().map(Ok).boxed();

        Ok(Response::new(stream))
    }

    async fn go_sequence(&self, req: Request<SequenceGoRequest>) -> Result<Response<Empty>, Status> {
        self.sequence_go_forward(req.into_inner().sequence);

        Ok(Response::new(Empty {}))
    }
    
    
    async fn stop_sequence(&self, req: Request<SequenceStopRequest>) -> Result<Response<Empty>, Status> {
        self.sequence_stop(req.into_inner().sequence);

        Ok(Response::new(Empty {}))
    }
}

impl<R: RuntimeApi + 'static> SequencerHandler<R> {
    fn sequencer_stream(&self) -> impl Stream<Item = SequencerState> + 'static {
        let interval = tokio::time::interval(Duration::from_secs_f32(0.5));
        let handler = self.clone();
        let view = handler.sequencer_view();

        IntervalStream::new(interval).map(move |_| {
            let sequences = handler.get_sequences();
            let state = view.read();

            SequencerState {
                sequences: sequences.sequences.into_iter()
                    .sorted_by_key(|sequence| sequence.id)
                    .map(|sequence| SequenceState {
                        sequence: sequence.id,
                        name: sequence.name.clone(),
                        active: state.get(&sequence.id).map(|state| state.active).unwrap_or_default(),
                        rate: state.get(&sequence.id).map(|state| state.rate).unwrap_or(1.0),
                    })
                    .collect(),
            }
        })
    }
}
