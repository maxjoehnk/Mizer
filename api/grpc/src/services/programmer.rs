use futures::StreamExt;
use grpc::{Metadata, ServerRequestSingle, ServerResponseSink, ServerResponseUnarySink};

use mizer_api::handlers::ProgrammerHandler;
use mizer_api::RuntimeApi;

use crate::protos::*;

impl<R: RuntimeApi + 'static> ProgrammerApi for ProgrammerHandler<R> {
    fn subscribe_to_programmer(
        &self,
        req: ServerRequestSingle<SubscribeProgrammerRequest>,
        mut resp: ServerResponseSink<ProgrammerState>,
    ) -> grpc::Result<()> {
        let mut stream = self.state_stream();
        req.loop_handle().spawn(async move {
            while let Some(m) = stream.next().await {
                resp.send_data(m)?;
            }
            resp.send_trailers(Metadata::new())
        });

        Ok(())
    }

    fn write_control(
        &self,
        req: ServerRequestSingle<WriteControlRequest>,
        resp: ServerResponseUnarySink<WriteControlResponse>,
    ) -> grpc::Result<()> {
        self.write_control(req.message);

        resp.finish(Default::default())
    }

    fn select_fixtures(
        &self,
        req: ServerRequestSingle<SelectFixturesRequest>,
        resp: ServerResponseUnarySink<SelectFixturesResponse>,
    ) -> grpc::Result<()> {
        self.select_fixtures(req.message.fixtures.into_vec());

        resp.finish(Default::default())
    }

    fn clear(
        &self,
        _: ServerRequestSingle<ClearRequest>,
        resp: ServerResponseUnarySink<ClearResponse>,
    ) -> grpc::Result<()> {
        self.clear();

        resp.finish(Default::default())
    }

    fn highlight(
        &self,
        req: ServerRequestSingle<HighlightRequest>,
        resp: ServerResponseUnarySink<HighlightResponse>,
    ) -> grpc::Result<()> {
        self.highlight(req.message.highlight);

        resp.finish(Default::default())
    }

    fn store(
        &self,
        req: ServerRequestSingle<StoreRequest>,
        resp: ServerResponseUnarySink<super::programmer::StoreResponse>,
    ) -> grpc::Result<()> {
        self.store(req.message.sequence_id, req.message.store_mode);

        resp.finish(Default::default())
    }
}
