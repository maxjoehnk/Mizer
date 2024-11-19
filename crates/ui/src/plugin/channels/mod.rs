use anyhow::Error;
use nativeshell::codec::{MethodCall, MethodCallReply, Value};

pub use event::*;
pub use method::*;

mod event;
mod method;

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
        tracing::error!("{:?}", err);
        self.send_error("", Some(format!("{err:?}").as_str()), Value::Null);
    }

    fn not_implemented(self) {
        todo!()
    }
}

trait MessageExt {
    fn into_value(self) -> Value;
}

impl<T: mizer_api::Message> MessageExt for T {
    fn into_value(self) -> Value {
        let msg = self.encode_to_vec();

        Value::U8List(msg)
    }
}
