use mizer_api::handlers::FixturesHandler;
use flutter_engine::channel::{MethodCallHandler, MethodCall, Channel, MethodChannel};
use flutter_engine::codec::STANDARD_CODEC;
use mizer_api::models::*;
use crate::plugin::channels::MethodCallExt;

#[derive(Clone)]
pub struct FixturesChannel {
    handler: FixturesHandler,
}

impl MethodCallHandler for FixturesChannel {
    fn on_method_call(&mut self, call: MethodCall) {
        match call.method().as_str() {
            "addFixtures" => {
                let response = call.arguments().map(|args| self.add_fixtures(args));

                call.respond_result(response);
            }
            "getFixtures" => {
                let response = self.get_fixtures();

                call.respond_msg(response);
            }
            "getFixtureDefinitions" => {
                let response = self.get_fixture_definitions();

                call.respond_msg(response);
            }
            _ => call.not_implemented()
        }
    }
}

impl FixturesChannel {
    pub fn new(handler: FixturesHandler) -> Self {
        Self {
            handler
        }
    }

    pub fn channel(self) -> impl Channel {
        MethodChannel::new("mizer.live/fixtures", self, &STANDARD_CODEC)
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
}
