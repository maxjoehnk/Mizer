use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{EngineHandle, MethodCallHandler, MethodChannel};
use nativeshell::Context;

use mizer_api::handlers::SurfacesHandler;
use mizer_api::proto::surfaces::*;
use mizer_api::RuntimeApi;

use crate::plugin::channels::{MethodCallExt, MethodReplyExt};

pub struct SurfacesChannel<R: RuntimeApi> {
    handler: SurfacesHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for SurfacesChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "updateSectionInput" => {
                match call.arguments().and_then(|req: UpdateSectionTransform| {
                    self.handler.update_input_mapping(
                        req.surface_id,
                        req.section_id as usize,
                        req.transform.unwrap(),
                    )
                }) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(e) => resp.respond_error(e),
                }
            }
            "updateSectionOutput" => {
                match call.arguments().and_then(|req: UpdateSectionTransform| {
                    self.handler.update_output_mapping(
                        req.surface_id,
                        req.section_id as usize,
                        req.transform.unwrap().into(),
                    )
                }) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(e) => resp.respond_error(e),
                }
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> SurfacesChannel<R> {
    pub fn new(handler: SurfacesHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/surfaces", self)
    }
}
