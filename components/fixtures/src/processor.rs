use crate::manager::FixtureManager;
use mizer_processing::*;
use mizer_protocol_dmx::DmxConnectionManager;

pub struct FixtureProcessor;

impl Processor for FixtureProcessor {
    fn pre_process(&self, injector: &Injector, _: ClockFrame) {
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("fixture processor without fixture manager");
        fixture_manager.default_fixtures();
        fixture_manager.execute_programmers();
    }

    fn process(&self, injector: &Injector, _: ClockFrame) {
        profiling::scope!("FixtureProcessor::process");
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("fixture processor without fixture manager");
        let dmx_manager = injector
            .get::<DmxConnectionManager>()
            .expect("fixture processor without dmx module");
        fixture_manager.write_outputs(dmx_manager);
    }
}
