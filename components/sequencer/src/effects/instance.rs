use crate::{Effect, Spline};
use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::selection::FixtureSelection;
use mizer_module::ClockFrame;
use std::collections::HashMap;

#[derive(Debug)]
pub(crate) struct EffectInstance {
    pub effect_id: u32,
    pub fixtures: FixtureSelection,
    effect: Effect,
    frame: f64,
    splines: HashMap<FixtureFaderControl, Spline>,
    pub rate: f64,
}

impl EffectInstance {
    pub fn new(effect: &Effect, fixtures: FixtureSelection, rate: f64) -> Self {
        Self {
            effect_id: effect.id,
            fixtures,
            effect: effect.clone(),
            frame: 0.,
            splines: effect.build_splines(),
            rate,
        }
    }

    pub fn process(
        &mut self,
        effect: &Effect,
        fixture_manager: &FixtureManager,
        frame: ClockFrame,
    ) {
        if effect != &self.effect {
            self.effect = effect.clone();
            self.splines = effect.build_splines();
        }
        profiling::scope!("EffectInstance::process");
        self.frame += frame.delta * self.rate;

        for (control, spline) in self.splines.iter() {
            if let Some(value) = spline.sample(self.frame) {
                let values = value.fixture_values(self.fixtures.total_fixtures());
                for (i, id) in self.fixtures.get_fixtures().iter().flatten().enumerate() {
                    fixture_manager.write_fixture_control(*id, control.clone(), values[i]);
                }
            } else {
                println!("no sample");
            }
        }
    }
}
