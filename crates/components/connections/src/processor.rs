use mizer_module::{ClockFrame, Inject, Injector, Processor};

pub struct RemoteConnectionStorageProcessor;

impl Processor for RemoteConnectionStorageProcessor {
    fn pre_process(&mut self, injector: &mut Injector, _frame: ClockFrame, _fps: f64) {
        let (storage, injector) = injector.get_slice_mut::<crate::ConnectionStorage>().unwrap();
        let view = injector.inject::<crate::ConnectionStorageView>();

        storage.process_handles();
        view.process_handles(storage);
        view.update_transmission_states(storage);
    }
}
