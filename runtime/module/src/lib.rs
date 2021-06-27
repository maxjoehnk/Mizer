use mizer_processing::{Injector, Processor};

pub trait Module {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()>;
}

pub trait Runtime {
    fn injector_mut(&mut self) -> &mut Injector;

    fn injector(&self) -> &Injector;

    fn add_processor(&mut self, processor: Box<dyn Processor>);

    fn process(&mut self);
}
