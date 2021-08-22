use mizer_api::RuntimeApi;
use crate::protos::*;
use mizer_api::handlers::ProgrammerHandler;
use grpc::{ServerRequestSingle, ServerResponseSink, ServerResponseUnarySink};

impl<R: RuntimeApi> ProgrammerApi for ProgrammerHandler<R> {
    fn subscribe_to_programmer(&self, req: ServerRequestSingle<SubscribeProgrammerRequest>, resp: ServerResponseSink<ProgrammerState>) -> grpc::Result<()> {
        todo!()
    }

    fn write_channels(&self, req: ServerRequestSingle<WriteChannelsRequest>, resp: ServerResponseUnarySink<WriteChannelsResponse>) -> grpc::Result<()> {
        self.write_channels(req.message);

        resp.finish(Default::default())
    }

    fn select_fixtures(&self, req: ServerRequestSingle<SelectFixturesRequest>, resp: ServerResponseUnarySink<SelectFixturesResponse>) -> grpc::Result<()> {
        self.select_fixtures(req.message.fixtures);

        resp.finish(Default::default())
    }

    fn clear(&self, req: ServerRequestSingle<ClearRequest>, resp: ServerResponseUnarySink<ClearResponse>) -> grpc::Result<()> {
        self.clear();

        resp.finish(Default::default())
    }

    fn highlight(&self, req: ServerRequestSingle<HighlightRequest>, resp: ServerResponseUnarySink<HighlightResponse>) -> grpc::Result<()> {
        self.highlight(req.message.highlight);

        resp.finish(Default::default())
    }

    fn store(&self, req: ServerRequestSingle<StoreRequest>, resp: ServerResponseUnarySink<super::programmer::StoreResponse>) -> grpc::Result<()> {
        self.store(req.message.sequence_id, req.message.store_mode);

        resp.finish(Default::default())
    }
}
