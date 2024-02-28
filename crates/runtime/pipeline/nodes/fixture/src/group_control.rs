use mizer_fixtures::definition::{ColorChannel, FixtureControl, FixtureFaderControl};
use serde::{Deserialize, Serialize};

use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixturePriority, GroupId};
use mizer_node::*;

const GROUP_SETTING: &str = "Group";
const CONTROL_SETTING: &str = "Control";
const PRIORITY_SETTING: &str = "Priority";
const SEND_ZERO_SETTING: &str = "Send Zero";

const INPUT_VALUE_PORT: &str = "Value";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct GroupControlNode {
    #[serde(rename = "group")]
    pub group_id: u32,
    #[serde(default)]
    pub priority: FixturePriority,
    #[serde(default = "default_send_zero")]
    pub send_zero: bool,
    pub control: FixtureControl,
}

impl Default for GroupControlNode {
    fn default() -> Self {
        Self {
            group_id: 0,
            priority: FixturePriority::default(),
            send_zero: default_send_zero(),
            control: FixtureControl::Intensity,
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
            .get_group_fixture_controls(GroupId::from(self.group_id))
            .into_iter()
            .map(|(control, _)| control)
    }
}

impl ConfigurableNode for GroupControlNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        let groups = fixture_manager
            .get_groups()
            .into_iter()
            .map(|group| IdVariant {
                value: group.id.into(),
                label: group.name.clone(),
            })
            .collect();
        let controls = self
            .get_controls(fixture_manager)
            .map(|control| SelectVariant::from(control.to_string()))
            .collect();

        vec![
            setting!(id GROUP_SETTING, self.group_id, groups),
            setting!(select CONTROL_SETTING, self.control.to_string(), controls),
            setting!(enum PRIORITY_SETTING, self.priority),
            setting!(SEND_ZERO_SETTING, self.send_zero),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, GROUP_SETTING, self.group_id);
        update!(select setting, CONTROL_SETTING, self.control);
        update!(enum setting, PRIORITY_SETTING, self.priority);
        update!(bool setting, SEND_ZERO_SETTING, self.send_zero);

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
            .and_then(|manager| manager.get_group(GroupId::from(self.group_id)))
        {
            format!(
                "Group Control ({} - {})",
                group.name,
                self.control.to_string()
            )
        } else {
            format!(
                "Group Control (ID {} - {})",
                self.group_id,
                self.control.to_string()
            )
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        if self.control.is_color() {
            vec![input_port!(INPUT_VALUE_PORT, PortType::Color)]
        } else {
            vec![input_port!(INPUT_VALUE_PORT, PortType::Single)]
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::GroupControl
    }
}

impl ProcessingNode for GroupControlNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let Some(manager) = context.inject::<FixtureManager>() else {
            tracing::warn!("missing fixture module");
            return Ok(());
        };

        let group_id = GroupId::from(self.group_id);
        if manager.get_group(group_id).is_none() {
            tracing::error!("could not find group for id {}", self.group_id);
            return Ok(());
        };

        if self.control.is_color() {
            if let Some(value) = context.color_input(INPUT_VALUE_PORT).read() {
                manager.write_group_control(
                    group_id,
                    FixtureFaderControl::ColorMixer(ColorChannel::Red),
                    value.red,
                    self.priority,
                );
                manager.write_group_control(
                    group_id,
                    FixtureFaderControl::ColorMixer(ColorChannel::Green),
                    value.green,
                    self.priority,
                );
                manager.write_group_control(
                    group_id,
                    FixtureFaderControl::ColorMixer(ColorChannel::Blue),
                    value.blue,
                    self.priority,
                );
                context.write_color_preview(value);
            }
        } else {
            let reader = context.single_input(INPUT_VALUE_PORT);
            if reader.is_high().unwrap_or_default() || self.send_zero {
                if let Some(value) = context.single_input(INPUT_VALUE_PORT).read() {
                    for fader_control in self.control.clone().faders() {
                        manager.write_group_control(group_id, fader_control, value, self.priority);
                    }
                    context.push_history_value(value);
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
