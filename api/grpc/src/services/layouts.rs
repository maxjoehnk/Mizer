use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::LayoutsHandler;
use mizer_api::models::*;

use crate::protos::*;
use mizer_api::RuntimeApi;

impl<R: RuntimeApi> LayoutsApi for LayoutsHandler<R> {
    fn get_layouts(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<GetLayoutsRequest>,
        resp: ServerResponseUnarySink<Layouts>,
    ) -> grpc::Result<()> {
        let layouts = self.get_layouts();

        resp.finish(layouts)
    }

    fn add_layout(&self, _: ServerHandlerContext, req: ServerRequestSingle<AddLayoutRequest>, resp: ServerResponseUnarySink<Layouts>) -> grpc::Result<()> {
        let layouts = self.add_layout(req.message.name);

        resp.finish(layouts)
    }

    fn remove_layout(&self, _: ServerHandlerContext, req: ServerRequestSingle<RemoveLayoutRequest>, resp: ServerResponseUnarySink<Layouts>) -> grpc::Result<()> {
        let layouts = self.remove_layout(req.message.id);

        resp.finish(layouts)
    }

    fn rename_layout(&self, _: ServerHandlerContext, req: ServerRequestSingle<RenameLayoutRequest>, resp: ServerResponseUnarySink<Layouts>) -> grpc::Result<()> {
        let layouts = self.rename_layout(req.message.id, req.message.name);

        resp.finish(layouts)
    }

    fn rename_control(&self, _: ServerHandlerContext, _: ServerRequestSingle<RenameControlRequest>, _: ServerResponseUnarySink<LayoutResponse>) -> grpc::Result<()> {
        todo!()
    }

    fn move_control(&self, _: ServerHandlerContext, _: ServerRequestSingle<MoveControlRequest>, _: ServerResponseUnarySink<LayoutResponse>) -> grpc::Result<()> {
        todo!()
    }

    fn remove_control(&self, _: ServerHandlerContext, req: ServerRequestSingle<RemoveControlRequest>, resp: ServerResponseUnarySink<LayoutResponse>) -> grpc::Result<()> {
        self.remove_control(req.message.layout_id, req.message.control_id);

        resp.finish(LayoutResponse::new())
    }
}
