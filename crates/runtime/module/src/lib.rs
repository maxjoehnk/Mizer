use std::time::Duration;

pub use mizer_processing::*;

pub trait Module {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()>;
}

pub trait Runtime {
    fn injector_mut(&mut self) -> &mut Injector;

    fn injector(&self) -> &Injector;

    fn add_processor(&mut self, processor: impl DebuggableProcessor + 'static);

    fn process(&mut self);

    fn add_status_message(&self, message: impl Into<String>, timeout: Option<Duration>);
}
