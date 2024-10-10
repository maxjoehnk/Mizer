use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::UiHandler;
use mizer_api::RuntimeApi;

use crate::plugin::channels::MethodReplyExt;

#[derive(Clone)]
pub struct UiChannel<R> {
    handler: UiHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for UiChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "showTable" => match call.args {
                Value::String(name) => {
                    let tabular_data = self.handler.show_table(&name, &[]);

                    resp.respond_result(tabular_data);
                }
                Value::List(args) => match &args[..] {
                    [Value::String(name), Value::List(args)] => {
                        let args = args
                            .into_iter()
                            .filter_map(|v| {
                                if let Value::String(s) = v {
                                    Some(s)
                                } else {
                                    None
                                }
                            })
                            .collect::<Vec<_>>();
                        let tabular_data = self.handler.show_table(name, &args);

                        resp.respond_result(tabular_data);
                    }
                    _ => unreachable!("Invalid showTable call"),
                },
                _ => resp.respond_error(anyhow::anyhow!("Invalid arguments")),
            },
            "commandLineExecute" => match call.args {
                Value::String(command) => {
                    let result = self.handler.command_line_execute(command);

                    resp.respond_unit_result(result);
                }
                _ => resp.respond_error(anyhow::anyhow!("Invalid arguments")),
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> UiChannel<R> {
    pub fn new(handler: UiHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/ui", self)
    }
}
