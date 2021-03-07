pub use mizer_injector::Injector;

pub trait Processor {
    fn process(&self, injector: &Injector) {}
    fn post_process(&self, injector: &Injector) {}
}

impl<T: Processor + 'static> From<T> for Box<dyn Processor>
where
    Self: Sized,
{
    fn from(processor: T) -> Self {
        Box::new(processor)
    }
}
