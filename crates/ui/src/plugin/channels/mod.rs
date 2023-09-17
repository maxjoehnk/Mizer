pub use self::effects::*;
pub use self::fixtures::*;
pub use self::layouts::*;
pub use self::media::*;
pub use self::nodes::*;
pub use self::programmer::*;
pub use self::sequencer::*;
pub use self::transport::*;
use anyhow::Error;
pub use event::application::*;
pub use event::history::*;
pub use event::midi_monitor::*;
pub use event::osc_monitor::*;
pub use event::session::*;
pub use method::application::*;
pub use method::connections::*;
pub use method::mappings::*;
pub use method::plans::*;
pub use method::session::*;
pub use method::status::*;
pub use method::timecode::*;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};

mod effects;
mod event;
mod fixtures;
mod layouts;
mod media;
mod method;
mod nodes;
mod programmer;
mod sequencer;
mod transport;

pub trait MethodCallExt {
    fn arguments<T: mizer_api::Message + Default>(&self) -> anyhow::Result<T>;
}

pub trait MethodReplyExt {
    fn respond_result<M: mizer_api::Message>(self, message: anyhow::Result<M>);

    fn respond_unit_result(self, response: anyhow::Result<()>);

    fn respond_msg<M: mizer_api::Message>(self, message: M);

    fn respond_error(self, err: anyhow::Error);

    fn not_implemented(self);
}

impl MethodCallExt for MethodCall<Value> {
    fn arguments<T: mizer_api::Message + Default>(&self) -> anyhow::Result<T> {
        if let Value::U8List(ref buffer) = self.args {
            let arg = T::decode(buffer.as_slice())?;

            Ok(arg)
        } else {
            Err(anyhow::anyhow!("Invalid arguments"))
        }
    }
}

impl MethodReplyExt for MethodCallReply<Value> {
    fn respond_result<M: mizer_api::Message>(self, response: anyhow::Result<M>) {
        let response: anyhow::Result<_> = response.map(|msg| msg.encode_to_vec());

        match response {
            Ok(response) => self.send_ok(Value::U8List(response)),
            Err(err) => self.respond_error(err),
        }
    }

    fn respond_unit_result(self, response: anyhow::Result<()>) {
        match response {
            Ok(_) => self.send_ok(Value::Null),
            Err(err) => self.respond_error(err),
        }
    }

    fn respond_msg<M: mizer_api::Message>(self, message: M) {
        self.respond_result(Ok(message))
    }

    fn respond_error(self, err: Error) {
        log::error!("{:?}", err);
        self.send_error("", Some(err.to_string().as_str()), Value::Null);
    }

    fn not_implemented(self) {
        todo!()
    }
}
