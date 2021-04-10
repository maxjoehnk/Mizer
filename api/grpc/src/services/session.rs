use crate::protos::SessionApi;
use mizer_api::models::*;
use grpc::{
    ServerHandlerContext, ServerRequestSingle, ServerResponseSink, ServerResponseUnarySink,
};
use mizer_api::handlers::SessionHandler;

impl SessionApi for SessionHandler {
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
}
