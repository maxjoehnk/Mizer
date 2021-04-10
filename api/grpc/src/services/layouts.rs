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
}
