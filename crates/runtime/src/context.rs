use std::fmt::{Debug, Formatter};

use mizer_clock::ClockFrame;
use mizer_processing::{Injector, ProcessingContext};

pub struct CoordinatorRuntimeContext<'a> {
    pub fps: f64,
    pub master_clock: ClockFrame,
    pub injector: &'a Injector,
}

impl<'a> Debug for CoordinatorRuntimeContext<'a> {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("CoordinatorRuntimeContext")
            .field("fps", &self.fps)
            .field("master_clock", &self.master_clock)
            .finish()
    }
}

impl<'a> ProcessingContext for CoordinatorRuntimeContext<'a> {
    fn fps(&self) -> f64 {
        self.fps
    }

    fn master_clock(&self) -> ClockFrame {
        self.master_clock
    }

    fn injector(&self) -> &Injector {
        self.injector
    }
}
