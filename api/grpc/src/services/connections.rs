use crate::protos::{Connections, ConnectionsApi, GetConnectionsRequest};
use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};
use mizer_api::handlers::ConnectionsHandler;

impl ConnectionsApi for ConnectionsHandler {
    fn get_connections(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<GetConnectionsRequest>,
        resp: ServerResponseUnarySink<Connections>,
    ) -> grpc::Result<()> {
        let connections = self.get_connections();

        resp.finish(connections)
    }
}
