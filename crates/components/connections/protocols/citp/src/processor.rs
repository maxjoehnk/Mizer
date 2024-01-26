use mizer_module::{ClockFrame, Injector};
use mizer_processing::{DebuggableProcessor, Processor};

use crate::CitpConnectionManager;

pub struct UpdatedCitpConnectionProcessor;

impl Processor for UpdatedCitpConnectionProcessor {
    fn pre_process(&mut self, injector: &mut Injector, _frame: ClockFrame, _fps: f64) {
        let Some(manager) = injector.get_mut::<CitpConnectionManager>() else {
            return;
        };
        manager.process_updates();
    }
}

impl DebuggableProcessor for UpdatedCitpConnectionProcessor {}
