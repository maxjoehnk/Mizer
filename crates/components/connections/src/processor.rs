use mizer_module::{ClockFrame, Inject, InjectionScope, InjectMut, Processor};

pub struct RemoteConnectionStorageProcessor;

impl Processor for RemoteConnectionStorageProcessor {
    fn pre_process(&mut self, injector: &InjectionScope<'_>, _frame: ClockFrame, _fps: f64) {
        let storage = injector.inject_mut::<crate::ConnectionStorage>();
        let view = injector.inject::<crate::ConnectionStorageView>();

        storage.process_handles();
        view.process_handles(storage);
        view.update_transmission_states(storage);
    }
}
