use grpc::{ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::LayoutsHandler;
use mizer_api::models::*;

use crate::protos::*;
use mizer_api::RuntimeApi;

impl<R: RuntimeApi> LayoutsApi for LayoutsHandler<R> {
    fn get_layouts(
        &self,
        _: ServerRequestSingle<GetLayoutsRequest>,
        resp: ServerResponseUnarySink<Layouts>,
    ) -> grpc::Result<()> {
        let layouts = self.get_layouts();

        resp.finish(layouts)
    }

    fn add_layout(
        &self,
        req: ServerRequestSingle<AddLayoutRequest>,
        resp: ServerResponseUnarySink<Layouts>,
    ) -> grpc::Result<()> {
        let layouts = self.add_layout(req.message.name);

        resp.finish(layouts)
    }

    fn remove_layout(
        &self,
        req: ServerRequestSingle<RemoveLayoutRequest>,
        resp: ServerResponseUnarySink<Layouts>,
    ) -> grpc::Result<()> {
        let layouts = self.remove_layout(req.message.id);

        resp.finish(layouts)
    }

    fn rename_layout(
        &self,
        req: ServerRequestSingle<RenameLayoutRequest>,
        resp: ServerResponseUnarySink<Layouts>,
    ) -> grpc::Result<()> {
        let layouts = self.rename_layout(req.message.id, req.message.name);

        resp.finish(layouts)
    }

    fn rename_control(
        &self,
        _: ServerRequestSingle<RenameControlRequest>,
        _: ServerResponseUnarySink<LayoutResponse>,
    ) -> grpc::Result<()> {
        todo!()
    }

    fn move_control(
        &self,
        _: ServerRequestSingle<MoveControlRequest>,
        _: ServerResponseUnarySink<LayoutResponse>,
    ) -> grpc::Result<()> {
        todo!()
    }

    fn update_control(&self, req: ServerRequestSingle<UpdateControlRequest>, resp: ServerResponseUnarySink<LayoutResponse>) -> grpc::Result<()> {
        self.update_control(req.message.layout_id, req.message.control_id, req.message.decorations.unwrap());

        resp.finish(Default::default())
    }

    fn remove_control(
        &self,
        req: ServerRequestSingle<RemoveControlRequest>,
        resp: ServerResponseUnarySink<LayoutResponse>,
    ) -> grpc::Result<()> {
        self.remove_control(req.message.layout_id, req.message.control_id);

        resp.finish(Default::default())
    }

    fn add_control(&self, req: ServerRequestSingle<AddControlRequest>, resp: ServerResponseUnarySink<LayoutResponse>) -> grpc::Result<()> {
        self.add_control(req.message.layout_id, req.message.node_type, req.message.position.unwrap()).unwrap();

        resp.finish(Default::default())
    }

    fn add_existing_control(&self, req: ServerRequestSingle<AddExistingControlRequest>, resp: ServerResponseUnarySink<LayoutResponse>) -> grpc::Result<()> {
        self.add_control_for_node(req.message.layout_id, req.message.node.into(), req.message.position.unwrap()).unwrap();

        resp.finish(Default::default())
    }
}
