pub use mizer_injector::Injector;

pub trait Processor {
    fn pre_process(&self, _injector: &Injector) {}
    fn process(&self, _injector: &Injector) {}
    fn post_process(&self, _injector: &Injector) {}
}

impl<T: Processor + 'static> From<T> for Box<dyn Processor>
where
    Self: Sized,
{
    fn from(processor: T) -> Self {
        Box::new(processor)
    }
}
