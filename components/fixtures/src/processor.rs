use crate::definition::{ColorChannel, FixtureFaderControl};
use crate::fixture::IFixture;
use crate::manager::FixtureManager;
use crate::{FixtureId, FixtureState};
use mizer_processing::*;
use mizer_protocol_dmx::DmxConnectionManager;
use std::collections::HashMap;
use std::ops::Deref;

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

    fn post_process(&self, injector: &Injector, _frame: ClockFrame) {
        let fixture_manager = injector
            .get::<FixtureManager>()
            .expect("fixture processor without fixture manager");
        let mut state = fixture_manager.states.read();
        for fixture in fixture_manager.get_fixtures().iter() {
            update_state(&mut state, FixtureId::Fixture(fixture.id), fixture.deref());
            for sub_fixture in fixture.current_mode.sub_fixtures.iter() {
                let id = FixtureId::SubFixture(fixture.id, sub_fixture.id);
                if let Some(sub_fixture) = fixture.sub_fixture(sub_fixture.id) {
                    update_state(&mut state, id, &sub_fixture);
                }
            }
        }
        fixture_manager.states.write(state);
    }
}

fn update_state(
    state: &mut HashMap<FixtureId, FixtureState>,
    id: FixtureId,
    fixture: &impl IFixture,
) {
    let fixture_state = state.entry(id).or_default();
    fixture_state.brightness = fixture.read_control(FixtureFaderControl::Intensity);
    let red = fixture.read_control(FixtureFaderControl::Color(ColorChannel::Red));
    let green = fixture.read_control(FixtureFaderControl::Color(ColorChannel::Green));
    let blue = fixture.read_control(FixtureFaderControl::Color(ColorChannel::Blue));
    fixture_state.color = red
        .zip(green)
        .zip(blue)
        .map(|((red, green), blue)| (red, green, blue));
}
