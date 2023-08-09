use tonic::codegen::BoxStream;
use tonic::{Request, Response, Status};

use crate::handlers::{FixturesHandler, ProgrammerHandler};
use crate::proto::fixtures::fixtures_api_server::FixturesApi;
use crate::proto::fixtures::*;
use crate::proto::programmer::programmer_api_server::ProgrammerApi;
use crate::proto::programmer::*;
use crate::RuntimeApi;
use futures::StreamExt;

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

#[tonic::async_trait]
impl<R: RuntimeApi + 'static> ProgrammerApi for ProgrammerHandler<R> {
    type SubscribeToProgrammerStream = BoxStream<ProgrammerState>;

    async fn subscribe_to_programmer(
        &self,
        _: Request<EmptyRequest>,
    ) -> Result<Response<Self::SubscribeToProgrammerStream>, Status> {
        let stream = self.state_stream().map(Ok).boxed();

        Ok(Response::new(stream))
    }

    async fn select_fixtures(
        &self,
        request: Request<SelectFixturesRequest>,
    ) -> Result<Response<EmptyResponse>, Status> {
        self.select_fixtures(request.into_inner().fixtures);

        Ok(Response::new(Default::default()))
    }

    async fn unselect_fixtures(
        &self,
        request: Request<UnselectFixturesRequest>,
    ) -> Result<Response<EmptyResponse>, Status> {
        self.unselect_fixtures(request.into_inner().fixtures);

        Ok(Response::new(Default::default()))
    }

    async fn clear(&self, _: Request<EmptyRequest>) -> Result<Response<EmptyResponse>, Status> {
        self.clear();

        Ok(Response::new(Default::default()))
    }

    async fn highlight(
        &self,
        request: Request<HighlightRequest>,
    ) -> Result<Response<EmptyResponse>, Status> {
        self.highlight(request.into_inner().highlight);

        Ok(Response::new(Default::default()))
    }

    async fn next(&self, _: Request<EmptyRequest>) -> Result<Response<EmptyResponse>, Status> {
        self.next();

        Ok(Response::new(Default::default()))
    }

    async fn previous(&self, _: Request<EmptyRequest>) -> Result<Response<EmptyResponse>, Status> {
        self.prev();

        Ok(Response::new(Default::default()))
    }

    async fn set(&self, _: Request<EmptyRequest>) -> Result<Response<EmptyResponse>, Status> {
        self.set();

        Ok(Response::new(Default::default()))
    }
}
