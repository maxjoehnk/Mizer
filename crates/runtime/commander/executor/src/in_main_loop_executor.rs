use crate::CommandExecutor;
use std::any::{type_name, Any};
use mizer_node::InjectionScope;

type WrappedCallback =
    Box<dyn FnOnce(&mut CommandExecutor, &InjectionScope) -> anyhow::Result<()> + Send + Sync>;

#[derive(Clone)]
pub(crate) struct InMainLoopExecutor(flume::Sender<WrappedCallback>);

impl InMainLoopExecutor {
    pub fn new() -> (Self, InMainLoopExecutionWorker) {
        let (sender, receiver) = flume::bounded(50);

        (Self(sender), InMainLoopExecutionWorker(receiver))
    }

    pub fn run_in_main_loop<T: Any + Send>(
        &self,
        callback: impl FnOnce(&mut CommandExecutor, &InjectionScope) -> T + Send + Sync + 'static,
    ) -> anyhow::Result<T> {
        let (return_channel_sender, return_channel_receiver) =
            flume::bounded::<Box<dyn Any + Send>>(1);
        let callback_wrapper = move |executor: &mut _, injector: &InjectionScope| {
            let result = callback(executor, injector);

            return_channel_sender
                .send(Box::new(result))
                .map_err(|_| anyhow::anyhow!("Executor dropped return channel"))
        };
        self.0.send(Box::new(callback_wrapper))?;

        let result = return_channel_receiver.recv()?;
        let result = result.downcast::<T>().map_err(|_| {
            anyhow::anyhow!(
                "Could not downcast result to expected type {}",
                type_name::<T>()
            )
        })?;

        Ok(*result)
    }
}

pub(crate) struct InMainLoopExecutionWorker(flume::Receiver<WrappedCallback>);

impl InMainLoopExecutionWorker {
    pub fn process_callbacks(
        &mut self,
        executor: &mut CommandExecutor,
        injector: &InjectionScope,
    ) -> anyhow::Result<()> {
        while let Ok(callback) = self.0.try_recv() {
            callback(executor, injector)?;
        }

        Ok(())
    }
}
