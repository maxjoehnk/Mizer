use crate::{Effect, Spline};
use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixtureId;
use mizer_module::ClockFrame;
use std::collections::HashMap;

#[derive(Debug)]
pub(crate) struct EffectInstance {
    pub effect: u32,
    pub fixtures: Vec<FixtureId>,
    frame: f64,
    splines: HashMap<FixtureFaderControl, Spline>,
}

impl EffectInstance {
    pub fn new(effect: &Effect, fixtures: Vec<FixtureId>) -> Self {
        Self {
            effect: effect.id,
            fixtures,
            frame: 0.,
            splines: effect.build_splines(),
        }
    }

    pub fn process(
        &mut self,
        effect: &Effect,
        fixture_manager: &FixtureManager,
        frame: ClockFrame,
    ) {
        profiling::scope!("EffectInstance::process");
        self.frame = frame.frame;

        for (control, spline) in self.splines.iter() {
            if let Some(value) = spline.sample(self.frame) {
                let values = value.fixture_values(self.fixtures.len());
                for (i, id) in self.fixtures.iter().enumerate() {
                    fixture_manager.write_fixture_control(*id, control.clone(), values[i]);
                }
            } else {
                println!("no sample");
            }
        }
    }
}
