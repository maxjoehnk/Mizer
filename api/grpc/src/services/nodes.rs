use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::NodesHandler;
use mizer_api::models::*;

use crate::protos::*;

impl NodesApi for NodesHandler {
    fn get_nodes(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<NodesRequest>,
        resp: ServerResponseUnarySink<Nodes>,
    ) -> grpc::Result<()> {
        let res = self.get_nodes();

        resp.finish(res)
    }

    fn add_node(
        &self,
        _: ServerHandlerContext,
        req: ServerRequestSingle<AddNodeRequest>,
        resp: ServerResponseUnarySink<Node>,
    ) -> grpc::Result<()> {
        let node = self.add_node(req.message);

        resp.finish(node)
    }

    fn add_link(
        &self,
        _: ServerHandlerContext,
        req: ServerRequestSingle<NodeConnection>,
        resp: ServerResponseUnarySink<NodeConnection>,
    ) -> grpc::Result<()> {
        self.add_link(req.message.clone()).unwrap();

        resp.finish(req.message)
    }

    fn write_control_value(
        &self,
        _: ServerHandlerContext,
        req: ServerRequestSingle<WriteControl>,
        resp: ServerResponseUnarySink<WriteResponse>,
    ) -> grpc::Result<()> {
        self.write_control_value(req.message).unwrap();

        resp.finish(WriteResponse::default())
    }

    fn update_node_property(&self, o: ServerHandlerContext, req: ServerRequestSingle<UpdateNodeConfigRequest>, resp: ServerResponseUnarySink<UpdateNodeConfigResponse>) -> grpc::Result<()> {
        self.update_node_property(req.message).unwrap();

        resp.finish(UpdateNodeConfigResponse::default())
    }
}
