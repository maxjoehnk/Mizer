use crate::plugin::channels::{MethodCallExt, MethodReplyExt};
use mizer_api::handlers::NodesHandler;
use mizer_api::models::*;
use mizer_api::RuntimeApi;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};
use std::collections::HashMap;

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
                Ok(args) => {
                    self.link_nodes(args);
                    resp.send_ok(Value::Null);
                }
                Err(err) => resp.respond_error(err),
            },
            "writeControlValue" => match call.arguments() {
                Ok(args) => {
                    self.write_control_value(args);
                    resp.send_ok(Value::Null);
                }
                Err(err) => resp.respond_error(err),
            },
            "getNodeHistory" => {
                if let Value::String(path) = call.args {
                    match self.get_node_history(path) {
                        Ok(history) => resp.send_ok(history.into()),
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            "getNodeHistories" => {
                if let Value::List(vec) = call.args {
                    let paths = vec
                        .into_iter()
                        .filter_map(|path| {
                            if let Value::String(path) = path {
                                Some(path)
                            } else {
                                None
                            }
                        })
                        .collect();
                    match self.get_node_histories(paths) {
                        Ok(history) => {
                            let mut result = HashMap::new();
                            for (key, value) in history {
                                result.insert(Value::String(key), Value::F64List(value));
                            }
                            resp.send_ok(Value::Map(result));
                        }
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

    fn link_nodes(&self, link: NodeConnection) {
        self.handler.add_link(link).unwrap();
    }

    fn write_control_value(&self, control: WriteControl) {
        self.handler.write_control_value(control).unwrap();
    }

    fn get_node_history(&self, path: String) -> anyhow::Result<Vec<f64>> {
        self.handler.get_node_history(path)
    }

    fn get_node_histories(&self, paths: Vec<String>) -> anyhow::Result<HashMap<String, Vec<f64>>> {
        let mut map = HashMap::new();
        for path in paths {
            map.insert(path.clone(), self.handler.get_node_history(path)?);
        }
        Ok(map)
    }
}
