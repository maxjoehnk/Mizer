use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::ConnectionsHandler;
use mizer_api::RuntimeApi;

use crate::plugin::channels::MethodReplyExt;

#[derive(Clone)]
pub struct ConnectionsChannel<R: RuntimeApi> {
    handler: ConnectionsHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for ConnectionsChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "getConnections" => {
                let response = self.handler.get_connections();

                resp.respond_msg(response);
            }
            "monitorDmx" => {
                if let Value::String(output_id) = call.args {
                    match self.handler.monitor_dmx(output_id) {
                        Ok(values) => {
                            let values = values
                                .into_iter()
                                .map(|(universe, channels)| {
                                    (
                                        Value::I64(universe as i64),
                                        Value::U8List(channels.to_vec()),
                                    )
                                })
                                .collect();
                            resp.send_ok(Value::Map(values));
                        }
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> ConnectionsChannel<R> {
    pub fn new(handler: ConnectionsHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/connections", self)
    }
}
