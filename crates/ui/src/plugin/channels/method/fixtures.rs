use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::FixturesHandler;
use mizer_api::proto::fixtures::*;
use mizer_api::RuntimeApi;

use crate::plugin::channels::{MethodCallExt, MethodReplyExt};

#[derive(Clone)]
pub struct FixturesChannel<R: RuntimeApi> {
    handler: FixturesHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for FixturesChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "addFixtures" => {
                let response = call.arguments().map(|args| self.add_fixtures(args));

                resp.respond_result(response);
            }
            "previewFixtures" => {
                let response = call.arguments().and_then(|args| self.handler.preview_fixtures(args));

                resp.respond_result(response);
            }
            "getFixtures" => {
                let response = self.get_fixtures();

                resp.respond_msg(response);
            }
            "getFixtureDefinitions" => {
                let response = self.get_fixture_definitions();

                resp.respond_msg(response);
            }
            "deleteFixtures" => {
                if let Value::List(fixture_ids) = call.args {
                    let fixture_ids = fixture_ids
                        .into_iter()
                        .filter_map(|v| {
                            if let Value::I64(v) = v {
                                Some(v as u32)
                            } else {
                                None
                            }
                        })
                        .collect();

                    resp.respond_msg(self.delete_fixtures(fixture_ids));
                }
            }
            "updateFixture" => {
                match call
                    .arguments()
                    .and_then(|args| self.handler.update_fixture(args))
                {
                    Ok(()) => resp.send_ok(Value::Null),
                    Err(err) => resp.respond_error(err),
                }
            }
            "exportPatch" => {
                if let Value::String(path) = call.args {
                    match self.handler.export_patch(&path) {
                        Ok(()) => resp.send_ok(Value::Null),
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> FixturesChannel<R> {
    pub fn new(handler: FixturesHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/fixtures", self)
    }

    fn add_fixtures(&self, request: AddFixturesRequest) -> Fixtures {
        self.handler.add_fixtures(request);
        self.handler.get_fixtures()
    }

    fn get_fixtures(&self) -> Fixtures {
        self.handler.get_fixtures()
    }

    fn get_fixture_definitions(&self) -> FixtureDefinitions {
        self.handler.get_fixture_definitions()
    }

    fn delete_fixtures(&self, fixture_ids: Vec<u32>) -> Fixtures {
        self.handler.delete_fixtures(fixture_ids).unwrap();
        self.handler.get_fixtures()
    }
}
