use tonic::{Request, Response, Status};

use crate::handlers::FixturesHandler;
use crate::proto::fixtures::fixtures_api_server::FixturesApi;
use crate::proto::fixtures::*;
use crate::RuntimeApi;

#[tonic::async_trait]
impl<R: RuntimeApi + 'static> FixturesApi for FixturesHandler<R> {
    async fn get_fixtures(
        &self,
        _: Request<GetFixturesRequest>,
    ) -> Result<Response<Fixtures>, Status> {
        let fixtures = self.get_fixtures();

        Ok(Response::new(fixtures))
    }
}
