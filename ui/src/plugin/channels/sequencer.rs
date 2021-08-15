use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::SequencerHandler;
use mizer_api::models::{Sequence, Sequences};

use crate::plugin::channels::MethodReplyExt;

pub struct SequencerChannel {
    handler: SequencerHandler,
}

impl MethodCallHandler for SequencerChannel {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        engine: EngineHandle,
    ) {
        match call.method.as_str() {
            "getSequences" => {
                let sequences = self.get_sequences();

                resp.respond_msg(sequences);
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
            _ => resp.not_implemented(),
        }
    }
}

impl SequencerChannel {
    pub fn new(handler: SequencerHandler) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/sequencer", self)
    }

    pub fn get_sequences(&self) -> Sequences {
        self.handler.get_sequences()
    }

    pub fn add_sequence(&self) -> Sequence {
        self.handler.add_sequence()
    }

    pub fn sequence_go(&self, sequence: u32) {
        self.handler.sequence_go(sequence);
    }
}
