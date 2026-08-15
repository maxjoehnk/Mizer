use mizer_processing::*;

use crate::{CommandExecutor, InMainLoopExecutionWorker};

pub struct CommandProcessor {
    worker: InMainLoopExecutionWorker,
}

impl std::fmt::Debug for CommandProcessor {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("CommandProcessor").finish()
    }
}

impl CommandProcessor {
    pub(crate) fn new(worker: InMainLoopExecutionWorker) -> Self {
        Self { worker }
    }
}

impl Processor for CommandProcessor {
    #[tracing::instrument]
    fn pre_process(&mut self, injector: &mut Injector, _: ClockFrame, _fps: f64) {
        let (executor, injector) = injector.get_slice_mut::<CommandExecutor>().expect("Missing CommandExecutor in injector");
        if let Err(err) = self.worker.process_callbacks(executor, injector) {
            tracing::error!("Error processing commands {:?}", err);
        }
    }
}
