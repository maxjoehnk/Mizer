use crate::plugin::channels::{MethodCallExt, MethodReplyExt};
use mizer_api::handlers::{NodesHandler, TimecodeHandler};
use mizer_api::models::nodes::*;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, NodeHistory, NodePreview, NodesRef};
use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};
use std::sync::Arc;

#[derive(Clone)]
pub struct NodesChannel<R: RuntimeApi> {
    handler: NodesHandler<R>,
    timecode_handler: TimecodeHandler<R>,
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
            "getPreviewPointer" => {
                if let Value::String(path) = call.args {
                    let error_msg = anyhow::anyhow!("Missing preview for node {path}");
                    match self.get_preview_pointer(path) {
                        Some(ptr) => resp.send_ok(Value::I64(ptr)),
                        None => resp.respond_error(error_msg),
                    }
                }
            }
            "getMetadataPointer" => match self.get_nodes_pointer() {
                Ok(pointer) => resp.send_ok(Value::I64(pointer)),
                Err(err) => resp.respond_error(err),
            },
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
            "renameNode" => match call.arguments() {
                Ok(args) => {
                    log::debug!("renameNode {:?}", args);
                    match self.handler.rename_node(args) {
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
            "groupNodes" => match call.arguments() {
                Ok(args) => {
                    log::debug!("groupNodes {:?}", args);
                    match self.handler.group_nodes(args) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
                Err(err) => resp.respond_error(err),
            },
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> NodesChannel<R> {
    pub fn new(handler: NodesHandler<R>, timecode_handler: TimecodeHandler<R>) -> Self {
        Self {
            handler,
            timecode_handler,
        }
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

    fn get_preview_pointer(&self, path: String) -> Option<i64> {
        let node = self.handler.get_node(path)?;
        if let node_config::Type::TimecodeControlConfig(config) =
            node.config.into_option().and_then(|c| c.type_)?
        {
            let timecode = self
                .timecode_handler
                .get_timecode_state_ref(config.timecode_id)?;
            let preview = NodePreview { timecode };
            let preview = Arc::new(preview);

            Some(preview.to_pointer() as i64)
        } else {
            None
        }
    }

    fn get_nodes_pointer(&self) -> anyhow::Result<i64> {
        let metadata_ref = self.handler.get_node_metadata_ref()?;
        let metadata_ref = Arc::new(NodesRef::new(metadata_ref));

        Ok(metadata_ref.to_pointer() as i64)
    }
}
