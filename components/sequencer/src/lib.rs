mod contracts;
mod cue;
pub mod effects;
mod module;
mod processor;
mod sequencer;
mod sequences;
mod state;
mod value;

pub use self::cue::*;
pub use self::effects::*;
pub use self::module::*;
pub use self::sequencer::{SequenceView, Sequencer, SequencerView};
pub use self::sequences::*;
pub use self::value::*;

#[cfg(test)]
mod tests {
    use mockall::predicate;
    use std::time::{Duration, Instant};
    use test_case::test_case;

    use crate::contracts::*;
    use crate::state::SequenceState;
    use crate::{Cue, CueChannel, EffectEngine, Sequence, SequencerTime};
    use mizer_fixtures::definition::FixtureFaderControl;
    use mizer_fixtures::FixtureId;

    #[test_case(FixtureId::Fixture(1), 1f64, FixtureFaderControl::Intensity)]
    #[test_case(FixtureId::SubFixture(1, 1), 1f64, FixtureFaderControl::Shutter)]
    fn sequence_with_one_cue_should_apply_channels(
        fixture_id: FixtureId,
        value: f64,
        control: FixtureFaderControl,
    ) {
        let mut context = TestContext::default();
        context
            .fixture_controller
            .expect_write()
            .once()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control.clone()),
                predicate::eq(value),
            )
            .return_const(());
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel::new(control, value, vec![fixture_id])],
            )],
            ..Default::default()
        };

        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test]
    fn sequence_with_two_cues_should_apply_both_cues() {
        let fixture_id = FixtureId::Fixture(1);
        let control = FixtureFaderControl::Intensity;
        let mut context = TestContext::default();
        context
            .fixture_controller
            .expect_write()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control.clone()),
                predicate::eq(1f64),
            )
            .once()
            .return_const(());
        context
            .fixture_controller
            .expect_write()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control.clone()),
                predicate::eq(0.5f64),
            )
            .once()
            .return_const(());
        let sequence = Sequence {
            cues: vec![
                Cue::new(
                    1,
                    Default::default(),
                    vec![CueChannel::new(control.clone(), 1f64, vec![fixture_id])],
                ),
                Cue::new(
                    2,
                    Default::default(),
                    vec![CueChannel::new(control, 0.5f64, vec![fixture_id])],
                ),
            ],
            ..Default::default()
        };

        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );
        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test_case((0f64, 1f64), vec![0f64, 1f64])]
    #[test_case((0.5f64, 1f64), vec![0.5f64, 0.75f64, 1f64])]
    fn sequence_with_value_range_should_spread_values(value: (f64, f64), expected: Vec<f64>) {
        let control = FixtureFaderControl::Intensity;
        let mut context = TestContext::default();
        let fixture_ids = expected
            .iter()
            .enumerate()
            .map(|(i, _)| FixtureId::Fixture(i as u32))
            .collect();
        for (i, value) in expected.into_iter().enumerate() {
            context
                .fixture_controller
                .expect_write()
                .once()
                .with(
                    predicate::eq(FixtureId::Fixture(i as u32)),
                    predicate::eq(control.clone()),
                    predicate::eq(value),
                )
                .return_const(());
        }
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel::new(control, value, fixture_ids)],
            )],
            ..Default::default()
        };

        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test]
    fn sequence_with_delay_should_not_write_values() {
        let fixture_id = FixtureId::Fixture(1);
        let control = FixtureFaderControl::Intensity;
        let mut context = TestContext::default();
        context
            .fixture_controller
            .expect_write()
            .never()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control.clone()),
                predicate::always(),
            )
            .return_const(());
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel {
                    control,
                    value: 1f64.into(),
                    fixtures: vec![fixture_id],
                    delay: Some(SequencerTime::Seconds(1f64).into()),
                    fade: None,
                }],
            )],
            ..Default::default()
        };

        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test_case(2f64)]
    #[test_case(5f64)]
    fn sequence_with_delay_should_write_values_after_delay_has_passed(delay: f64) {
        let fixture_id = FixtureId::Fixture(1);
        let control = FixtureFaderControl::Intensity;
        let mut context = TestContext::default();
        context
            .fixture_controller
            .expect_write()
            .once()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control.clone()),
                predicate::eq(1f64),
            )
            .return_const(());
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel {
                    control: control.clone(),
                    value: 1f64.into(),
                    fixtures: vec![fixture_id],
                    delay: Some(SequencerTime::Seconds(delay).into()),
                    fade: None,
                }],
            )],
            ..Default::default()
        };
        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );
        context.forward_clock(delay);

        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test_case((0f64, 1f64), vec![true, false], 0.5f64)]
    #[test_case((0f64, 1f64), vec![true, false], 0f64)]
    #[test_case((0f64, 1f64), vec![true, false], 0.9f64)]
    #[test_case((0f64, 1f64), vec![true, true], 1f64)]
    #[test_case((0f64, 2f64), vec![true, true, false], 1f64)]
    fn sequence_with_delay_range_should_calculate_delay_for_each_fixture(
        delay: (f64, f64),
        fixtures: Vec<bool>,
        time: f64,
    ) {
        let mut context = TestContext::default();
        let control = FixtureFaderControl::Intensity;
        let value = 1f64;
        let fixture_ids = fixtures
            .iter()
            .enumerate()
            .map(|(i, _)| FixtureId::Fixture(i as u32))
            .collect();
        for (i, got_value) in fixtures.into_iter().enumerate() {
            if got_value {
                context
                    .fixture_controller
                    .expect_write()
                    .with(
                        predicate::eq(FixtureId::Fixture(i as u32)),
                        predicate::eq(control.clone()),
                        predicate::eq(value),
                    )
                    .return_const(());
            } else {
                context
                    .fixture_controller
                    .expect_write()
                    .never()
                    .with(
                        predicate::eq(FixtureId::Fixture(i as u32)),
                        predicate::always(),
                        predicate::always(),
                    )
                    .return_const(());
            }
        }
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel {
                    control: control.clone(),
                    value: value.into(),
                    fixtures: fixture_ids,
                    delay: Some(
                        (
                            SequencerTime::Seconds(delay.0),
                            SequencerTime::Seconds(delay.1),
                        )
                            .into(),
                    ),
                    fade: None,
                }],
            )],
            ..Default::default()
        };
        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );
        context.forward_clock(time);

        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test]
    fn sequence_with_fade_should_scale_value() {
        let fixture_id = FixtureId::Fixture(1);
        let control = FixtureFaderControl::Intensity;
        let mut context = TestContext::default();
        context
            .fixture_controller
            .expect_write()
            .once()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control.clone()),
                predicate::eq(0f64),
            )
            .return_const(());
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel {
                    control,
                    value: 1f64.into(),
                    fixtures: vec![fixture_id],
                    fade: Some(SequencerTime::Seconds(1f64).into()),
                    delay: None,
                }],
            )],
            ..Default::default()
        };

        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test_case(1f64, 2f64, 1f64, 0.5f64)]
    #[test_case(1f64, 2f64, 2f64, 1f64)]
    #[test_case(0.5f64, 5f64, 2.5f64, 0.25f64)]
    fn sequence_with_fade_should_write_interpolated_value(
        value: f64,
        fade_duration: f64,
        time: f64,
        expected: f64,
    ) {
        let fixture_id = FixtureId::Fixture(1);
        let control = FixtureFaderControl::Intensity;
        let mut context = TestContext::default();
        context
            .fixture_controller
            .expect_write()
            .once()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control.clone()),
                predicate::eq(0f64),
            )
            .return_const(());
        context
            .fixture_controller
            .expect_write()
            .once()
            .with(
                predicate::eq(fixture_id),
                predicate::eq(control.clone()),
                predicate::eq(expected),
            )
            .return_const(());
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel {
                    control: control.clone(),
                    value: value.into(),
                    fixtures: vec![fixture_id],
                    fade: Some(SequencerTime::Seconds(fade_duration).into()),
                    delay: None,
                }],
            )],
            ..Default::default()
        };
        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );
        context.forward_clock(time);

        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test_case((0f64, 1f64), vec![1f64, 0.5f64], 0.5f64)]
    #[test_case((0f64, 1f64), vec![1f64, 0f64], 0f64)]
    #[test_case((0f64, 1f64), vec![1f64, 0.9f64], 0.9f64)]
    #[test_case((0f64, 1f64), vec![1f64, 1f64], 1f64)]
    #[test_case((0f64, 2f64), vec![1f64, 1f64, 0.5f64], 1f64)]
    #[test_case((1f64, 2f64), vec![0.5f64, 0.25f64], 0.5f64)]
    #[test_case((1f64, 2f64), vec![0.0f64, 0f64], 0f64)]
    fn sequence_with_fade_range_should_calculate_fade_for_each_fixture(
        fade: (f64, f64),
        fixtures: Vec<f64>,
        time: f64,
    ) {
        let mut context = TestContext::default();
        let control = FixtureFaderControl::Intensity;
        let value = 1f64;
        let fixture_ids = fixtures
            .iter()
            .enumerate()
            .map(|(i, _)| FixtureId::Fixture(i as u32))
            .collect();
        context.fixture_controller.expect_write().return_const(());
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel {
                    control: control.clone(),
                    value: value.into(),
                    fixtures: fixture_ids,
                    fade: Some(
                        (
                            SequencerTime::Seconds(fade.0),
                            SequencerTime::Seconds(fade.1),
                        )
                            .into(),
                    ),
                    delay: None,
                }],
            )],
            ..Default::default()
        };
        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );
        context.forward_clock(time);
        context.fixture_controller.checkpoint();
        for (i, expected) in fixtures.into_iter().enumerate() {
            context
                .fixture_controller
                .expect_write()
                .with(
                    predicate::eq(FixtureId::Fixture(i as u32)),
                    predicate::eq(control.clone()),
                    predicate::eq(expected),
                )
                .return_const(());
        }

        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test]
    fn sequence_with_fade_and_delay_should_start_fade_after_delay() {
        let mut context = TestContext::default();
        let control = FixtureFaderControl::Intensity;
        let value = 1f64;
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel {
                    control: control.clone(),
                    value: value.into(),
                    fixtures: vec![FixtureId::Fixture(1)],
                    fade: Some(SequencerTime::Seconds(1f64).into()),
                    delay: Some(SequencerTime::Seconds(1f64).into()),
                }],
            )],
            ..Default::default()
        };
        context.fixture_controller.expect_write().never();
        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );
        context.fixture_controller.checkpoint();
        context.forward_clock(1f64);
        context
            .fixture_controller
            .expect_write()
            .once()
            .with(
                predicate::eq(FixtureId::Fixture(1)),
                predicate::eq(control.clone()),
                predicate::eq(0f64),
            )
            .return_const(());

        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    #[test_case((1f64, 2f64), (1f64, 2f64), vec![Some(0f64), None], 1f64)]
    #[test_case((1f64, 2f64), (1f64, 2f64), vec![Some(1f64), Some(0f64)], 2f64)]
    #[test_case((1f64, 2f64), (1f64, 2f64), vec![Some(1f64), Some(1f64)], 4f64)]
    fn sequence_with_fade_and_delay_ranges_should_start_fade_after_delay_for_each_fixture(
        fade: (f64, f64),
        delay: (f64, f64),
        expected: Vec<Option<f64>>,
        time: f64,
    ) {
        let mut context = TestContext::default();
        let control = FixtureFaderControl::Intensity;
        let fixture_ids = expected
            .iter()
            .enumerate()
            .map(|(i, _)| FixtureId::Fixture(i as u32))
            .collect();
        let sequence = Sequence {
            cues: vec![Cue::new(
                1,
                Default::default(),
                vec![CueChannel {
                    control: control.clone(),
                    value: 1f64.into(),
                    fixtures: fixture_ids,
                    fade: Some(
                        (
                            SequencerTime::Seconds(fade.0),
                            SequencerTime::Seconds(fade.1),
                        )
                            .into(),
                    ),
                    delay: Some(
                        (
                            SequencerTime::Seconds(delay.0),
                            SequencerTime::Seconds(delay.1),
                        )
                            .into(),
                    ),
                }],
            )],
            ..Default::default()
        };
        context.fixture_controller.expect_write().return_const(());
        context
            .state
            .go(&sequence, &context.clock, &context.effect_engine);
        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );
        context.fixture_controller.checkpoint();
        context.forward_clock(time);
        for (i, value) in expected.into_iter().enumerate() {
            let expectation = context.fixture_controller.expect_write();
            if let Some(value) = value {
                expectation
                    .once()
                    .with(
                        predicate::eq(FixtureId::Fixture(i as u32)),
                        predicate::eq(control.clone()),
                        predicate::eq(value),
                    )
                    .return_const(());
            } else {
                expectation.never().with(
                    predicate::eq(FixtureId::Fixture(i as u32)),
                    predicate::eq(control.clone()),
                    predicate::always(),
                );
            }
        }

        sequence.run(
            &mut context.state,
            &context.clock,
            &context.fixture_controller,
            &context.effect_engine,
        );

        context.fixture_controller.checkpoint();
    }

    struct TestContext {
        now: Instant,
        clock: MockClock,
        fixture_controller: MockFixtureController,
        state: SequenceState,
        effect_engine: EffectEngine,
    }

    impl Default for TestContext {
        fn default() -> Self {
            let now = Instant::now();
            let mut context = TestContext {
                now,
                clock: Default::default(),
                fixture_controller: Default::default(),
                state: Default::default(),
                effect_engine: Default::default(),
            };
            context.clock.expect_now().return_const(now);

            context
        }
    }

    impl TestContext {
        fn forward_clock(&mut self, seconds: f64) {
            let trigger_time = self.now + Duration::from_secs_f64(seconds);
            self.clock.checkpoint();
            self.clock.expect_now().returning(move || trigger_time);
        }
    }
}
