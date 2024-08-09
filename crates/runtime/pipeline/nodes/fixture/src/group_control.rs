use mizer_fixtures::definition::{ColorChannel, FixtureControl, FixtureFaderControl};
use ringbuffer::{ConstGenericRingBuffer, RingBuffer};
use serde::{Deserialize, Serialize};

use crate::contracts::FixtureController;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixtureId, FixturePriority, GroupId};
use mizer_node::*;

const GROUP_SETTING: &str = "Group";
const CONTROL_SETTING: &str = "Control";
const PRIORITY_SETTING: &str = "Priority";
const SEND_ZERO_SETTING: &str = "Send Zero";
const PHASE_SETTING: &str = "Phase";
const FAN_SETTING: &str = "Fan";
const ASYMMETRICAL_SETTING: &str = "Asymmetrical";

const INPUT_VALUE_PORT: &str = "Value";
const INPUT_PHASE_PORT: &str = "Phase";
const INPUT_FAN_PORT: &str = "Fan";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct GroupControlNode {
    #[serde(rename = "group")]
    pub group_id: GroupId,
    #[serde(default)]
    pub priority: FixturePriority,
    #[serde(default = "default_send_zero")]
    pub send_zero: bool,
    pub control: FixtureControl,
    #[serde(default)]
    pub phase: i64,
    #[serde(default)]
    pub fan: f64,
    #[serde(default)]
    pub asymmetrical: bool,
}

impl Default for GroupControlNode {
    fn default() -> Self {
        Self {
            group_id: Default::default(),
            priority: FixturePriority::default(),
            send_zero: default_send_zero(),
            control: FixtureControl::Intensity,
            phase: Default::default(),
            fan: Default::default(),
            asymmetrical: false,
        }
    }
}

fn default_send_zero() -> bool {
    true
}

impl GroupControlNode {
    fn get_controls(
        &self,
        fixture_manager: &FixtureManager,
    ) -> impl Iterator<Item = FixtureControl> {
        fixture_manager
            .get_group_fixture_controls(self.group_id)
            .into_iter()
            .map(|(control, _)| control)
    }
}

impl ConfigurableNode for GroupControlNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        let mut groups: Vec<_> = fixture_manager
            .get_groups()
            .into_iter()
            .map(|group| IdVariant {
                value: group.id.into(),
                label: group.name.clone(),
            })
            .collect();
        groups.sort_by_key(|group| group.label.clone());
        let mut controls: Vec<_> = self
            .get_controls(fixture_manager)
            .map(|control| SelectVariant::from(control.to_string()))
            .collect();

        controls.sort();

        vec![
            setting!(id GROUP_SETTING, self.group_id, groups),
            setting!(select CONTROL_SETTING, self.control.to_string(), controls),
            setting!(enum PRIORITY_SETTING, self.priority),
            setting!(SEND_ZERO_SETTING, self.send_zero),
            setting!(PHASE_SETTING, self.phase)
                .min_hint(-100i64)
                .max_hint(100i64),
            setting!(FAN_SETTING, self.fan)
                .min_hint(-100f64)
                .max_hint(100f64),
            setting!(ASYMMETRICAL_SETTING, self.asymmetrical),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, GROUP_SETTING, self.group_id);
        update!(select setting, CONTROL_SETTING, self.control);
        update!(enum setting, PRIORITY_SETTING, self.priority);
        update!(bool setting, SEND_ZERO_SETTING, self.send_zero);
        update!(int setting, PHASE_SETTING, self.phase);
        update!(float setting, FAN_SETTING, self.fan);
        update!(bool setting, ASYMMETRICAL_SETTING, self.asymmetrical);

        update_fallback!(setting)
    }
}

impl PipelineNode for GroupControlNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Group Control".into(),
            preview_type: if self.control.is_color() {
                PreviewType::Color
            } else {
                PreviewType::History
            },
            category: NodeCategory::Fixtures,
        }
    }

    fn display_name(&self, injector: &Injector) -> String {
        if let Some(group) = injector
            .get::<FixtureManager>()
            .and_then(|manager| manager.get_group(self.group_id))
        {
            format!("Group Control ({} - {})", group.name, self.control)
        } else {
            format!("Group Control (ID {} - {})", self.group_id, self.control)
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        let value_port = if self.control.is_color() {
            input_port!(INPUT_VALUE_PORT, PortType::Color)
        } else {
            input_port!(INPUT_VALUE_PORT, PortType::Single)
        };

        vec![
            value_port,
            input_port!(INPUT_PHASE_PORT, PortType::Single),
            input_port!(INPUT_FAN_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::GroupControl
    }
}

impl ProcessingNode for GroupControlNode {
    type State = ControlBuffer<1024>;

    fn process(&self, context: &impl NodeContext, buffer: &mut Self::State) -> anyhow::Result<()> {
        let Some(manager) = context.try_inject::<FixtureManager>() else {
            tracing::warn!("missing fixture module");
            return Ok(());
        };

        if self.group_id == GroupId::default() {
            return Ok(());
        }
        if manager.get_group(self.group_id).is_none() {
            tracing::error!("could not find group for id {}", self.group_id);
            return Ok(());
        };

        let phase = context
            .single_input(INPUT_PHASE_PORT)
            .read()
            .map(|v| v.round() as i64)
            .unwrap_or(self.phase);

        let fan = context
            .single_input(INPUT_FAN_PORT)
            .read()
            .unwrap_or(self.fan);

        if self.control.is_color() {
            if !matches!(&buffer, ControlBuffer::Color(_)) {
                *buffer = ControlBuffer::color();
            }
            let ControlBuffer::Color(buffer) = buffer else {
                unreachable!("ControlBuffer got changed to color but somehow changed back");
            };
            if let Some(value) = context.color_input(INPUT_VALUE_PORT).read() {
                buffer.push(value);
                context.write_color_preview(value);
            } else {
                buffer.clear();
            }
            self.write(
                manager,
                buffer.iter().map(|c| c.red),
                FixtureFaderControl::ColorMixer(ColorChannel::Red),
                phase,
                fan,
            );
            self.write(
                manager,
                buffer.iter().map(|c| c.green),
                FixtureFaderControl::ColorMixer(ColorChannel::Green),
                phase,
                fan,
            );
            self.write(
                manager,
                buffer.iter().map(|c| c.blue),
                FixtureFaderControl::ColorMixer(ColorChannel::Blue),
                phase,
                fan,
            );
        } else {
            if !matches!(&buffer, ControlBuffer::Single(_)) {
                *buffer = ControlBuffer::single();
            }
            let ControlBuffer::Single(buffer) = buffer else {
                unreachable!("ControlBuffer got changed to single but somehow changed back");
            };
            let reader = context.single_input(INPUT_VALUE_PORT);
            if let Some(value) = reader.read() {
                buffer.push(value);
                context.push_history_value(value);
            } else {
                buffer.clear();
            }
            for fader_control in self.control.clone().faders() {
                self.write(manager, buffer.iter().copied(), fader_control, phase, fan);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        if self.control.is_color() {
            ControlBuffer::color()
        } else {
            ControlBuffer::single()
        }
    }
}

impl GroupControlNode {
    fn write(
        &self,
        manager: &impl FixtureController,
        buffer: impl DoubleEndedIterator<Item = f64>,
        control: FixtureFaderControl,
        phase: i64,
        fan: f64,
    ) {
        if phase == 0 && fan == 0. {
            if let Some(value) = buffer.last() {
                if value.is_high() || self.send_zero {
                    manager.write_group_control(self.group_id, control, value, self.priority);
                }
            }
        } else if fan.is_normal() && phase == 0 {
            let Some(value) = buffer.last() else {
                return;
            };
            let groups = manager.get_group_fixture_ids(self.group_id);
            if groups.is_empty() {
                return;
            }
            let chunk_size = groups.len() / 2;
            let step = fan / (chunk_size as f64);

            if groups.len() % 2 == 0 {
                let (first, second) = groups.split_at(chunk_size);
                if fan > 0. {
                    if self.asymmetrical {
                        self.write_fanned(
                            manager,
                            first.iter().rev(),
                            value,
                            -step,
                            control.clone(),
                        );
                        self.write_fanned(manager, second.iter(), value, step, control.clone());
                    } else {
                        self.write_fanned(
                            manager,
                            first.iter().rev(),
                            value,
                            step,
                            control.clone(),
                        );
                        self.write_fanned(manager, second.iter(), value, step, control.clone());
                    }
                } else {
                    if self.asymmetrical {
                        self.write_fanned(
                            manager,
                            first.iter().rev(),
                            value,
                            -step,
                            control.clone(),
                        );
                        self.write_fanned(manager, second.iter(), value, step, control.clone());
                    } else {
                        self.write_fanned(manager, first.iter(), value, -step, control.clone());
                        self.write_fanned(
                            manager,
                            second.iter().rev(),
                            value,
                            -step,
                            control.clone(),
                        );
                    }
                };
            } else {
                let chunk_size = groups.len() / 2;
                let (first, second) = groups.split_at(chunk_size);
                let (middle, second) = second.split_first().unwrap();
                if fan > 0. {
                    if self.asymmetrical {
                        self.write_fanned(
                            manager,
                            first.iter().rev(),
                            value + step,
                            -step,
                            control.clone(),
                        );
                        self.write_fanned(
                            manager,
                            second.iter(),
                            value - step,
                            step,
                            control.clone(),
                        );
                    } else {
                        self.write_fanned(
                            manager,
                            first.iter().rev(),
                            value - step,
                            step,
                            control.clone(),
                        );
                        self.write_fanned(
                            manager,
                            second.iter(),
                            value - step,
                            step,
                            control.clone(),
                        );
                    }
                    for id in middle {
                        manager.write_fixture_control(*id, control.clone(), value, self.priority);
                    }
                } else {
                    if self.asymmetrical {
                        self.write_fanned(
                            manager,
                            first.iter().rev(),
                            value + step,
                            -step,
                            control.clone(),
                        );
                        self.write_fanned(
                            manager,
                            second.iter(),
                            value - step,
                            step,
                            control.clone(),
                        );
                        for id in middle {
                            manager.write_fixture_control(
                                *id,
                                control.clone(),
                                value,
                                self.priority,
                            );
                        }
                    } else {
                        self.write_fanned(
                            manager,
                            first.iter(),
                            value + step,
                            -step,
                            control.clone(),
                        );
                        self.write_fanned(
                            manager,
                            second.iter().rev(),
                            value + step,
                            -step,
                            control.clone(),
                        );
                        for id in middle {
                            manager.write_fixture_control(
                                *id,
                                control.clone(),
                                value - fan,
                                self.priority,
                            );
                        }
                    }
                };
            }
        } else {
            let fixtures = manager.get_group_fixture_ids(self.group_id);
            if fixtures.is_empty() {
                return;
            }
            let phase_slots = phase.abs() + 1;
            let chunk_size = (fixtures.len() as f64 / phase_slots as f64).ceil() as usize;
            let fixtures = fixtures.chunks(chunk_size);
            let skip_values = phase_slots as f64 / fixtures.len() as f64;
            let skip_values = skip_values.floor() as usize;
            let buffer = buffer.rev().step_by(skip_values);
            if phase > 0 {
                self.write_phased(manager, fixtures, buffer, control);
            } else {
                self.write_phased(manager, fixtures.rev(), buffer, control);
            }
        }
    }

    fn write_phased<'a>(
        &self,
        manager: &impl FixtureController,
        fixtures: impl Iterator<Item = &'a [Vec<FixtureId>]>,
        buffer: impl Iterator<Item = f64>,
        control: FixtureFaderControl,
    ) {
        for (group, value) in fixtures.zip(buffer) {
            if value.is_high() || self.send_zero {
                for fixtures in group {
                    for id in fixtures {
                        manager.write_fixture_control(*id, control.clone(), value, self.priority);
                    }
                }
            }
        }
    }

    fn write_fanned<'a>(
        &self,
        manager: &impl FixtureController,
        groups: impl Iterator<Item = &'a Vec<FixtureId>>,
        value: f64,
        step_size: f64,
        control: FixtureFaderControl,
    ) {
        for (i, group) in groups.enumerate() {
            let value = value - (step_size * i as f64);
            for id in group {
                manager.write_fixture_control(*id, control.clone(), value, self.priority);
            }
        }
    }
}

pub enum ControlBuffer<const CAP: usize> {
    Color(ConstGenericRingBuffer<port_types::COLOR, CAP>),
    Single(ConstGenericRingBuffer<port_types::SINGLE, CAP>),
}

impl<const CAP: usize> ControlBuffer<CAP> {
    fn single() -> Self {
        Self::Single(Default::default())
    }

    fn color() -> Self {
        Self::Color(Default::default())
    }
}

#[cfg(test)]
mod tests {
    use crate::contracts::*;
    use crate::GroupControlNode;
    use mizer_fixtures::definition::FixtureFaderControl;
    use mizer_fixtures::FixturePriority;
    use mizer_fixtures::{FixtureId, GroupId};
    use mizer_node::*;
    use predicates::prelude::*;
    use ringbuffer::{ConstGenericRingBuffer, RingBuffer};
    use test_case::test_case;

    #[test_case(0f64, 1, FixturePriority::HIGH)]
    #[test_case(1f64, 2, FixturePriority::LOW)]
    fn write_should_write_value_to_group_when_phase_is_zero(
        value: f64,
        group_id: u32,
        priority: FixturePriority,
    ) {
        let group_id = GroupId(group_id);
        let node = GroupControlNode {
            group_id,
            priority,
            ..Default::default()
        };
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        buffer.push(value);
        controller
            .expect_write_group_control()
            .once()
            .with(
                predicate::eq(group_id),
                predicate::eq(FixtureFaderControl::Intensity),
                predicate::eq(value),
                predicate::eq(priority),
            )
            .return_const(());

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test_case(1f64, vec![0f64, 1f64])]
    #[test_case(0f64, vec![1f64, 2f64, 3f64, 0f64])]
    fn write_should_write_newest_value_to_group_when_phase_is_zero(
        expected: f64,
        values: Vec<f64>,
    ) {
        let node = GroupControlNode::default();
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        for v in values {
            buffer.push(v);
        }
        controller
            .expect_write_group_control()
            .once()
            .with(
                predicate::always(),
                predicate::always(),
                predicate::eq(expected),
                predicate::always(),
            )
            .return_const(());

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test]
    fn write_should_write_nothing_when_buffer_is_empty() {
        let node = GroupControlNode::default();
        let mut controller = MockFixtureController::new();
        let buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        controller.expect_write_group_control().never();

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test]
    fn write_should_write_nothing_when_value_is_zero_and_send_zero_is_false() {
        let node = GroupControlNode {
            send_zero: false,
            ..Default::default()
        };
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        buffer.push(0f64);
        controller.expect_write_group_control().never();

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test_case(vec![1, 2], vec![0.25, 0.75], vec![(1, 0.75), (2, 0.25)])]
    #[test_case(vec![10, 20], vec![0.5, 1.], vec![(10, 1.), (20, 0.5)])]
    #[test_case(vec![1, 2, 3, 4], vec![1., 2.], vec![(1, 2.), (2, 2.), (3, 1.), (4, 1.)])]
    #[test_case(vec![1, 2, 3, 4], vec![1.], vec![(1, 1.), (2, 1.)])]
    #[test_case(vec![1, 2, 3, 4], vec![], vec![])]
    fn write_should_spread_values_across_two_fixture_groups_when_phase_is_one(
        fixture_ids: Vec<u32>,
        values: Vec<f64>,
        expected: Vec<(u32, f64)>,
    ) {
        let fixtures = fixture_ids
            .into_iter()
            .map(|v| vec![FixtureId::Fixture(v)])
            .collect::<Vec<_>>();
        let node = GroupControlNode {
            phase: 1,
            ..Default::default()
        };
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        for v in values {
            buffer.push(v);
        }
        controller
            .expect_get_group_fixture_ids()
            .with(predicate::eq(node.group_id))
            .return_const(fixtures);
        for (id, value) in expected {
            controller
                .expect_write_fixture_control()
                .once()
                .with(
                    predicate::eq(FixtureId::Fixture(id)),
                    predicate::always(),
                    predicate::eq(value),
                    predicate::always(),
                )
                .return_const(());
        }

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test_case(vec![1, 2], vec![0.25, 0.75], vec![(1, 0.25), (2, 0.75)])]
    #[test_case(vec![10, 20], vec![0.5, 1.], vec![(10, 0.5), (20, 1.)])]
    #[test_case(vec![1, 2, 3, 4], vec![1., 2.], vec![(1, 1.), (2, 1.), (3, 2.), (4, 2.)])]
    #[test_case(vec![1, 2, 3, 4], vec![1.], vec![(3, 1.), (4, 1.)])]
    #[test_case(vec![1, 2, 3, 4], vec![], vec![])]
    fn write_should_spread_reversed_values_across_two_fixture_groups_when_phase_is_minus_one(
        fixture_ids: Vec<u32>,
        values: Vec<f64>,
        expected: Vec<(u32, f64)>,
    ) {
        let fixtures = fixture_ids
            .into_iter()
            .map(|v| vec![FixtureId::Fixture(v)])
            .collect::<Vec<_>>();
        let node = GroupControlNode {
            phase: -1,
            ..Default::default()
        };
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        for v in values {
            buffer.push(v);
        }
        controller
            .expect_get_group_fixture_ids()
            .with(predicate::eq(node.group_id))
            .return_const(fixtures);
        for (id, value) in expected {
            controller
                .expect_write_fixture_control()
                .once()
                .with(
                    predicate::eq(FixtureId::Fixture(id)),
                    predicate::always(),
                    predicate::eq(value),
                    predicate::always(),
                )
                .return_const(());
        }

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test_case(2, vec![1, 2, 3], vec![1., 2., 3.], vec![(1, 3.), (2, 2.), (3, 1.)])]
    #[test_case(3, vec![1, 2, 3, 4], vec![1., 2., 3., 4.], vec![(1, 4.), (2, 3.), (3, 2.), (4, 1.)])]
    fn write_should_spread_values_across_multiple_fixture_groups_when_phase_is_above_zero(
        phase: i64,
        fixture_ids: Vec<u32>,
        values: Vec<f64>,
        expected: Vec<(u32, f64)>,
    ) {
        let fixtures = fixture_ids
            .into_iter()
            .map(|v| vec![FixtureId::Fixture(v)])
            .collect::<Vec<_>>();
        let node = GroupControlNode {
            phase,
            ..Default::default()
        };
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        for v in values {
            buffer.push(v);
        }
        controller
            .expect_get_group_fixture_ids()
            .with(predicate::eq(node.group_id))
            .return_const(fixtures);
        for (id, value) in expected {
            controller
                .expect_write_fixture_control()
                .once()
                .with(
                    predicate::eq(FixtureId::Fixture(id)),
                    predicate::always(),
                    predicate::eq(value),
                    predicate::always(),
                )
                .return_const(());
        }

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test_case(2, vec![1, 2], vec![1., 2., 3., 4.], vec![(1, 4.), (2, 3.)])]
    #[test_case(3, vec![1, 2, 3], vec![1., 2., 3., 4.], vec![(1, 4.), (2, 3.), (3, 2.)])]
    #[test_case(7, vec![1, 2, 3, 4], vec![1., 2., 3., 4., 5., 6., 7., 8.], vec![(1, 8.), (2, 6.), (3, 4.), (4, 2.)])]
    fn write_should_spread_values_smooth_across_multiple_fixture_groups_when_phase_is_higher_than_fixture_count(
        phase: i64,
        fixture_ids: Vec<u32>,
        values: Vec<f64>,
        expected: Vec<(u32, f64)>,
    ) {
        let fixtures = fixture_ids
            .into_iter()
            .map(|v| vec![FixtureId::Fixture(v)])
            .collect::<Vec<_>>();
        let node = GroupControlNode {
            phase,
            ..Default::default()
        };
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        for v in values {
            buffer.push(v);
        }
        controller
            .expect_get_group_fixture_ids()
            .with(predicate::eq(node.group_id))
            .return_const(fixtures);
        for (id, value) in expected {
            controller
                .expect_write_fixture_control()
                .once()
                .with(
                    predicate::eq(FixtureId::Fixture(id)),
                    predicate::always(),
                    predicate::eq(value),
                    predicate::always(),
                )
                .return_const(());
        }

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test_case(1, FixtureFaderControl::Intensity)]
    #[test_case(2, FixtureFaderControl::Shutter)]
    #[test_case(-1, FixtureFaderControl::Pan)]
    fn write_should_write_to_right_control_when_phasing(phase: i64, control: FixtureFaderControl) {
        let node = GroupControlNode {
            phase,
            ..Default::default()
        };
        let fixtures = vec![vec![FixtureId::Fixture(1)], vec![FixtureId::Fixture(2)]];
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        buffer.push(1f64);
        buffer.push(2f64);
        controller
            .expect_get_group_fixture_ids()
            .return_const(fixtures);
        controller
            .expect_write_fixture_control()
            .times(2)
            .with(
                predicate::always(),
                predicate::eq(control.clone()),
                predicate::always(),
                predicate::always(),
            )
            .return_const(());

        node.write(
            &controller,
            buffer.iter().copied(),
            control,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test_case(1, FixturePriority::HIGH)]
    #[test_case(2, FixturePriority::LOW)]
    #[test_case(-1, FixturePriority::HTP)]
    fn write_should_write_with_right_priority_when_phasing(phase: i64, priority: FixturePriority) {
        let node = GroupControlNode {
            phase,
            priority,
            ..Default::default()
        };
        let fixtures = vec![vec![FixtureId::Fixture(1)], vec![FixtureId::Fixture(2)]];
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        buffer.push(1f64);
        buffer.push(2f64);
        controller
            .expect_get_group_fixture_ids()
            .return_const(fixtures);
        controller
            .expect_write_fixture_control()
            .times(2)
            .with(
                predicate::always(),
                predicate::always(),
                predicate::always(),
                predicate::eq(priority),
            )
            .return_const(());

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test]
    fn write_should_write_nothing_when_value_is_zero_and_send_zero_is_false_and_phase_is_not_zero()
    {
        let node = GroupControlNode {
            send_zero: false,
            phase: 1,
            ..Default::default()
        };
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        buffer.push(0f64);
        controller
            .expect_get_group_fixture_ids()
            .return_const(vec![vec![FixtureId::Fixture(0)]]);
        controller.expect_write_group_control().never();

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }

    #[test]
    fn write_should_write_same_value_to_multiple_fixtures_at_same_position_in_group() {
        let node = GroupControlNode {
            phase: 1,
            ..Default::default()
        };
        let fixtures = vec![
            vec![FixtureId::Fixture(1), FixtureId::Fixture(2)],
            vec![FixtureId::Fixture(3), FixtureId::Fixture(4)],
        ];
        let mut controller = MockFixtureController::new();
        let mut buffer = ConstGenericRingBuffer::<port_types::SINGLE, 1024>::new();
        buffer.push(1f64);
        buffer.push(2f64);
        controller
            .expect_get_group_fixture_ids()
            .return_const(fixtures);
        controller
            .expect_write_fixture_control()
            .once()
            .with(
                predicate::eq(FixtureId::Fixture(1)),
                predicate::always(),
                predicate::eq(2.),
                predicate::always(),
            )
            .return_const(());
        controller
            .expect_write_fixture_control()
            .once()
            .with(
                predicate::eq(FixtureId::Fixture(2)),
                predicate::always(),
                predicate::eq(2.),
                predicate::always(),
            )
            .return_const(());
        controller
            .expect_write_fixture_control()
            .once()
            .with(
                predicate::eq(FixtureId::Fixture(3)),
                predicate::always(),
                predicate::eq(1.),
                predicate::always(),
            )
            .return_const(());
        controller
            .expect_write_fixture_control()
            .once()
            .with(
                predicate::eq(FixtureId::Fixture(4)),
                predicate::always(),
                predicate::eq(1.),
                predicate::always(),
            )
            .return_const(());

        node.write(
            &controller,
            buffer.iter().copied(),
            FixtureFaderControl::Intensity,
            node.phase,
            node.fan,
        );

        controller.checkpoint();
    }
}
