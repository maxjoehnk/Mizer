use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::LerpExt;

const VALUE_INPUT: &str = "Input";
const VALUE_OUTPUT: &str = "Output";

const ATTACK_INPUT: &str = "Attack";
const DECAY_INPUT: &str = "Decay";
const SUSTAIN_INPUT: &str = "Sustain";
const RELEASE_INPUT: &str = "Release";

const ATTACK_SETTING: &str = "Attack";
const DECAY_SETTING: &str = "Decay";
const SUSTAIN_SETTING: &str = "Sustain";
const RELEASE_SETTING: &str = "Release";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct EnvelopeNode {
    pub attack: f64,
    pub decay: f64,
    pub sustain: f64,
    pub release: f64,
}

impl Default for EnvelopeNode {
    fn default() -> Self {
        Self {
            attack: 1.0,
            decay: 1.0,
            sustain: 0.5,
            release: 1.0,
        }
    }
}

impl ConfigurableNode for EnvelopeNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(ATTACK_SETTING, self.attack)
                .min(0f64)
                .max_hint(1f64),
            setting!(DECAY_SETTING, self.decay).min(0f64).max_hint(1f64),
            setting!(SUSTAIN_SETTING, self.sustain).min(0f64).max(1f64),
            setting!(RELEASE_SETTING, self.release)
                .min(0f64)
                .max_hint(1f64),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        match (setting.id.as_ref(), &setting.value) {
            (ATTACK_SETTING, NodeSettingValue::Float { value, .. }) => self.attack = *value,
            (DECAY_SETTING, NodeSettingValue::Float { value, .. }) => self.decay = *value,
            (RELEASE_SETTING, NodeSettingValue::Float { value, .. }) => self.release = *value,
            (SUSTAIN_SETTING, NodeSettingValue::Float { value, .. }) => self.sustain = *value,
            _ => return Err(anyhow::anyhow!("Invalid setting {setting:?}")),
        }

        Ok(())
    }
}

impl PipelineNode for EnvelopeNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Envelope".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(VALUE_INPUT, PortType::Single),
            output_port!(VALUE_OUTPUT, PortType::Single),
            input_port!(ATTACK_INPUT, PortType::Single),
            input_port!(DECAY_INPUT, PortType::Single),
            input_port!(SUSTAIN_INPUT, PortType::Single),
            input_port!(RELEASE_INPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Envelope
    }
}

impl ProcessingNode for EnvelopeNode {
    type State = EnvelopeState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let clock = context.clock();
        state.beat += clock.delta;

        let adsr = self.read_adsr(context);
        if let Some(value) = context.read_port(VALUE_INPUT) {
            state.calculate_phase(&adsr, value, clock.delta);
        }

        let value = match state.phase {
            EnvelopePhase::Attack { to, from } => {
                if adsr.attack == 0. {
                    to
                } else {
                    state.beat.linear_extrapolate((0., adsr.attack), (from, to))
                }
            }
            EnvelopePhase::Release { from } => {
                let release = if adsr.release == 0. {
                    0.0
                } else {
                    1. - state
                        .beat
                        .linear_extrapolate((0., adsr.release), (0., 1.))
                        .min(1.)
                };
                from * release
            }
            EnvelopePhase::Decay { from } => {
                if adsr.decay == 0. {
                    adsr.sustain
                } else {
                    let beat = state.beat - adsr.attack;
                    beat.linear_extrapolate((0., adsr.decay), (from, adsr.sustain))
                }
            }
            EnvelopePhase::Sustain => adsr.sustain,
        };
        context.write_port(VALUE_OUTPUT, value);
        context.push_history_value(value);
        state.previous_value = value;

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, state: &Self::State) {
        ui.label(format!("Beat: {}", state.beat));
        ui.label(format!("Phase Start: {}", state.phase_start));
        ui.label(format!("Phase: {:?}", state.phase));
        ui.label(format!("Previous value: {}", state.previous_value));
        ui.label(format!("Previous target: {}", state.previous_target));
    }
}

impl EnvelopeNode {
    fn read_adsr(&self, context: &impl NodeContext) -> ADSR {
        let attack = context
            .read_port(ATTACK_INPUT)
            .unwrap_or(self.attack);
        let decay = context
            .read_port(DECAY_INPUT)
            .unwrap_or(self.decay);
        let sustain = context
            .read_port(SUSTAIN_INPUT)
            .unwrap_or(self.sustain);
        let release = context
            .read_port(RELEASE_INPUT)
            .unwrap_or(self.release);

        let adsr = ADSR {
            attack,
            decay,
            sustain,
            release,
        };
        adsr
    }
}

struct ADSR {
    attack: f64,
    decay: f64,
    sustain: f64,
    release: f64,
}

#[derive(Default, Debug)]
pub struct EnvelopeState {
    beat: f64,
    phase: EnvelopePhase,
    previous_value: f64,
    phase_start: f64,
    previous_target: f64,
}

impl EnvelopeState {
    fn calculate_phase(&mut self, adsr: &ADSR, value: f64, delta: f64) {
        if (value - self.previous_target).abs() > f64::EPSILON {
            self.beat = delta;
        }
        self.previous_target = value;
        let is_high = value > 0.;
        let phase = if self.beat <= adsr.attack && is_high {
            EnvelopePhase::Attack {
                from: self.previous_value,
                to: value,
            }
        } else if matches!(self.phase, EnvelopePhase::Attack { .. } | EnvelopePhase::Decay { .. }) && self.beat <= self.phase_start + adsr.decay {
            EnvelopePhase::Decay {
                from: self.previous_value,
            }
        } else if is_high {
            EnvelopePhase::Sustain
        } else {
            EnvelopePhase::Release {
                from: self.previous_value,
            }
        };
        if !self.phase.is_same_phase(&phase) {
            tracing::debug!("Envelope phase changed from {:?} to {:?} at {}", self.phase, phase, self.beat);
            self.phase = phase;
            self.phase_start = self.beat;
            if let EnvelopePhase::Release { .. } = phase {
                // TODO: this is dangerous as it may discard frames which can cause drifting over time
                // self.beat = delta;
            }
        }
    }
}

#[derive(Debug, Copy, Clone)]
enum EnvelopePhase {
    Attack { from: f64, to: f64 },
    Decay { from: f64 },
    Release { from: f64 },
    Sustain,
}

impl EnvelopePhase {
    fn is_same_phase(&self, other: &Self) -> bool {
        match (self, other) {
            (EnvelopePhase::Attack { to: lhs, .. }, EnvelopePhase::Attack { to: rhs, .. }) => {
                (lhs - rhs).abs() < f64::EPSILON
            }
            (EnvelopePhase::Decay { .. }, EnvelopePhase::Decay { .. }) => true,
            (EnvelopePhase::Release { .. }, EnvelopePhase::Release { .. }) => true,
            (EnvelopePhase::Sustain, EnvelopePhase::Sustain) => true,
            _ => false,
        }
    }
}

impl Default for EnvelopePhase {
    fn default() -> Self {
        Self::Attack { from: 0., to: 0. }
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use mizer_node::mocks::*;

    use super::*;

    #[test_case(1.0)]
    #[test_case(0.5)]
    fn process_with_zero_adsr_should_immediately_emit_full_value(value: f64) -> anyhow::Result<()> {
        let node = EnvelopeNode {
            release: 0.,
            attack: 0.,
            decay: 0.,
            sustain: 1.,
        };
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame::default());
        context.when_read_port(VALUE_INPUT).returns(Some(value));

        node.process(&context, &mut state)?;

        context.expect_write_port(VALUE_OUTPUT, value);
        Ok(())
    }

    #[test_case(1., 0.5, 1.0, 0.5)]
    #[test_case(0.5, 0.5, 1.0, 1.0)]
    #[test_case(2., 1.0, 1.0, 0.5)]
    #[test_case(1., 0.5, 0.5, 0.25)]
    fn process_should_respect_attack(
        attack: f64,
        frame: f64,
        input: f64,
        expected: f64,
    ) -> anyhow::Result<()> {
        let node = EnvelopeNode {
            release: 0.,
            attack,
            decay: 0.,
            sustain: 1.,
        };
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame {
            frame,
            delta: frame,
            ..ClockFrame::default()
        });
        context.when_read_port(VALUE_INPUT).returns(Some(input));

        node.process(&context, &mut state)?;

        context.expect_write_port(VALUE_OUTPUT, expected);
        Ok(())
    }

    #[test]
    fn process_should_handle_attack_relative_to_later_frame() -> anyhow::Result<()> {
        let node = EnvelopeNode {
            release: 0.,
            attack: 1.,
            decay: 0.,
            sustain: 1.,
        };
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame {
            frame: 1.5,
            delta: 0.5,
            ..ClockFrame::default()
        });
        context.when_read_port(VALUE_INPUT).returns(Some(1.0));

        node.process(&context, &mut state)?;

        context.expect_write_port(VALUE_OUTPUT, 0.5);
        Ok(())
    }

    #[test]
    fn process_should_handle_attack_after_changed_input() -> anyhow::Result<()> {
        let node = EnvelopeNode {
            release: 0.,
            attack: 1.,
            decay: 0.,
            sustain: 1.,
        };
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame {
            frame: 0.5,
            delta: 0.5,
            ..ClockFrame::default()
        });
        context.when_read_port(VALUE_INPUT).returns(Some(0.5));
        node.process(&context, &mut state)?;
        context.when_clock().returns(ClockFrame {
            frame: 1.0,
            delta: 0.5,
            ..ClockFrame::default()
        });
        context.when_read_port(VALUE_INPUT).returns(Some(1.0));

        node.process(&context, &mut state)?;

        // TODO: this should probably be 0.75 as it should start at the previous value which was 0.25
        context.expect_write_port(VALUE_OUTPUT, 0.625);
        Ok(())
    }

    #[test_case(1.0, 0.0)]
    #[test_case(0.5, 0.5)]
    fn process_should_handle_release(frame: f64, expected: f64) -> anyhow::Result<()> {
        let node = EnvelopeNode {
            release: 1.,
            attack: 0.,
            decay: 0.,
            sustain: 1.,
        };
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame {
            frame: 0.0,
            delta: 0.0,
            ..ClockFrame::default()
        });
        context.when_read_port(VALUE_INPUT).returns(Some(1.0));
        node.process(&context, &mut state)?;
        context.when_read_port(VALUE_INPUT).returns(Some(0.0));
        context.when_clock().returns(ClockFrame {
            frame,
            delta: frame,
            ..ClockFrame::default()
        });

        node.process(&context, &mut state)?;

        context.expect_write_port(VALUE_OUTPUT, expected);
        Ok(())
    }

    #[test_case(1.0, 1.0, 1.0, 1.0)]
    #[test_case(1.0, 1.0, 0.5, 1.0)]
    #[test_case(0.5, 1.0, 0.5, 0.75)]
    #[test_case(0.5, 1.0, 1.0, 0.5)]
    #[test_case(0.5, 0.5, 0.5, 0.5)]
    fn process_should_handle_decay(
        sustain: f64,
        decay: f64,
        frame: f64,
        expected: f64,
    ) -> anyhow::Result<()> {
        let node = EnvelopeNode {
            release: 0.,
            attack: 0.,
            decay,
            sustain,
        };
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame {
            frame: 0.0,
            delta: 0.0,
            ..ClockFrame::default()
        });
        context.when_read_port(VALUE_INPUT).returns(Some(1.0));
        node.process(&context, &mut state)?;
        context.when_clock().returns(ClockFrame {
            frame,
            delta: frame,
            ..ClockFrame::default()
        });

        node.process(&context, &mut state)?;

        context.expect_write_port(VALUE_OUTPUT, expected);
        Ok(())
    }

    #[test_case(0.5, 0.5)]
    #[test_case(1.0, 1.0)]
    fn process_should_handle_sustain(sustain: f64, expected: f64) -> anyhow::Result<()> {
        let node = EnvelopeNode {
            release: 0.,
            attack: 0.,
            decay: 0.5,
            sustain,
        };
        let mut state = node.create_state();
        let mut context = NodeContextMock::new();
        context.when_clock().returns(ClockFrame {
            frame: 0.0,
            delta: 0.0,
            ..ClockFrame::default()
        });
        context.when_read_port(VALUE_INPUT).returns(Some(1.0));
        node.process(&context, &mut state)?;
        context.when_clock().returns(ClockFrame {
            frame: 1.0,
            delta: 1.0,
            ..ClockFrame::default()
        });

        node.process(&context, &mut state)?;

        context.expect_write_port(VALUE_OUTPUT, expected);
        Ok(())
    }
}
