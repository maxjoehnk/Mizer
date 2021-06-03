use mizer_api::handlers::NodesHandler;
use flutter_engine::channel::{MethodCallHandler, MethodCall, Channel, MethodChannel};
use flutter_engine::codec::STANDARD_CODEC;
use mizer_api::models::*;
use crate::plugin::channels::MethodCallExt;
use std::collections::HashMap;

#[derive(Clone)]
pub struct NodesChannel {
    handler: NodesHandler,
}

impl MethodCallHandler for NodesChannel {
    fn on_method_call(&mut self, call: MethodCall) {
        match call.method().as_str() {
            "addNode" => {
                let response = call.arguments().map(|args| self.add_node(args));

                call.respond_result(response);
            },
            "getNodes" => {
                let response = self.get_nodes();

                call.respond_msg(response);
            },
            "linkNodes" => {
                match call.arguments() {
                    Ok(args) => {
                        self.link_nodes(args);
                        call.success_empty();
                    },
                    Err(err) => call.respond_error(err),
                }
            },
            "writeControlValue" => {
                match call.arguments() {
                    Ok(args) => {
                        self.write_control_value(args);
                        call.success_empty();
                    },
                    Err(err) => call.respond_error(err),
                }
            },
            "getNodeHistory" => {
                match self.get_node_history(call.args()) {
                    Ok(history) => call.success(history),
                    Err(err) => call.respond_error(err),
                }
            },
            "getNodeHistories" => {
                match self.get_node_histories(call.args()) {
                    Ok(history) => call.success(history),
                    Err(err) => call.respond_error(err),
                }
            }
            _ => call.not_implemented()
        }
    }
}

impl NodesChannel {
    pub fn new(handler: NodesHandler) -> Self {
        Self {
            handler
        }
    }

    pub fn channel(self) -> impl Channel {
        MethodChannel::new("mizer.live/nodes", self, &STANDARD_CODEC)
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
