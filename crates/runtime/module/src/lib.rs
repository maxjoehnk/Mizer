use serde::de::DeserializeOwned;
use serde::Serialize;
use std::fmt::Display;
use std::future::Future;
use std::time::Duration;

pub use mizer_processing::*;
pub use mizer_settings::*;
use mizer_status_bus::StatusHandle;

pub use crate::api_injector::ApiInjector;

mod api_injector;

pub trait ProjectHandler {
    fn get_name(&self) -> &'static str;

    fn new_project(
        &mut self,
        context: &mut impl ProjectHandlerContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()>;
    fn load_project(
        &mut self,
        context: &mut impl LoadProjectContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()>;
    fn save_project(
        &self,
        context: &mut impl SaveProjectContext,
        injector: &dyn InjectDyn,
    ) -> anyhow::Result<()>;
}

pub trait ProjectHandlerContext {
    fn report_issue(&mut self, issue: impl Into<String>);
}

pub trait LoadProjectContext: ProjectHandlerContext {
    fn read_file<T: DeserializeOwned>(&self, filename: &str) -> anyhow::Result<T>;
}

pub trait SaveProjectContext: ProjectHandlerContext {
    fn write_file<T: Serialize>(&mut self, filename: &str, content: T) -> anyhow::Result<()>;
}

pub trait Module: Sized + Display {
    const IS_REQUIRED: bool;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()>;

    fn try_load<TContext: ModuleContext>(
        self,
        context: &mut TContext,
    ) -> ModuleLoadResult<TContext> {
        let span = tracing::info_span!("{module}::try_load");
        let _ = span.enter();
        let module = self.to_string();
        tracing::debug!("Registering {module}...");
        if let Err(err) = self.register(context) {
            tracing::error!("Failed to load module: {module}: {err:?}");
            if Self::IS_REQUIRED {
                panic!("Failed to load required module: {module}: {err:?}");
            }

            ModuleLoadResult::Failed
        } else {
            tracing::info!("Registered {module}.");

            ModuleLoadResult::Loaded(context)
        }
    }
}

#[derive(Debug)]
pub enum ModuleLoadResult<'a, T: ModuleContext> {
    Loaded(&'a mut T),
    Failed,
}

impl<'a, T: ModuleContext> ModuleLoadResult<'a, T> {
    pub fn then(self, other: impl Module) -> ModuleLoadResult<'a, T> {
        match self {
            ModuleLoadResult::Loaded(context) => other.try_load(context),
            ModuleLoadResult::Failed => ModuleLoadResult::Failed,
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

    fn add_processor(&mut self, processor: impl Processor + 'static);

    fn process(&mut self);

    fn add_status_message(&self, message: impl Into<String>, timeout: Option<Duration>);

    fn fps(&self) -> f64;

    fn set_fps(&mut self, fps: f64);
}

pub trait ModuleContext {
    type DebugUiImpl: DebugUi;

    fn provide<T: 'static>(&mut self, service: T);
    fn try_get<T: 'static>(&self) -> Option<&T>;
    fn provide_api<T: 'static + Clone + Send + Sync>(&mut self, api: T);

    fn add_debug_ui_pane(&mut self, pane: impl DebugUiPane<Self::DebugUiImpl> + 'static);

    fn add_processor(&mut self, processor: impl Processor + 'static);

    fn settings(&self) -> &Settings;

    fn block_on<F: Future>(&self, future: F) -> F::Output;
    fn block_in_thread<A: 'static, F: Future + 'static>(&self, future_action: A)
    where
        A: FnOnce() -> F + Send;
    fn spawn<F: Future + Send + 'static>(&self, future: F)
    where
        <F as Future>::Output: Send;

    fn status_handle(&self) -> StatusHandle;

    fn add_project_handler(&mut self, handler: impl ProjectHandler + 'static);
}
