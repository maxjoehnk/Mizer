use mizer_api::handlers::ConnectionsHandler;
use crate::protos::{ConnectionsApi, Connections, GetConnectionsRequest};
use grpc::{ServerHandlerContext, ServerResponseUnarySink, ServerRequestSingle};

impl ConnectionsApi for ConnectionsHandler {
    fn get_connections(&self, o: ServerHandlerContext, req: ServerRequestSingle<GetConnectionsRequest>, resp: ServerResponseUnarySink<Connections>) -> grpc::Result<()> {
        let connections = self.get_connections();

        resp.finish(connections)
    }
}
