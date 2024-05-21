use nativeshell::codec::{MethodCall, MethodCallReply, Value};
use nativeshell::shell::{Context, EngineHandle, MethodCallHandler, MethodChannel};

use mizer_api::handlers::SettingsHandler;
use mizer_api::RuntimeApi;

use crate::plugin::channels::MethodReplyExt;
use crate::{LifecycleHandler, MethodCallExt};

pub struct ApplicationChannel<LH: LifecycleHandler + 'static, R: RuntimeApi> {
    handler: SettingsHandler<R>,
    lifecycle_handler: Option<LH>,
}

impl<LH: LifecycleHandler + 'static, R: RuntimeApi + 'static> MethodCallHandler
    for ApplicationChannel<LH, R>
{
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        reply: MethodCallReply<Value>,
        _: EngineHandle,
    ) {
        match call.method.as_str() {
            "shutdown" => {
                tracing::info!("Triggering shutdown");
                if let Err(err) = system_shutdown::shutdown() {
                    reply.respond_error(err.into());
                } else {
                    reply.send_ok(Value::Null);
                }
            }
            "reboot" => {
                tracing::info!("Triggering reboot");
                if let Err(err) = system_shutdown::reboot() {
                    reply.respond_error(err.into());
                } else {
                    reply.send_ok(Value::Null);
                }
            }
            "exit" => {
                tracing::info!("Exiting application");
                if let Some(handler) = self.lifecycle_handler.take() {
                    handler.shutdown();
                }
                reply.send_ok(Value::Null);
            }
            "loadSettings" => {
                let settings = self.handler.get_settings();

                reply.respond_msg(settings);
            }
            "saveSettings" => {
                if let Err(err) = call
                    .arguments()
                    .and_then(|args| self.handler.save_settings(args))
                {
                    reply.respond_error(err);
                } else {
                    reply.send_ok(Value::Null);
                }
            }
            "loadMidiDeviceProfiles" => {
                reply.respond_msg(self.handler.load_midi_device_profiles());
            }
            "reloadMidiDeviceProfiles" => {
                reply.respond_unit_result(self.handler.reload_midi_device_profiles());
            }
            _ => reply.not_implemented(),
        }
    }
}

impl<LH: LifecycleHandler + 'static, R: RuntimeApi + 'static> ApplicationChannel<LH, R> {
    pub fn new(handler: SettingsHandler<R>, lifecycle_handler: LH) -> Self {
        Self {
            handler,
            lifecycle_handler: Some(lifecycle_handler),
        }
    }

    pub fn channel(self, context: Context) -> MethodChannel {
        MethodChannel::new(context, "mizer.live/application", self)
    }
}
