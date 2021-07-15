use crate::plugin::channels::{MethodCallExt, MethodReplyExt};
use mizer_api::handlers::FixturesHandler;
use mizer_api::models::*;
use mizer_api::RuntimeApi;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};
use std::rc::Rc;

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
            "getFixtures" => {
                let response = self.get_fixtures();

                resp.respond_msg(response);
            }
            "getFixtureDefinitions" => {
                let response = self.get_fixture_definitions();

                resp.respond_msg(response);
            }
            "writeFixtureChannel" => {
                let response = call
                    .arguments()
                    .map(|args| self.write_fixture_channel(args));

                resp.respond_result(response);
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> FixturesChannel<R> {
    pub fn new(handler: FixturesHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Rc<Context>) -> MethodChannel {
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

    fn write_fixture_channel(&self, request: WriteFixtureChannelRequest) -> Fixtures {
        self.handler.write_fixture_channel(request);
        self.handler.get_fixtures()
    }
}
