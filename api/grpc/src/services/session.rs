use crate::protos::SessionApi;
use mizer_api::models::*;
use grpc::{
    ServerHandlerContext, ServerRequestSingle, ServerResponseSink, ServerResponseUnarySink,
};
use mizer_api::handlers::SessionHandler;
use mizer_api::RuntimeApi;

impl<R: RuntimeApi> SessionApi for SessionHandler<R> {
    fn get_session(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<SessionRequest>,
        mut resp: ServerResponseSink<Session>,
    ) -> grpc::Result<()> {
        let session = self.get_session();

        resp.send_data(session)
    }

    fn join_session(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<ClientAnnouncement>,
        _: ServerResponseUnarySink<Session>,
    ) -> grpc::Result<()> {
        unimplemented!()
    }

    fn close_project(&self, o: ServerHandlerContext, req: ServerRequestSingle<ProjectRequest>, resp: ServerResponseUnarySink<ProjectResponse>) -> grpc::Result<()> {
        self.close_project();

        resp.finish(Default::default())
    }

    fn new_project(&self, o: ServerHandlerContext, req: ServerRequestSingle<ProjectRequest>, resp: ServerResponseUnarySink<ProjectResponse>) -> grpc::Result<()> {
        self.new_project();

        resp.finish(Default::default())
    }

    fn open_project(&self, o: ServerHandlerContext, req: ServerRequestSingle<OpenProjectRequest>, resp: ServerResponseUnarySink<ProjectResponse>) -> grpc::Result<()> {
        self.open_project(req.message.path);

        resp.finish(Default::default())
    }

    fn save_project(&self, o: ServerHandlerContext, req: ServerRequestSingle<ProjectRequest>, resp: ServerResponseUnarySink<ProjectResponse>) -> grpc::Result<()> {
        self.save_project();

        resp.finish(Default::default())
    }
}
