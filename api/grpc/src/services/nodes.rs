use grpc::{ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::NodesHandler;
use mizer_api::models::*;

use crate::protos::*;
use mizer_api::RuntimeApi;

impl<R: RuntimeApi> NodesApi for NodesHandler<R> {
    fn get_nodes(
        &self,
        _: ServerRequestSingle<NodesRequest>,
        resp: ServerResponseUnarySink<Nodes>,
    ) -> grpc::Result<()> {
        let res = self.get_nodes();

        resp.finish(res)
    }

    fn add_node(
        &self,
        req: ServerRequestSingle<AddNodeRequest>,
        resp: ServerResponseUnarySink<Node>,
    ) -> grpc::Result<()> {
        let node = self.add_node(req.message);

        resp.finish(node)
    }

    fn add_link(
        &self,
        req: ServerRequestSingle<NodeConnection>,
        resp: ServerResponseUnarySink<NodeConnection>,
    ) -> grpc::Result<()> {
        self.add_link(req.message.clone()).unwrap();

        resp.finish(req.message)
    }

    fn write_control_value(
        &self,
        req: ServerRequestSingle<WriteControl>,
        resp: ServerResponseUnarySink<WriteResponse>,
    ) -> grpc::Result<()> {
        self.write_control_value(req.message).unwrap();

        resp.finish(WriteResponse::default())
    }

    fn update_node_property(
        &self,
        req: ServerRequestSingle<UpdateNodeConfigRequest>,
        resp: ServerResponseUnarySink<UpdateNodeConfigResponse>,
    ) -> grpc::Result<()> {
        self.update_node_property(req.message).unwrap();

        resp.finish(UpdateNodeConfigResponse::default())
    }

    fn move_node(
        &self,
        req: ServerRequestSingle<MoveNodeRequest>,
        resp: ServerResponseUnarySink<MoveNodeResponse>,
    ) -> grpc::Result<()> {
        self.move_node(req.message).unwrap();

        resp.finish(MoveNodeResponse::default())
    }

    fn delete_node(
        &self,
        req: ServerRequestSingle<DeleteNodeRequest>,
        resp: ServerResponseUnarySink<DeleteNodeResponse>,
    ) -> grpc::Result<()> {
        self.delete_node(req.message.path.into()).unwrap();

        resp.finish(DeleteNodeResponse::default())
    }
}
