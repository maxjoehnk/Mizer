use std::sync::Arc;

use grpc::ClientStub;
pub use grpc::Server;

use crate::protos::{
    FixturesApiServer, LayoutsApiServer, MediaApiServer, NodesApiServer, SessionApiClient,
    SessionApiServer,
};
use mizer_api::handlers::*;

mod protos;
mod services;

pub fn start(
    handle: tokio::runtime::Handle,
    handlers: Handlers,
) -> anyhow::Result<grpc::Server> {
    let mut server: grpc::ServerBuilder = grpc::ServerBuilder::new();
    server.http.event_loop = Some(handle);
    server.http.set_port(50051);
    server.add_service(NodesApiServer::new_service_def(handlers.nodes));
    server.add_service(SessionApiServer::new_service_def(handlers.session));
    server.add_service(FixturesApiServer::new_service_def(handlers.fixtures));
    server.add_service(MediaApiServer::new_service_def(handlers.media));
    server.add_service(LayoutsApiServer::new_service_def(handlers.layouts));
    let server = server.build()?;

    Ok(server)
}

pub fn connect(host: &str, port: u16) -> anyhow::Result<MizerApiClient> {
    MizerApiClient::new(host, port)
}

pub struct MizerApiClient {
    pub sessions: SessionApiClient,
}

impl MizerApiClient {
    pub fn new(host: &str, port: u16) -> anyhow::Result<Self> {
        let client = grpc::ClientBuilder::new(host, port).build()?;
        let client = Arc::new(client);
        let sessions = SessionApiClient::with_client(client);

        Ok(MizerApiClient { sessions })
    }
}
