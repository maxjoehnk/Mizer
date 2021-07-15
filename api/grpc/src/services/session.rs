use crate::protos::SessionApi;
use grpc::{
    ServerHandlerContext, ServerRequestSingle, ServerResponseSink, ServerResponseUnarySink,
};
use mizer_api::handlers::SessionHandler;
use mizer_api::models::*;
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

    fn new_project(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<ProjectRequest>,
        resp: ServerResponseUnarySink<ProjectResponse>,
    ) -> grpc::Result<()> {
        self.new_project().unwrap();

        resp.finish(Default::default())
    }

    fn load_project(
        &self,
        _: ServerHandlerContext,
        req: ServerRequestSingle<LoadProjectRequest>,
        resp: ServerResponseUnarySink<ProjectResponse>,
    ) -> grpc::Result<()> {
        self.load_project(req.message.path).unwrap();

        resp.finish(Default::default())
    }

    fn save_project(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<ProjectRequest>,
        resp: ServerResponseUnarySink<ProjectResponse>,
    ) -> grpc::Result<()> {
        self.save_project().unwrap();

        resp.finish(Default::default())
    }
}
