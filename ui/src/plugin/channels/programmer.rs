use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::ProgrammerHandler;
use mizer_api::models::*;
use mizer_api::RuntimeApi;

use crate::plugin::channels::{MethodCallExt, MethodReplyExt};

pub struct ProgrammerChannel<R: RuntimeApi> {
    handler: ProgrammerHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for ProgrammerChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        reply: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        log::trace!("ProgrammerChannel::{} ({:?})", call.method, call.args);
        match call.method.as_str() {
            "writeControl" => {
                if let Err(err) = call.arguments().map(|req| self.write_control(req)) {
                    reply.respond_error(err);
                } else {
                    reply.send_ok(Value::Null)
                }
            }
            "selectFixtures" => {
                match call.arguments::<SelectFixturesRequest>() {
                    Ok(req) => {
                        let fixture_ids = req.fixtures.into_vec();
                        self.select_fixtures(fixture_ids);
                        reply.send_ok(Value::Null)
                    }
                    Err(err) => reply.respond_error(err)
                }
            }
            "clear" => {
                self.clear();

                reply.send_ok(Value::Null)
            }
            "highlight" => {
                if let Value::Bool(highlight) = call.args {
                    self.highlight(highlight);

                    reply.send_ok(Value::Null)
                }
            }
            "store" => {
                if let Err(err) = call.arguments().map(|req| self.store(req)) {
                    reply.respond_error(err)
                } else {
                    reply.send_ok(Value::Null)
                }
            }
            _ => reply.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> ProgrammerChannel<R> {
    pub fn new(handler: ProgrammerHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/programmer", self)
    }

    fn write_control(&self, req: WriteControlRequest) {
        log::trace!("ProgrammerChannel::write_control({:?})", req);
        self.handler.write_control(req);
    }

    fn select_fixtures(&self, fixture_ids: Vec<FixtureId>) {
        log::trace!("ProgrammerChannel::select_fixtures({:?})", fixture_ids);
        self.handler.select_fixtures(fixture_ids);
    }

    fn clear(&self) {
        log::trace!("ProgrammerChannel::clear");
        self.handler.clear();
    }

    fn highlight(&self, highlight: bool) {
        log::trace!("ProgrammerChannel::highlight({})", highlight);
        self.handler.highlight(highlight);
    }

    fn store(&self, req: StoreRequest) {
        log::trace!("ProgrammerChannel::store({:?})", req);
        self.handler.store(req.sequence_id, req.store_mode);
    }
}
