use std::sync::Arc;

use grpc::ClientStub;
pub use grpc::Server;

use mizer_fixtures::manager::FixtureManager;
use mizer_media::api::MediaServerApi;

use crate::protos::{
    FixturesApiServer, LayoutsApiServer, MediaApiServer, NodesApiServer, SessionApiClient,
    SessionApiServer,
};
use mizer_fixtures::library::FixtureLibrary;

mod protos;
mod services;
mod mappings;

pub fn start(
    handle: tokio::runtime::Handle,
    mizer_runtime: mizer_runtime::RuntimeApi,
    fixture_manager: FixtureManager,
    fixture_library: FixtureLibrary,
    media_server: MediaServerApi,
) -> anyhow::Result<grpc::Server> {
    let mut server: grpc::ServerBuilder = grpc::ServerBuilder::new();
    server.http.event_loop = Some(handle);
    server.http.set_port(50051);
    server.add_service(NodesApiServer::new_service_def(
        services::nodes::NodesApiImpl::new(mizer_runtime.clone()),
    ));
    server.add_service(SessionApiServer::new_service_def(
        services::session::SessionApiImpl::new(),
    ));
    server.add_service(FixturesApiServer::new_service_def(
        services::fixtures::FixturesApiImpl::new(fixture_manager, fixture_library),
    ));
    server.add_service(MediaApiServer::new_service_def(
        services::media::MediaApiImpl::new(media_server),
    ));
    server.add_service(LayoutsApiServer::new_service_def(
        services::layouts::LayoutsApiImpl::new(mizer_runtime),
    ));
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
