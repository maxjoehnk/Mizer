use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};

use mizer_api::handlers::LayoutsHandler;
use mizer_api::models::*;

use crate::protos::*;

impl LayoutsApi for LayoutsHandler {
    fn get_layouts(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<GetLayoutsRequest>,
        resp: ServerResponseUnarySink<Layouts>,
    ) -> grpc::Result<()> {
        let layouts = self.get_layouts();

        resp.finish(layouts)
    }

    fn add_layout(&self, o: ServerHandlerContext, req: ServerRequestSingle<AddLayoutRequest>, resp: ServerResponseUnarySink<Layouts>) -> grpc::Result<()> {
        let layouts = self.add_layout(req.message.name);

        resp.finish(layouts)
    }

    fn remove_layout(&self, o: ServerHandlerContext, req: ServerRequestSingle<RemoveLayoutRequest>, resp: ServerResponseUnarySink<Layouts>) -> grpc::Result<()> {
        let layouts = self.remove_layout(req.message.id);

        resp.finish(layouts)
    }

    fn rename_layout(&self, o: ServerHandlerContext, req: ServerRequestSingle<RenameLayoutRequest>, resp: ServerResponseUnarySink<Layouts>) -> grpc::Result<()> {
        let layouts = self.rename_layout(req.message.id, req.message.name);

        resp.finish(layouts)
    }
}
