use mizer_processing::{Processor, Injector};
use mizer_protocol_dmx::DmxConnectionManager;
use crate::manager::FixtureManager;

pub struct FixtureProcessor;

impl Processor for FixtureProcessor {
    fn process(&self, injector: &Injector) {
        let fixture_manager = injector.get::<FixtureManager>().expect("fixture processor without fixture manager");
        let dmx_manager = injector.get::<DmxConnectionManager>().expect("fixture processor without dmx module");
        fixture_manager.write_outputs(dmx_manager);
    }
}
