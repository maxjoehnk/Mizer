use std::future::Future;

use mizer_module::*;
use mizer_processing::DebuggableProcessor;
use mizer_protocol_dmx::DmxModule;
use mizer_runtime::DefaultRuntime;
use mizer_settings::Settings;
use mizer_status_bus::StatusHandle;

pub fn build_runtime() -> DefaultRuntime {
    let mut runtime = DefaultRuntime::new();
    {
        let mut context = BenchModuleContext {
            runtime: &mut runtime,
        };
        DmxModule.register(&mut context).unwrap();
    }

    runtime
}

struct BenchModuleContext<'a> {
    runtime: &'a mut DefaultRuntime,
}

#[allow(unused_variables)]
impl<'a> ModuleContext for BenchModuleContext<'a> {
    fn provide<T: 'static>(&mut self, service: T) {
        self.runtime.injector_mut().provide(service);
    }

    fn try_get<T: 'static>(&self) -> Option<&T> {
        self.runtime.injector().get()
    }

    fn provide_api<T: 'static + Clone + Send + Sync>(&mut self, api: T) {}

    fn add_processor(&mut self, processor: impl DebuggableProcessor + 'static) {
        self.runtime.add_processor(processor);
    }

    fn settings(&self) -> &Settings {
        todo!()
    }

    fn block_on<F: Future>(&self, future: F) -> F::Output {
        todo!()
    }

    fn block_in_thread<A: 'static, F: Future + 'static>(&self, future_action: A)
    where
        A: FnOnce() -> F + Send,
    {
        todo!()
    }

    fn status_handle(&self) -> StatusHandle {
        todo!()
    }
}
