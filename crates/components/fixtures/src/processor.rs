use std::collections::HashMap;
use std::ops::Deref;

use mizer_processing::*;
use mizer_protocol_dmx::DmxConnectionManager;

use crate::definition::{ColorChannel, FixtureFaderControl};
use crate::fixture::IFixture;
use crate::manager::FixtureManager;
use crate::{FixtureId, FixtureState};

#[derive(Debug)]
pub struct FixtureProcessor;

impl Processor for FixtureProcessor {
    fn priorities(&self) -> ProcessorPriorities {
        ProcessorPriorities {
            pre_process: -100,
            post_process: 100,
            ..Default::default()
        }
    }

    #[tracing::instrument]
    fn pre_process(&mut self, injector: &mut Injector, _: ClockFrame, _fps: f64) {
        profiling::scope!("FixtureProcessor::pre_process");
        let fixture_manager = injector.inject::<FixtureManager>();
        fixture_manager.default_fixtures();
    }

    #[tracing::instrument]
    fn process(&mut self, injector: &mut Injector, _: ClockFrame) {
        profiling::scope!("FixtureProcessor::process");
        let fixture_manager = injector.inject::<FixtureManager>();
        fixture_manager.execute_programmers();
    }

    #[tracing::instrument]
    fn post_process(&mut self, injector: &mut Injector, _frame: ClockFrame) {
        profiling::scope!("FixtureProcessor::post_process");
        let fixture_manager = injector.inject::<FixtureManager>();
        let dmx_manager = injector.inject::<DmxConnectionManager>();
        fixture_manager.write_outputs(dmx_manager);
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
        fixture_manager
            .get_programmer()
            .emit_state(fixture_manager.get_groups());
    }
}

fn update_state(
    state: &mut HashMap<FixtureId, FixtureState>,
    id: FixtureId,
    fixture: &impl IFixture,
) {
    let fixture_state = state.entry(id).or_default();
    fixture_state.brightness = fixture.read_control(FixtureFaderControl::Intensity);
    let red = fixture.read_control(FixtureFaderControl::ColorMixer(ColorChannel::Red));
    let green = fixture.read_control(FixtureFaderControl::ColorMixer(ColorChannel::Green));
    let blue = fixture.read_control(FixtureFaderControl::ColorMixer(ColorChannel::Blue));
    fixture_state.color = red
        .zip(green)
        .zip(blue)
        .map(|((red, green), blue)| (red, green, blue));
}
