pub use self::application::*;
pub use self::fixtures::*;
pub use self::layouts::*;
pub use self::media::*;
pub use self::nodes::*;
pub use self::programmer::*;
pub use self::sequencer::*;
pub use self::transport::*;
pub use self::effects::*;
use anyhow::Error;
pub use event::connections::*;
pub use event::session::*;
pub use method::connections::*;
pub use method::session::*;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};

mod application;
mod event;
mod fixtures;
mod layouts;
mod media;
mod method;
mod nodes;
mod programmer;
mod sequencer;
mod transport;
mod effects;

pub trait MethodCallExt {
    fn arguments<T: protobuf::Message>(&self) -> anyhow::Result<T>;
}

pub trait MethodReplyExt {
    fn respond_result<M: protobuf::Message>(self, message: anyhow::Result<M>);

    fn respond_msg<M: protobuf::Message>(self, message: M);

    fn respond_error(self, err: anyhow::Error);

    fn not_implemented(self);
}

impl MethodCallExt for MethodCall<Value> {
    fn arguments<T: protobuf::Message>(&self) -> anyhow::Result<T> {
        if let Value::U8List(ref buffer) = self.args {
            let arg = T::parse_from_bytes(buffer)?;

            Ok(arg)
        } else {
            Err(anyhow::anyhow!("Invalid arguments"))
        }
    }
}

impl MethodReplyExt for MethodCallReply<Value> {
    fn respond_result<M: protobuf::Message>(self, response: anyhow::Result<M>) {
        let response: anyhow::Result<_> =
            response.and_then(|msg| msg.write_to_bytes().map_err(anyhow::Error::from));

        match response {
            Ok(response) => self.send_ok(Value::U8List(response)),
            Err(err) => self.respond_error(err),
        }
    }

    fn respond_msg<M: protobuf::Message>(self, message: M) {
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
