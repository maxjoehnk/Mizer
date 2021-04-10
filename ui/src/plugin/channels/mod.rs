use flutter_engine::channel::MethodCall;

pub use self::fixtures::*;
pub use self::layouts::*;
pub use self::media::*;
pub use self::nodes::*;

mod fixtures;
mod layouts;
mod media;
mod nodes;

pub trait MethodCallExt {
    fn arguments<T: protobuf::Message>(&self) -> anyhow::Result<T>;

    fn respond_result<M: protobuf::Message>(self, message: anyhow::Result<M>);

    fn respond_msg<M: protobuf::Message>(self, message: M);

    fn respond_error(self, err: anyhow::Error);
}

impl MethodCallExt for MethodCall {
    fn arguments<T: protobuf::Message>(&self) -> anyhow::Result<T> {
        let buffer = self.args::<Vec<u8>>();
        let arg = protobuf::parse_from_bytes::<T>(&buffer)?;

        Ok(arg)
    }

    fn respond_result<M: protobuf::Message>(self, response: anyhow::Result<M>) {
        let response: anyhow::Result<_> = response.and_then(|msg| msg.write_to_bytes().map_err(anyhow::Error::from));

        match response {
            Ok(response) => self.success(response),
            Err(err) => self.respond_error(err),
        }
    }

    fn respond_msg<M: protobuf::Message>(self, message: M) {
        self.respond_result(Ok(message))
    }

    fn respond_error(self, err: anyhow::Error) {
        log::error!("{:?}", err);
        self.error("", err.to_string(), ());
    }
}
