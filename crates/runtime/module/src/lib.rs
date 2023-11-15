use std::fmt::Display;
use std::future::Future;
use std::time::Duration;

pub use mizer_processing::*;
pub use mizer_settings::*;
use mizer_status_bus::StatusHandle;

pub use crate::api_injector::ApiInjector;

mod api_injector;

pub trait Module: Sized + Display {
    const IS_REQUIRED: bool;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()>;

    fn try_load(self, context: &mut impl ModuleContext) {
        let span = tracing::info_span!("{module}::try_load");
        let _ = span.enter();
        let module = self.to_string();
        tracing::debug!("Registering {module}...");
        if let Err(err) = self.register(context) {
            tracing::error!("Failed to load required module: {module}: {err:?}");
            if Self::IS_REQUIRED {
                panic!("Failed to load required module: {module}: {err:?}");
            }
        } else {
            tracing::info!("Registered {module}.");
        }
    }
}

#[macro_export]
macro_rules! module_name {
    ($module:ty) => {
        impl std::fmt::Display for $module {
            fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
                f.write_str(stringify!($module).trim())
            }
        }
    };
}

pub trait Runtime {
    fn injector_mut(&mut self) -> &mut Injector;

    fn injector(&self) -> &Injector;

    fn add_processor(&mut self, processor: impl DebuggableProcessor + 'static);

    fn process(&mut self);

    fn add_status_message(&self, message: impl Into<String>, timeout: Option<Duration>);

    fn fps(&self) -> f64;

    fn set_fps(&mut self, fps: f64);
}

pub trait ModuleContext {
    fn provide<T: 'static>(&mut self, service: T);
    fn try_get<T: 'static>(&self) -> Option<&T>;
    fn provide_api<T: 'static + Clone + Send + Sync>(&mut self, api: T);

    fn add_processor(&mut self, processor: impl DebuggableProcessor + 'static);

    fn settings(&self) -> &Settings;

    fn block_on<F: Future>(&self, future: F) -> F::Output;
    fn block_in_thread<A: 'static, F: Future + 'static>(&self, future_action: A)
    where
        A: FnOnce() -> F + Send;

    fn status_handle(&self) -> StatusHandle;
}
