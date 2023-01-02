use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use crate::MethodCallExt;
use mizer_api::handlers::ConnectionsHandler;
use mizer_api::models::connections::*;
use mizer_api::RuntimeApi;

use crate::plugin::channels::MethodReplyExt;

#[derive(Clone)]
pub struct ConnectionsChannel<R: RuntimeApi> {
    handler: ConnectionsHandler<R>,
}

impl<R: RuntimeApi + 'static> MethodCallHandler for ConnectionsChannel<R> {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        resp: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "getConnections" => {
                let response = self.handler.get_connections();

                resp.respond_msg(response);
            }
            "getMidiDeviceProfiles" => {
                let response = self.handler.get_midi_device_profiles();

                resp.respond_msg(response);
            }
            "monitorDmx" => {
                if let Value::String(output_id) = call.args {
                    match self.handler.monitor_dmx(output_id) {
                        Ok(values) => {
                            let values = values
                                .into_iter()
                                .map(|(universe, channels)| {
                                    (
                                        Value::I64(universe as i64),
                                        Value::U8List(channels.to_vec()),
                                    )
                                })
                                .collect();
                            resp.send_ok(Value::Map(values));
                        }
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            "addArtnet" => {
                if let Err(err) = call.arguments().and_then(|args| self.add_artnet(args)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addSacn" => {
                if let Err(err) = call.arguments().and_then(|args| self.add_sacn(args)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addMqtt" => {
                if let Err(err) = call.arguments().and_then(|args| self.add_mqtt(args)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addOsc" => {
                if let Err(err) = call.arguments().and_then(|args| self.add_osc(args)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "deleteConnection" => {
                if let Err(err) = call
                    .arguments()
                    .and_then(|args| self.handler.delete_connection(args))
                {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "configureConnection" => {
                if let Err(err) = call
                    .arguments()
                    .and_then(|args| self.handler.configure_connection(args))
                {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            _ => resp.not_implemented(),
        }
    }
}

impl<R: RuntimeApi + 'static> ConnectionsChannel<R> {
    pub fn new(handler: ConnectionsHandler<R>) -> Self {
        Self { handler }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/connections", self)
    }

    fn add_artnet(&self, request: ArtnetConfig) -> anyhow::Result<()> {
        self.handler
            .add_artnet(request.name, request.host, Some(request.port as u16))
    }

    fn add_sacn(&self, request: SacnConfig) -> anyhow::Result<()> {
        self.handler.add_sacn(request.name)
    }

    fn add_mqtt(&self, request: MqttConnection) -> anyhow::Result<()> {
        self.handler
            .add_mqtt(request.url, request.username, request.password)
    }

    fn add_osc(&self, request: OscConnection) -> anyhow::Result<()> {
        self.handler.add_osc(
            request.output_address,
            request.output_port.try_into()?,
            request.input_port.try_into()?,
        )
    }
}
