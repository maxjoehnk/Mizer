use mizer_module::{ClockFrame, InjectionScope, InjectMut};
use mizer_processing::Processor;

use crate::CitpConnectionManager;

pub struct UpdatedCitpConnectionProcessor;

impl Processor for UpdatedCitpConnectionProcessor {
    fn pre_process(&mut self, injector: &InjectionScope<'_>, _frame: ClockFrame, _fps: f64) {
        let Some(manager) = injector.try_inject_mut::<CitpConnectionManager>() else {
            return;
        };
        manager.process_updates();
    }
}
