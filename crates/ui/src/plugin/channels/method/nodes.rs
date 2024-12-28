use std::sync::Arc;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::NodesHandler;
use mizer_api::proto::nodes::*;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, NodeHistory, NodesRef};

use crate::plugin::channels::{MethodCallExt, MethodReplyExt};

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
            "getAvailableNodes" => {
                let response = self.handler.get_available_nodes();

                resp.respond_msg(response);
            }
            "linkNodes" => match call.arguments() {
                Ok(args) => match self.handler.add_link(args) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(err) => resp.respond_error(err),
                },
                Err(err) => resp.respond_error(err),
            },
            "unlinkNodes" => match call.arguments() {
                Ok(args) => match self.handler.remove_link(args) {
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
            "getMetadataPointer" => match self.get_nodes_pointer() {
                Ok(pointer) => resp.send_ok(Value::I64(pointer)),
                Err(err) => resp.respond_error(err),
            },
            "updateNodeSetting" => match call.arguments() {
                Ok(args) => match self.handler.update_node_setting(args) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(err) => resp.respond_error(err),
                },
                Err(err) => resp.respond_error(err),
            },
            "updateNodeColor" => match call.arguments() {
                Ok(args) => match self.handler.update_node_color(args) {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(err) => resp.respond_error(err),
                },
                Err(err) => resp.respond_error(err),
            },
            "moveNodes" => match call.arguments() {
                Ok(args) => {
                    tracing::debug!("moveNodes {:?}", args);
                    match self.handler.move_nodes(args) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
                Err(err) => resp.respond_error(err),
            },
            "showNode" => match call.arguments() {
                Ok(args) => {
                    tracing::debug!("showNode {:?}", args);
                    match self.handler.show_node(args) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
                Err(err) => resp.respond_error(err),
            },
            "renameNode" => match call.arguments() {
                Ok(args) => {
                    tracing::debug!("renameNode {:?}", args);
                    match self.handler.rename_node(args) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
                Err(err) => resp.respond_error(err),
            },
            "deleteNodes" => {
                if let Value::List(path) = call.args {
                    let nodes = path
                        .into_iter()
                        .filter_map(|value| match value {
                            Value::String(path) => Some(path.into()),
                            _ => None,
                        })
                        .collect();
                    match self.handler.delete_nodes(nodes) {
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
            "disconnectPort" => match call.arguments().and_then(|args: DisconnectPortRequest| {
                self.handler.disconnect_port(args.path, args.port)
            }) {
                Ok(()) => resp.send_ok(Value::Null),
                Err(err) => resp.respond_error(err),
            },
            "duplicateNodes" => match call.arguments() {
                Ok(args) => match self.handler.duplicate_nodes(args) {
                    Ok(paths) => resp.send_ok(Value::List(
                        paths
                            .into_iter()
                            .map(|path| Value::String(path.into()))
                            .collect(),
                    )),
                    Err(err) => resp.respond_error(err),
                },
                Err(err) => resp.respond_error(err),
            },
            "groupNodes" => match call.arguments() {
                Ok(args) => {
                    tracing::debug!("groupNodes {:?}", args);
                    match self.handler.group_nodes(args) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
                Err(err) => resp.respond_error(err),
            },
            "addComment" => {
                let response = call.arguments().and_then(|args| self.handler.add_comment(args));

                resp.respond_unit_result(response);
            }
            "updateComment" => {
                let response = call.arguments().and_then(|args| self.handler.update_comment(args));

                resp.respond_unit_result(response);
            }
            "deleteComment" => {
                if let Value::String(path) = call.args {
                    let result = path.parse()
                        .map_err(anyhow::Error::from)
                        .and_then(|path| self.handler.delete_comment(path));
                    
                    resp.respond_unit_result(result);
                }
            }
            "openNodesView" => {
                self.handler.open_nodes_view();
                resp.send_ok(Value::Null);
            }
            "closeNodesView" => {
                self.handler.close_nodes_view();
                resp.send_ok(Value::Null);
            }
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

    fn write_control_value(&self, control: WriteControl) -> anyhow::Result<()> {
        self.handler.write_control_value(control)
    }

    fn get_history_pointer(&self, path: String) -> anyhow::Result<i64> {
        let err_msg = format!("Missing preview for node {}", path);
        if let Some(preview) = self.handler.get_node_preview_ref(path)? {
            let preview = NodeHistory::new(preview);
            let preview = Arc::new(preview);

            Ok(preview.to_pointer() as i64)
        } else {
            anyhow::bail!("{}", err_msg)
        }
    }

    fn get_nodes_pointer(&self) -> anyhow::Result<i64> {
        let metadata_ref = self.handler.get_node_metadata_ref()?;
        let metadata_ref = Arc::new(NodesRef::new(metadata_ref));

        Ok(metadata_ref.to_pointer() as i64)
    }
}
