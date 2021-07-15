use futures::stream::StreamExt;
use mizer_api::handlers::TransportHandler;
use mizer_api::models::*;

use crate::protos::*;
use grpc::Metadata;
use mizer_api::RuntimeApi;

impl<R: RuntimeApi> TransportApi for TransportHandler<R> {
    fn subscribe_transport(
        &self,
        o: ::grpc::ServerHandlerContext,
        _: ::grpc::ServerRequestSingle<super::transport::SubscribeTransportRequest>,
        mut resp: ::grpc::ServerResponseSink<super::transport::Transport>,
    ) -> ::grpc::Result<()> {
        let transport = self.transport_stream();
        o.spawn(async move {
            let mut stream = transport.stream();
            while let Some(m) = stream.next().await {
                resp.send_data(m)?;
            }
            resp.send_trailers(Metadata::new())
        });

        Ok(())
    }

    fn set_state(
        &self,
        _: ::grpc::ServerHandlerContext,
        req: ::grpc::ServerRequestSingle<super::transport::SetTransportRequest>,
        resp: ::grpc::ServerResponseUnarySink<super::transport::Transport>,
    ) -> ::grpc::Result<()> {
        self.set_state(req.message.state).unwrap();

        resp.finish(Default::default())
    }

    fn set_bpm(
        &self,
        _: ::grpc::ServerHandlerContext,
        _: ::grpc::ServerRequestSingle<super::transport::SetBpmRequest>,
        _: ::grpc::ServerResponseUnarySink<super::transport::Transport>,
    ) -> ::grpc::Result<()> {
        unimplemented!()
    }
}
