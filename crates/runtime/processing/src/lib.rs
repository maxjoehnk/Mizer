use std::fmt::Debug;

pub use mizer_clock::ClockFrame;
pub use mizer_debug_ui::{DebugUi, DebugUiDrawHandle, DebugUiPane, NodeStateAccess};
pub use mizer_injector::{Inject, Injector};

pub trait Processor {
    fn pre_process(&mut self, _injector: &mut Injector, _frame: ClockFrame, _fps: f64) {}
    fn process(&mut self, _injector: &mut Injector, _frame: ClockFrame) {}
    fn post_process(&mut self, _injector: &mut Injector, _frame: ClockFrame) {}
}

impl<T: Processor + 'static> From<T> for Box<dyn Processor>
where
    Self: Sized,
{
    fn from(processor: T) -> Self {
        Box::new(processor)
    }
}

pub trait ProcessingContext: Debug {
    fn fps(&self) -> f64;
    fn master_clock(&self) -> ClockFrame;
    fn injector(&self) -> &Injector;
}
