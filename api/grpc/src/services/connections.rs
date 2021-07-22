use grpc::{ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::ConnectionsHandler;
use mizer_api::models::*;
use mizer_api::RuntimeApi;

use crate::protos::{Connections, ConnectionsApi, GetConnectionsRequest};

impl<R: RuntimeApi> ConnectionsApi for ConnectionsHandler<R> {
    fn get_connections(
        &self,
        _: ServerRequestSingle<GetConnectionsRequest>,
        resp: ServerResponseUnarySink<Connections>,
    ) -> grpc::Result<()> {
        let connections = self.get_connections();

        resp.finish(connections)
    }

    fn monitor_dmx(
        &self,
        req: ServerRequestSingle<MonitorDmxRequest>,
        resp: ServerResponseUnarySink<MonitorDmxResponse>,
    ) -> grpc::Result<()> {
        let result = self.monitor_dmx(req.message.outputId).unwrap();

        resp.finish(MonitorDmxResponse {
            universes: result
                .into_iter()
                .map(|(universe, channels)| MonitorDmxUniverse {
                    universe: universe as u32,
                    channels: channels.to_vec(),
                    ..Default::default()
                })
                .collect(),
            ..Default::default()
        })
    }
}
