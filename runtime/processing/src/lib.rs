pub use mizer_injector::Injector;
pub use mizer_clock::ClockFrame;

pub trait Processor {
    fn pre_process(&self, _injector: &Injector, _frame: ClockFrame) {}
    fn process(&self, _injector: &Injector, _frame: ClockFrame) {}
    fn post_process(&self, _injector: &Injector, _frame: ClockFrame) {}
}

impl<T: Processor + 'static> From<T> for Box<dyn Processor>
where
    Self: Sized,
{
    fn from(processor: T) -> Self {
        Box::new(processor)
    }
}
