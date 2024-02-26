use std::sync::Arc;

use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::ConnectionsHandler;
use mizer_api::proto::connections::*;
use mizer_api::RuntimeApi;
use mizer_ui_ffi::{ConnectionsRef, FFIToPointer, GamepadConnectionRef};

use crate::plugin::channels::MethodReplyExt;
use crate::MethodCallExt;

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
            "addArtnetOutput" => {
                if let Err(err) = call
                    .arguments()
                    .and_then(|args| self.add_artnet_output(args))
                {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addSacnOutput" => {
                if let Err(err) = call.arguments().and_then(|args| self.add_sacn_output(args)) {
                    resp.respond_error(err);
                } else {
                    resp.send_ok(Value::Null);
                }
            }
            "addArtnetInput" => {
                if let Err(err) = call
                    .arguments()
                    .and_then(|args| self.add_artnet_input(args))
                {
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
            "getGamepadPointer" => {
                if let Value::String(name) = call.args {
                    match self.get_gamepad_pointer(name) {
                        Ok(ptr) => resp.send_ok(Value::I64(ptr)),
                        Err(err) => resp.respond_error(err),
                    }
                }
            }
            "getConnectionsRef" => {
                let ptr = self.get_connections_pointer();
                resp.send_ok(Value::I64(ptr));
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

    fn add_artnet_output(&self, request: ArtnetOutputConfig) -> anyhow::Result<()> {
        self.handler
            .add_artnet_output(request.name, request.host, Some(request.port as u16))
    }

    fn add_artnet_input(&self, request: ArtnetInputConfig) -> anyhow::Result<()> {
        self.handler
            .add_artnet_input(request.name, request.host, Some(request.port as u16))
    }

    fn add_sacn_output(&self, request: SacnConfig) -> anyhow::Result<()> {
        self.handler
            .add_sacn_output(request.name, request.priority.clamp(0, 200) as u8)
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

    fn get_gamepad_pointer(&self, id: String) -> anyhow::Result<i64> {
        tracing::debug!("Acquiring state pointer for gamepad {id}");
        let gamepad = self
            .handler
            .get_gamepad_ref(id.clone())?
            .ok_or_else(|| anyhow::anyhow!("Unknown gamepad {id}"))?;
        let gamepad = GamepadConnectionRef(gamepad);
        let gamepad = Arc::new(gamepad);

        Ok(gamepad.to_pointer() as i64)
    }

    fn get_connections_pointer(&self) -> i64 {
        tracing::debug!("Acquiring pointer for connections");
        let device_manager = self.handler.get_device_manager();
        let connections_ref = ConnectionsRef(device_manager);
        let connections_ref = Arc::new(connections_ref);

        connections_ref.to_pointer() as i64
    }
}
