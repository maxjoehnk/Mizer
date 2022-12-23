use crate::plugin::channels::{MethodCallExt, MethodReplyExt};
use mizer_api::handlers::NodesHandler;
use mizer_api::models::nodes::*;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, NodeHistory};
use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};
use std::sync::Arc;

#[derive(Clone)]
pub struct NodesChannel<R: RuntimeApi> {
    handler: NodesHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for NodesChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "addNode" => {
                let response = call.arguments().map(|args| self.add_node(args));

                resp.respond_result(response);
            }
            "getNodes" => {
                let response = self.get_nodes();

                resp.respond_msg(response);
            }
            "linkNodes" => match call.arguments() {
                Ok(args) => match self.link_nodes(args) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(err) => resp.respond_error(err),
                },
                Err(err) => resp.respond_error(err),
            },
            "writeControlValue" => match call.arguments() {
                Ok(args) => match self.write_control_value(args) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(err) => resp.respond_error(err),
                },
                Err(err) => resp.respond_error(err),
            },
            "getHistoryPointer" => {
                if let Value::String(path) = call.args {
                    match self.get_history_pointer(path) {
                        Ok(ptr) => resp.send_ok(Value::I64(ptr)),
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            "updateNodeProperty" => match call.arguments() {
                Ok(args) => match self.handler.update_node_property(args) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(err) => resp.respond_error(err),
                },
                Err(err) => resp.respond_error(err),
            },
            "moveNode" => match call.arguments() {
                Ok(args) => {
                    log::debug!("moveNode {:?}", args);
                    match self.handler.move_node(args) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
                Err(err) => resp.respond_error(err),
            },
            "showNode" => match call.arguments() {
                Ok(args) => {
                    log::debug!("showNode {:?}", args);
                    match self.handler.show_node(args) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
                Err(err) => resp.respond_error(err),
            },
            "deleteNode" => {
                if let Value::String(path) = call.args {
                    match self.handler.delete_node(path.into()) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            "hideNode" => {
                if let Value::String(path) = call.args {
                    match self.handler.hide_node(path.into()) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            "disconnectPorts" => {
                if let Value::String(path) = call.args {
                    match self.handler.disconnect_ports(path.into()) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            "duplicateNode" => match call.arguments() {
                Ok(args) => match self.handler.duplicate_node(args) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(err) => resp.respond_error(err),
                },
                Err(err) => resp.respond_error(err),
            },
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> NodesChannel<R> {
    pub fn new(handler: NodesHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/nodes", self)
    }

    fn add_node(&self, request: AddNodeRequest) -> Node {
        self.handler.add_node(request)
    }

    fn get_nodes(&self) -> Nodes {
        self.handler.get_nodes()
    }

    fn link_nodes(&self, link: NodeConnection) -> anyhow::Result<()> {
        self.handler.add_link(link)
    }

    fn write_control_value(&self, control: WriteControl) -> anyhow::Result<()> {
        self.handler.write_control_value(control)
    }

    fn get_history_pointer(&self, path: String) -> anyhow::Result<i64> {
        let err_msg = format!("Missing preview for node {}", path);
        if let Some(history) = self.handler.get_node_history_ref(path)? {
            let history = NodeHistory { history };
            let history = Arc::new(history);

            Ok(history.to_pointer() as i64)
        } else {
            anyhow::bail!("{}", err_msg)
        }
    }
}
