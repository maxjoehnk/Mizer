use std::sync::Arc;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::{PortsHandler, SequencerHandler};
use mizer_api::proto::sequencer::*;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, Sequencer};

use crate::plugin::channels::MethodReplyExt;

pub struct PortsChannel<R: RuntimeApi> {
    handler: PortsHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for PortsChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "getPorts" => {
                let ports = self.handler.get_ports();

                resp.respond_result(ports);
            }
            "addPort" => {
                let name = if let Value::String(name) = call.args {
                    Some(name)
                } else {
                    None
                };
                let port = self.handler.add_port(name);

                resp.respond_result(port);
            }
            "deletePort" => {
                if let Value::I64(port_id) = call.args {
                    let port_id = port_id as u32;
                    let result = self.handler.delete_port(port_id.into());

                    resp.respond_unit_result(result);
                }
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> PortsChannel<R> {
    pub fn new(handler: PortsHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/ports", self)
    }
}
