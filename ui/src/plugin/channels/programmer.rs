use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{
    Context, EngineHandle, EventChannelHandler, EventSink, MethodCallHandler, MethodChannel,
    RegisteredEventChannel,
};

use mizer_api::handlers::ProgrammerHandler;
use mizer_api::models::fixtures::FixtureId;
use mizer_api::models::programmer::*;
use mizer_api::RuntimeApi;

use crate::plugin::channels::{MethodCallExt, MethodReplyExt};
use crate::plugin::event_sink::EventSinkSubscriber;
use mizer_ui_ffi::{FFIToPointer, Programmer};
use mizer_util::{AsyncRuntime, StreamSubscription};
use std::collections::HashMap;
use std::sync::Arc;

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
            "selectFixtures" => match call.arguments::<SelectFixturesRequest>() {
                Ok(req) => {
                    self.select_fixtures(req.fixtures);
                    reply.send_ok(Value::Null)
                }
                Err(err) => reply.respond_error(err),
            },
            "unselectFixtures" => match call.arguments::<UnselectFixturesRequest>() {
                Ok(req) => {
                    self.unselect_fixtures(req.fixtures);
                    reply.send_ok(Value::Null)
                }
                Err(err) => reply.respond_error(err),
            },
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
            "getPresets" => {
                let presets = self.handler.get_presets();
                reply.respond_msg(presets);
            }
            "callPreset" => match call.arguments().map(|req| self.handler.call_preset(req)) {
                Ok(()) => reply.send_ok(Value::Null),
                Err(err) => reply.respond_error(err),
            },
            "callEffect" => {
                if let Value::I64(id) = call.args {
                    self.handler.call_effect(id as u32);

                    reply.send_ok(Value::Null)
                }
            }
            "getGroups" => {
                let groups = self.handler.get_groups();
                reply.respond_msg(groups);
            }
            "selectGroup" => {
                if let Value::I64(id) = call.args {
                    self.handler.select_group(id as u32);
                    reply.send_ok(Value::Null);
                }
            }
            "addGroup" => {
                if let Value::String(name) = call.args {
                    let group = self.handler.add_group(name);
                    reply.respond_msg(group);
                }
            }
            "assignFixturesToGroup" => match call
                .arguments()
                .map(|req| self.assign_fixtures_to_group(req))
            {
                Ok(()) => reply.send_ok(Value::Null),
                Err(err) => reply.respond_error(err),
            },
            "assignFixtureSelectionToGroup" => {
                if let Value::I64(group_id) = call.args {
                    self.assign_fixture_selection_to_group(group_id as u32);
                    reply.send_ok(Value::Null);
                }
            }
            "getProgrammerPointer" => match self.get_programmer_pointer() {
                Ok(ptr) => reply.send_ok(Value::I64(ptr)),
                Err(err) => reply.respond_error(err),
            },
            "updateBlockSize" => {
                if let Value::I64(block_size) = call.args {
                    self.handler.update_block_size(block_size as usize);

                    reply.send_ok(Value::Null)
                }
            }
            "updateGroups" => {
                if let Value::I64(groups) = call.args {
                    self.handler.update_groups(groups as usize);

                    reply.send_ok(Value::Null)
                }
            }
            "updateWings" => {
                if let Value::I64(wings) = call.args {
                    self.handler.update_wings(wings as usize);

                    reply.send_ok(Value::Null)
                }
            }
            "next" => {
                self.handler.next();

                reply.send_ok(Value::Null)
            }
            "prev" => {
                self.handler.prev();

                reply.send_ok(Value::Null)
            }
            "set" => {
                self.handler.set();

                reply.send_ok(Value::Null)
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

    fn unselect_fixtures(&self, fixture_ids: Vec<FixtureId>) {
        log::trace!("ProgrammerChannel::unselect_fixtures({:?})", fixture_ids);
        self.handler.unselect_fixtures(fixture_ids);
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
        self.handler
            .store(req.sequence_id, req.store_mode.unwrap(), req.cue_id);
    }

    fn get_programmer_pointer(&self) -> anyhow::Result<i64> {
        let view = self.handler.programmer_view();
        let programmer = Programmer::new(view);
        let programmer = Arc::new(programmer);

        Ok(programmer.to_pointer() as i64)
    }

    fn assign_fixtures_to_group(&self, req: AssignFixturesToGroupRequest) {
        self.handler.assign_fixtures_to_group(req.id, req.fixtures);
    }

    fn assign_fixture_selection_to_group(&self, group_id: u32) {
        self.handler.assign_fixture_selection_to_group(group_id);
    }
}

pub struct ProgrammerEventChannel<R: RuntimeApi, AR: AsyncRuntime> {
    context: Context,
    handler: ProgrammerHandler<R>,
    runtime: AR,
    subscriptions: HashMap<i64, AR::Subscription>,
}

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> EventChannelHandler
    for ProgrammerEventChannel<R, AR>
{
    fn register_event_sink(&mut self, sink: EventSink, _: Value) {
        let id = sink.id();
        let stream = self.handler.state_stream();
        let subscription = self
            .runtime
            .subscribe(stream, EventSinkSubscriber::new(sink, &self.context));
        self.subscriptions.insert(id, subscription);
    }

    fn unregister_event_sink(&mut self, sink_id: i64) {
        if let Some(subscription) = self.subscriptions.remove(&sink_id) {
            subscription.unsubscribe();
        }
    }
}

impl<R: RuntimeApi + 'static, AR: AsyncRuntime + 'static> ProgrammerEventChannel<R, AR> {
    pub fn new(handler: ProgrammerHandler<R>, runtime: AR, context: Context) -> Self {
        Self {
            handler,
            runtime,
            subscriptions: Default::default(),
            context,
        }
    }

    pub fn event_channel(self, context: Context) -> RegisteredEventChannel<Self> {
        EventChannelHandler::register(self, context, "mizer.live/programmer/watch")
    }
}
