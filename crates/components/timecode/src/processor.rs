use mizer_module::{ClockFrame, DebuggableProcessor, Injector, Processor};

use crate::TimecodeManager;

pub struct TimecodeProcessor(TimecodeManager);

impl TimecodeProcessor {
    pub(crate) fn new(manager: TimecodeManager) -> Self {
        Self(manager)
    }
}

impl Processor for TimecodeProcessor {
    fn pre_process(&mut self, _: &mut Injector, frame: ClockFrame) {
        self.0.advance_timecodes(frame);
    }
}

impl DebuggableProcessor for TimecodeProcessor {}
