use std::sync::Arc;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::PlansHandler;
use mizer_api::models::plans::*;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, FixturesRef};

use crate::plugin::channels::MethodReplyExt;
use crate::MethodCallExt;

#[derive(Clone)]
pub struct PlansChannel<R: RuntimeApi> {
    handler: PlansHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for PlansChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        log::trace!("mizer.live/plans -> {}", call.method);
        match call.method.as_str() {
            "getPlans" => {
                let response = self.get_plans();

                resp.respond_msg(response);
            }
            "addPlan" => {
                if let Value::String(name) = call.args {
                    let response = self.add_plan(name);

                    resp.respond_msg(response);
                }
            }
            "removePlan" => {
                if let Value::String(id) = call.args {
                    let response = self.remove_plan(id);

                    resp.respond_msg(response);
                }
            }
            "renamePlan" => {
                let response = call
                    .arguments()
                    .map(|req: RenamePlanRequest| self.rename_plan(req.id, req.name));

                resp.respond_result(response);
            }
            "getFixturesPointer" => match self.get_fixtures_pointer() {
                Ok(ptr) => resp.send_ok(Value::I64(ptr)),
                Err(err) => resp.respond_error(err),
            },
            "addFixtureSelection" => {
                if let Value::String(id) = call.args {
                    self.add_fixture_selection(id);

                    resp.send_ok(Value::Null);
                }
            }
            "moveSelection" => {
                if let Err(err) = call.arguments().map(|req| self.move_fixture_selection(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "moveFixture" => {
                if let Err(err) = call.arguments().map(|req| self.move_fixture(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "alignFixtures" => {
                if let Err(err) = call.arguments().map(|req| self.align_fixtures(req)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> PlansChannel<R> {
    pub fn new(handler: PlansHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/plans", self)
    }

    fn get_plans(&self) -> Plans {
        self.handler.get_plans()
    }

    fn add_plan(&self, name: String) -> Plans {
        self.handler.add_plan(name)
    }

    fn remove_plan(&self, id: String) -> Plans {
        self.handler.remove_plan(id)
    }

    fn rename_plan(&self, id: String, name: String) -> Plans {
        self.handler.rename_plan(id, name)
    }

    fn get_fixtures_pointer(&self) -> anyhow::Result<i64> {
        let states = self.handler.state_ref();
        let states = Arc::new(FixturesRef(states));

        Ok(states.to_pointer() as i64)
    }

    fn add_fixture_selection(&self, plan_id: String) {
        self.handler.add_fixture_selection(plan_id);
    }

    fn move_fixture_selection(&self, req: MoveFixturesRequest) {
        log::debug!("move_fixture_selection {req:?}");
        self.handler
            .move_fixture_selection(req.plan_id, (req.x, req.y));
    }

    fn move_fixture(&self, req: MoveFixtureRequest) {
        log::debug!("move_fixture {req:?}");
        self.handler
            .move_fixture(req.plan_id, req.fixture_id.unwrap(), (req.x, req.y));
    }

    fn align_fixtures(&self, req: AlignFixturesRequest) {
        log::debug!("align_fixtures {req:?}");
        self.handler.align_fixtures(
            req.plan_id,
            req.direction.unwrap(),
            req.groups,
            req.row_gap,
            req.column_gap,
        );
    }
}
