use mizer_processing::{Processor, Injector};

pub trait Module {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()>;
}

pub trait Runtime {
    fn injector(&mut self) -> &mut Injector;

    fn add_processor(&mut self, processor: Box<dyn Processor>);

    fn process(&mut self);
}
