use std::collections::HashMap;

use mizer_fixtures::definition::FixtureFaderControl;
use mizer_fixtures::FixturePriority;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::selection::FixtureSelection;
use mizer_module::ClockFrame;

use crate::{Effect, SequencerTime, Spline};

#[derive(Debug)]
pub(crate) struct EffectInstance {
    pub effect_id: u32,
    pub fixtures: FixtureSelection,
    effect: Effect,
    frame: f64,
    splines: HashMap<FixtureFaderControl, Spline>,
    pub rate: f64,
    pub(crate) fixture_offset: Option<SequencerTime>,
    pub priority: FixturePriority,
}

impl EffectInstance {
    pub fn new(
        effect: &Effect,
        fixtures: FixtureSelection,
        rate: f64,
        fixture_offset: Option<SequencerTime>,
        priority: FixturePriority,
    ) -> Self {
        Self {
            effect_id: effect.id,
            fixtures,
            effect: effect.clone(),
            frame: 0.,
            splines: effect.build_splines(),
            rate,
            fixture_offset,
            priority,
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
            let fixture_groups = self.fixtures.get_fixtures();
            let group_count = fixture_groups.len();
            for (i, ids) in fixture_groups.into_iter().enumerate() {
                let group_frame = if let Some(SequencerTime::Beats(offset)) = self.fixture_offset {
                    self.frame + (offset * i as f64)
                } else {
                    self.frame
                };
                if let Some(value) = spline.sample(group_frame) {
                    let values = value.fixture_values(group_count);
                    for id in ids {
                        fixture_manager.write_fixture_control(
                            id,
                            control.clone(),
                            values[i],
                            self.priority,
                        );
                    }
                } else {
                    println!("no sample");
                }
            }
        }
    }
}
