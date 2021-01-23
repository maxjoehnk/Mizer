use crate::protos::{FixturesApiServer, NodesApiServer, SessionApiClient, SessionApiServer};
use grpc::ClientStub;
use mizer_fixtures::manager::FixtureManager;
use mizer_pipeline::Pipeline;
use mizer_project_files::Project;
use std::sync::Arc;

mod protos;
mod services;

pub fn start(projects: Vec<Project>, pipeline: Pipeline, fixture_manager: FixtureManager) {
    std::thread::spawn(move || {
        let mut server: grpc::ServerBuilder = grpc::ServerBuilder::new();
        server.http.set_port(50051);
        server.add_service(NodesApiServer::new_service_def(
            services::nodes::NodesApiImpl::new(projects),
        ));
        server.add_service(SessionApiServer::new_service_def(
            services::session::SessionApiImpl::new(),
        ));
        server.add_service(FixturesApiServer::new_service_def(
            services::fixtures::FixturesApiImpl::new(fixture_manager),
        ));
        let _server = server.build().expect("server");
        loop {
            std::thread::park();
        }
    });
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
