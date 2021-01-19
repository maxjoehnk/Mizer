use mizer_project_files::Project;
use mizer_pipeline::Pipeline;
use crate::protos::{NodesApiServer, SessionApiServer};

mod protos;
mod services;

pub fn start(projects: Vec<Project>, pipeline: Pipeline) {
    let mut server: grpc::ServerBuilder = grpc::ServerBuilder::new();
    server.http.set_port(50051);
    server.add_service(NodesApiServer::new_service_def(services::nodes::NodesApiImpl::new(projects)));
    server.add_service(SessionApiServer::new_service_def(services::session::SessionApiImpl::new()));
    let _server = server.build().expect("server");
    loop {
        std::thread::park();
    }
}
