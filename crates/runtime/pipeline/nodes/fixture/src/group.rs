use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::{FixturePriority, GroupId};
use mizer_node::edge::Edge;
use mizer_node::*;

use crate::fixture_ports::*;

const CALL_PORT: &str = "Call";
const ACTIVE_PORT: &str = "Active";

const GROUP_ID_SETTING: &str = "Group";
const PRIORITY_SETTING: &str = "Priority";
const SEND_ZERO_SETTING: &str = "Send Zero";

#[derive(Default, Clone, Deserialize, Serialize)]
pub struct GroupNode {
    pub id: GroupId,
    #[serde(default)]
    pub priority: FixturePriority,
    #[serde(default = "default_send_zero")]
    pub send_zero: bool,
}

fn default_send_zero() -> bool {
    true
}

impl std::fmt::Debug for GroupNode {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct(stringify!(GroupNode))
            .field("id", &self.id)
            .field("priority", &self.priority)
            .field("send_zero", &self.send_zero)
            .finish()
    }
}

impl PartialEq for GroupNode {
    fn eq(&self, other: &Self) -> bool {
        self.id == other.id && self.priority == other.priority && self.send_zero == other.send_zero
    }
}

impl ConfigurableNode for GroupNode {
    fn settings(&self, injector: &dyn InjectDyn) -> Vec<NodeSetting> {
        let manager = injector.inject::<FixtureManager>();
        let groups = manager
            .get_groups()
            .into_iter()
            .map(|group| IdVariant {
                value: group.id.into(),
                label: group.name.clone(),
            })
            .collect();

        vec![
            setting!(id GROUP_ID_SETTING, self.id, groups).disabled(),
            setting!(enum PRIORITY_SETTING, self.priority),
            setting!(SEND_ZERO_SETTING, self.send_zero),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(enum setting, PRIORITY_SETTING, self.priority);
        update!(bool setting, SEND_ZERO_SETTING, self.send_zero);

        update_fallback!(setting)
    }
}

impl PipelineNode for GroupNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Group".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
        }
    }

    fn display_name(&self, injector: &dyn InjectDyn) -> String {
        if let Some(group) = injector
            .try_inject::<FixtureManager>()
            .and_then(|manager| manager.groups.get(&self.id))
        {
            format!("Group ({})", group.name)
        } else {
            format!("Group (ID {})", self.id)
        }
    }

    // TODO: nodes need a way to notify the pipeline of new ports
    fn list_ports(&self, injector: &dyn InjectDyn) -> Vec<(PortId, PortMetadata)> {
        let fixture_channels: Vec<_> =
            if let Some(fixture_manager) = injector.try_inject::<FixtureManager>() {
                fixture_manager
                    .get_group_fixture_controls(self.id)
                    .get_ports()
            } else {
                Default::default()
            };
        fixture_channels
            .into_iter()
            .chain(vec![
                input_port!(CALL_PORT, PortType::Single),
                output_port!(ACTIVE_PORT, PortType::Single),
            ])
            .collect()
    }

    fn node_type(&self) -> NodeType {
        NodeType::Group
    }
}

impl ProcessingNode for GroupNode {
    type State = Edge;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(fixture_manager) = context.try_inject::<FixtureManager>() {
            self.call_group(context, state, fixture_manager);
            self.write_to_fixtures(context, fixture_manager);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl GroupNode {
    fn call_group(
        &self,
        context: &impl NodeContext,
        state: &mut Edge,
        fixture_manager: &FixtureManager,
    ) {
        let mut programmer = fixture_manager.get_programmer();
        if let Some(group) = fixture_manager.groups.get(&self.id) {
            if let Some(value) = context.read_port(CALL_PORT) {
                if let Some(true) = state.update(value) {
                    programmer.select_group(group.value());
                }
            }
            let active = programmer.is_group_active(group.value());
            context.write_port(ACTIVE_PORT, if active { 1f64 } else { 0f64 });
        }
    }

    fn write_to_fixtures(&self, context: &impl NodeContext, fixture_manager: &FixtureManager) {
        let ports = fixture_manager
            .get_group_fixture_controls(self.id)
            .get_ports()
            .into_iter()
            .collect::<HashMap<_, _>>();

        write_ports(ports, context, self.send_zero, |control, value| {
            fixture_manager.write_group_control(self.id, control, value, self.priority)
        });
    }
}
