use mizer_debug_ui_impl::{DebugUiImpl, DebugUiPane};
use std::future::Future;

use mizer_module::{ApiInjector, EventProcessor, ModuleContext, Runtime};
use mizer_processing::Processor;
use mizer_runtime::DefaultRuntime;
use mizer_settings::Settings;
use mizer_status_bus::StatusHandle;

pub struct SetupContext {
    pub runtime: DefaultRuntime,
    pub api_injector: ApiInjector,
    pub settings: Settings,
    pub handle: tokio::runtime::Handle,
    pub debug_ui_panes: Vec<Box<dyn DebugUiPane<DebugUiImpl>>>,
    pub(crate) event_processors: Vec<Box<dyn EventProcessor>>,
}

impl ModuleContext for SetupContext {
    type DebugUiImpl = DebugUiImpl;

    fn provide<T: 'static>(&mut self, service: T) {
        self.runtime.injector_mut().provide(service);
    }

    fn try_get<T: 'static>(&self) -> Option<&T> {
        self.runtime.injector().get()
    }

    fn provide_api<T: 'static + Clone + Send + Sync>(&mut self, api: T) {
        self.api_injector.provide(api);
    }

    fn add_debug_ui_pane(&mut self, pane: impl DebugUiPane<Self::DebugUiImpl> + 'static) {
        self.debug_ui_panes.push(Box::new(pane));
    }

    fn add_processor(&mut self, processor: impl Processor + 'static) {
        self.runtime.add_processor(processor);
    }

    fn add_event_processor(&mut self, processor: impl EventProcessor + 'static) {
        self.event_processors.push(Box::new(processor));
    }

    fn settings(&self) -> &Settings {
        &self.settings
    }

    fn block_on<F: Future>(&self, future: F) -> F::Output {
        self.handle.block_on(future)
    }

    fn block_in_thread<A: 'static, F: Future + 'static>(&self, future_action: A)
    where
        A: FnOnce() -> F + Send,
    {
        let handle = self.handle.clone();
        std::thread::spawn(move || {
            let local = tokio::task::LocalSet::new();
            let future = future_action();
            local.spawn_local(future);

            handle.block_on(local);
        });
    }

    fn spawn<F: Future + Send + 'static>(&self, future: F)
    where
        <F as Future>::Output: Send,
    {
        self.handle.spawn(future);
    }

    fn status_handle(&self) -> StatusHandle {
        self.runtime.access().status_bus.handle()
    }
}

impl SetupContext {
    pub(crate) fn take_debug_ui_panes(&mut self) -> Vec<Box<dyn DebugUiPane<DebugUiImpl>>> {
        self.debug_ui_panes.drain(..).collect()
    }
}
