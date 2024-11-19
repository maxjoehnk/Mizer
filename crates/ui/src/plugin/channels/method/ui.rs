use async_trait::async_trait;
use nativeshell::codec::{MethodCall, MethodCallError, MethodCallReply, MethodCallResult, Value};
use nativeshell::shell::{
    AsyncMethodCallHandler, Context, EngineHandle, MethodCallHandler, MethodChannel,
    RegisteredAsyncMethodCallHandler,
};

use mizer_api::handlers::UiHandler;
use mizer_api::RuntimeApi;

use crate::plugin::channels::{MessageExt, MethodReplyExt};

#[derive(Clone)]
pub struct UiChannel<R> {
    handler: UiHandler<R>,
}

#[async_trait(?Send)]
impl<R: RuntimeApi + 'static> AsyncMethodCallHandler for UiChannel<R> {
    async fn on_method_call(
        &self,
        call: MethodCall<Value>,
        _engine: EngineHandle,
    ) -> MethodCallResult<Value> {
        match call.method.as_str() {
            "commandLineExecute" => match call.args {
                Value::String(command) => {
                    let result = self.handler.command_line_execute(command).await;

                    match result {
                        Ok(_) => Ok(Value::Null),
                        Err(e) => Err(MethodCallError::from_code_message(
                            &format!("{e:?}"),
                            &format!("{e:?}"),
                        )),
                    }
                }
                _ => Err(MethodCallError::from_code_message(
                    "invalid-arguments",
                    "Invalid arguments",
                )),
            },
            "showTable" => match call.args {
                Value::String(name) => {
                    let tabular_data = self.handler.show_table(&name, &[]);

                    tabular_data.map(|r| r.into_value()).map_err(|e| {
                        MethodCallError::from_code_message(&format!("{e:?}"), &format!("{e}"))
                    })
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

                        tabular_data.map(|r| r.into_value()).map_err(|e| {
                            MethodCallError::from_code_message(&format!("{e:?}"), &format!("{e}"))
                        })
                    }
                    _ => unreachable!("Invalid showTable call"),
                },
                _ => Err(MethodCallError::from_code_message(
                    "invalid-arguments",
                    "Invalid arguments",
                )),
            },
            _ => Err(MethodCallError::from_code_message(
                "not-implemented",
                "Not implemented",
            )),
        }
    }
}

impl<R: RuntimeApi + 'static> UiChannel<R> {
    pub fn new(handler: UiHandler<R>) -> Self {
        Self { handler }
    }

    pub fn async_channel(self, context: Context) -> RegisteredAsyncMethodCallHandler<UiChannel<R>> {
        RegisteredAsyncMethodCallHandler::new(context, "mizer.live/ui", self)
    }
}
