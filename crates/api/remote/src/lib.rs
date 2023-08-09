use crate::mizer::fixtures::fixtures_api_server::{FixturesApi, FixturesApiServer};
use crate::mizer::fixtures::{Fixtures, GetFixturesRequest};
use mizer_api::handlers::{FixturesHandler, Handlers};
use mizer_api::RuntimeApi;
use std::net::{IpAddr, Ipv4Addr, SocketAddr, TcpListener};
use tonic::transport::Server;
use tonic::{async_trait, Request, Response, Status};

pub mod mizer {
    pub mod fixtures {
        tonic::include_proto!("mizer.fixtures");
    }
}

#[async_trait]
impl<R: RuntimeApi + 'static> FixturesApi for FixturesHandler<R> {
    #[tracing::instrument]
    async fn get_fixtures(
        &self,
        _: Request<GetFixturesRequest>,
    ) -> Result<Response<Fixtures>, Status> {
        let fixtures = self.get_fixtures();

        Ok(Response::new(fixtures))
    }
}

pub fn start_api<R: RuntimeApi>(handlers: Handlers<R>) -> anyhow::Result<u16> {
    let port = get_available_port().ok_or_else(|| anyhow::anyhow!("no available port"))?;
    let addr = SocketAddr::new(IpAddr::V4(Ipv4Addr::UNSPECIFIED), port);

    tokio::spawn(async {
        let result = Server::builder()
            .trace_fn(|_| tracing::info_span!("remote_api"))
            .add_service(FixturesApiServer::new(handlers.fixtures))
            .serve(addr)
            .await;

        if let Err(err) = result {
            tracing::error!("failed to start remote API: {err}");
        }
    });

    Ok(())
}

fn get_available_port() -> Option<u16> {
    (50000..60000).find(|port| port_is_available(*port))
}

fn port_is_available(port: u16) -> bool {
    match TcpListener::bind(("0.0.0.0", port)) {
        Ok(_) => true,
        Err(_) => false,
    }
}
