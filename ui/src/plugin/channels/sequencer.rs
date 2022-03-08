use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};
use std::sync::Arc;

use mizer_api::handlers::SequencerHandler;
use mizer_api::models::{CueTriggerRequest, CueNameRequest, Sequence, Sequences};
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{FFIToPointer, Sequencer};

use crate::plugin::channels::MethodReplyExt;
use crate::MethodCallExt;

pub struct SequencerChannel<R: RuntimeApi> {
    handler: SequencerHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for SequencerChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "getSequences" => {
                let sequences = self.get_sequences();

                resp.respond_msg(sequences);
            }
            "getSequence" => {
                if let Value::I64(sequence) = call.args {
                    if let Some(sequence) = self.get_sequence(sequence as u32) {
                        resp.respond_msg(sequence);
                    }
                }
            }
            "deleteSequence" => {
                if let Value::I64(sequence) = call.args {
                    match self.delete_sequence(sequence as u32) {
                        Ok(sequence) => resp.respond_msg(sequence),
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            "addSequence" => {
                let sequence = self.add_sequence();

                resp.respond_msg(sequence);
            }
            "sequenceGo" => {
                if let Value::I64(sequence) = call.args {
                    self.sequence_go(sequence as u32);

                    resp.send_ok(Value::Null);
                }
            }
            "updateCueTrigger" => {
                let result = call.arguments().map(|req| self.update_cue_trigger(req));
                resp.respond_result(result);
            }
            "updateCueName" => {
                let result = call.arguments().map(|req| self.update_cue_name(req));
                resp.respond_result(result);
            }
            "getSequencerPointer" => match self.get_sequencer_pointer() {
                Ok(ptr) => resp.send_ok(Value::I64(ptr)),
                Err(err) => resp.respond_error(err),
            },
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> SequencerChannel<R> {
    pub fn new(handler: SequencerHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/sequencer", self)
    }

    pub fn get_sequences(&self) -> Sequences {
        self.handler.get_sequences()
    }

    pub fn get_sequence(&self, sequence_id: u32) -> Option<Sequence> {
        self.handler.get_sequence(sequence_id)
    }

    pub fn add_sequence(&self) -> Sequence {
        self.handler.add_sequence()
    }

    pub fn sequence_go(&self, sequence: u32) {
        self.handler.sequence_go(sequence);
    }

    pub fn delete_sequence(&self, sequence_id: u32) -> anyhow::Result<Sequences> {
        self.handler.delete_sequence(sequence_id)?;

        Ok(self.get_sequences())
    }

    pub fn update_cue_trigger(&self, request: CueTriggerRequest) -> Sequences {
        self.handler.update_cue_trigger(request);

        self.get_sequences()
    }

    pub fn update_cue_name(&self, request: CueNameRequest) -> Sequences {
        self.handler.update_cue_name(request);

        self.get_sequences()
    }

    fn get_sequencer_pointer(&self) -> anyhow::Result<i64> {
        let view = self.handler.sequencer_view();
        let sequencer = Sequencer { view };
        let sequencer = Arc::new(sequencer);

        Ok(sequencer.to_pointer() as i64)
    }
}
