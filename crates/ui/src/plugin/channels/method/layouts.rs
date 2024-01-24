use std::sync::Arc;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::LayoutsHandler;
use mizer_api::proto::layouts::*;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, LayoutRef};

use crate::plugin::channels::{MethodCallExt, MethodReplyExt};

#[derive(Clone)]
pub struct LayoutsChannel<R: RuntimeApi> {
    handler: LayoutsHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for LayoutsChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        log::trace!("mizer.live/layouts -> {}", call.method);
        match call.method.as_str() {
            "getLayouts" => {
                let response = self.get_layouts();

                resp.respond_msg(response);
            }
            "addLayout" => {
                if let Value::String(name) = call.args {
                    let response = self.add_layout(name);

                    resp.respond_msg(response);
                }
            }
            "removeLayout" => {
                if let Value::String(id) = call.args {
                    let response = self.remove_layout(id);

                    resp.respond_msg(response);
                }
            }
            "renameLayout" => {
                let response = call
                    .arguments()
                    .map(|req: RenameLayoutRequest| self.rename_layout(req.id, req.name));

                resp.respond_result(response);
            }
            "removeControl" => {
                if let Err(err) = call.arguments().map(|req| self.remove_control(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "moveControl" => {
                if let Err(err) = call.arguments().map(|req| self.move_control(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "resizeControl" => {
                if let Err(err) = call.arguments().map(|req| self.resize_control(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "renameControl" => {
                if let Err(err) = call.arguments().map(|req| self.rename_control(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "updateControlDecoration" => {
                if let Err(err) = call
                    .arguments()
                    .map(|req| self.update_control_decoration(req))
                {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "updateControlBehavior" => {
                if let Err(err) = call
                    .arguments()
                    .map(|req| self.update_control_behavior(req))
                {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addControl" => {
                if let Err(err) = call.arguments().map(|req| self.add_control(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addExistingControl" => {
                if let Err(err) = call.arguments().map(|req| self.add_control_for_node(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addSequenceControl" => {
                if let Err(err) = call
                    .arguments()
                    .map(|req| self.add_control_for_sequence(req))
                {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addGroupControl" => {
                if let Err(err) = call.arguments().map(|req| self.add_control_for_group(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addPresetControl" => {
                if let Err(err) = call.arguments().map(|req| self.add_control_for_preset(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "readFaderValue" => {
                if let Value::String(node_path) = call.args {
                    if let Some(value) = self.handler.read_fader_value(node_path.into()) {
                        resp.send_ok(Value::F64(value));
                    } else {
                        resp.respond_error(anyhow::anyhow!("Missing node path"));
                    }
                }
            }
            "getLayoutsPointer" => match self.get_layouts_pointer() {
                Ok(ptr) => resp.send_ok(Value::I64(ptr)),
                Err(err) => resp.respond_error(err),
            },
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> LayoutsChannel<R> {
    pub fn new(handler: LayoutsHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/layouts", self)
    }

    fn get_layouts(&self) -> Layouts {
        self.handler.get_layouts()
    }

    fn add_layout(&self, name: String) -> Layouts {
        self.handler.add_layout(name)
    }

    fn remove_layout(&self, id: String) -> Layouts {
        self.handler.remove_layout(id)
    }

    fn rename_layout(&self, id: String, name: String) -> Layouts {
        self.handler.rename_layout(id, name)
    }

    fn remove_control(&self, req: RemoveControlRequest) {
        self.handler.remove_control(req.layout_id, req.control_id);
    }

    fn move_control(&self, req: MoveControlRequest) {
        self.handler
            .move_control(req.layout_id, req.control_id, req.position.unwrap());
    }

    fn resize_control(&self, req: ResizeControlRequest) {
        self.handler
            .resize_control(req.layout_id, req.control_id, req.size.unwrap());
    }

    fn rename_control(&self, req: RenameControlRequest) {
        self.handler
            .rename_control(req.layout_id, req.control_id, req.name);
    }

    fn update_control_decoration(&self, req: UpdateControlDecorationRequest) {
        self.handler.update_control_decorations(
            req.layout_id,
            req.control_id,
            req.decorations.unwrap(),
        );
    }

    fn update_control_behavior(&self, req: UpdateControlBehaviorRequest) {
        self.handler
            .update_control_behavior(req.layout_id, req.control_id, req.behavior.unwrap());
    }

    fn add_control(&self, req: AddControlRequest) -> anyhow::Result<()> {
        let control_type = req.control_type();
        self.handler
            .add_control(req.layout_id, control_type, req.position.unwrap())
    }

    fn add_control_for_node(&self, req: AddExistingControlRequest) -> anyhow::Result<()> {
        self.handler
            .add_control_for_node(req.layout_id, req.node.into(), req.position.unwrap())
    }

    fn add_control_for_sequence(&self, req: AddSequenceControlRequest) -> anyhow::Result<()> {
        self.handler
            .add_control_for_sequence(req.layout_id, req.sequence_id, req.position.unwrap())
    }

    fn add_control_for_group(&self, req: AddGroupControlRequest) -> anyhow::Result<()> {
        self.handler
            .add_control_for_group(req.layout_id, req.group_id, req.position.unwrap())
    }

    fn add_control_for_preset(&self, req: AddPresetControlRequest) -> anyhow::Result<()> {
        self.handler.add_control_for_preset(
            req.layout_id,
            req.preset_id.unwrap(),
            req.position.unwrap(),
        )
    }

    fn get_layouts_pointer(&self) -> anyhow::Result<i64> {
        let view = self.handler.layouts_view();
        let layouts = LayoutRef::new(view);
        let layouts = Arc::new(layouts);

        Ok(layouts.to_pointer() as i64)
    }
}
