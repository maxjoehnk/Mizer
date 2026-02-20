use serde::{Deserialize, Serialize};

use mizer_fixtures::{FixtureId, GroupId};
use mizer_fixtures::manager::FixtureManager;
use mizer_node::*;
use crate::contracts::FixtureController;

const MASTER_INPUT_PORT: &str = "Master";

const GROUP_SETTING: &str = "Group";

#[derive(Debug, Default, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub struct GroupMasterNode {
    #[serde(rename = "group")]
    pub group_id: GroupId,
}

impl ConfigurableNode for GroupMasterNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let manager = injector.get::<FixtureManager>().unwrap();
        let groups = manager
            .get_groups()
            .into_iter()
            .map(|group| IdVariant {
                value: group.id.into(),
                label: group.name.clone(),
            })
            .collect();

        vec![
            setting!(id GROUP_SETTING, self.group_id, groups),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(id setting, GROUP_SETTING, self.group_id);

        update_fallback!(setting)
    }
}

impl PipelineNode for GroupMasterNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Group Master".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Fixtures,
        }
    }

    fn display_name(&self, injector: &Injector) -> String {
        if let Some(group) = injector
            .get::<FixtureManager>()
            .and_then(|manager| manager.groups.get(&self.group_id))
        {
            format!("Group Master ({})", group.name)
        } else {
            format!("Group Master (ID {})", self.group_id)
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(MASTER_INPUT_PORT, PortType::Single)
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::GroupMaster
    }
}

impl ProcessingNode for GroupMasterNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let Some(fixture_manager) = context.try_inject::<FixtureManager>() else {
            return Ok(());
        };
        let Some(value) = context.read_port_changes::<_, f64>(MASTER_INPUT_PORT) else {
            return Ok(());
        };

        let fixtures = fixture_manager.get_group_fixture_ids(self.group_id)
            .into_iter()
            .flatten()
            .filter_map(|id| match id {
                FixtureId::Fixture(id) => Some(id),
                _ => None,
            })
            .collect::<Vec<_>>();

        for fixture in fixtures {
            if let Some(mut fixture) = fixture_manager.get_fixture_mut(fixture) {
                fixture.sub_master = value;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
