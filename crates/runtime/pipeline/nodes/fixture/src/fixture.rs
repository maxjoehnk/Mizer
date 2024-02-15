use std::collections::HashMap;

use serde::{Deserialize, Serialize};

use mizer_fixtures::fixture::IFixtureMut;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixturePriority;
use mizer_node::*;

use crate::fixture_ports::{write_ports, FixtureControlPorts};

const FIXTURE_SETTING: &str = "Fixture";
const PRIORITY_SETTING: &str = "Priority";
const SEND_ZERO_SETTING: &str = "Send Zero";

#[derive(Default, Clone, Deserialize, Serialize)]
pub struct FixtureNode {
    #[serde(rename = "fixture")]
    pub fixture_id: u32,
    #[serde(default)]
    pub priority: FixturePriority,
    #[serde(default = "default_send_zero")]
    pub send_zero: bool,
}

fn default_send_zero() -> bool {
    true
}

impl std::fmt::Debug for FixtureNode {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct(stringify!(FixtureNode))
            .field("fixture_id", &self.fixture_id)
            .field("priority", &self.priority)
            .field("send_zero", &self.send_zero)
            .finish()
    }
}

impl PartialEq<Self> for FixtureNode {
    fn eq(&self, other: &FixtureNode) -> bool {
        self.fixture_id == other.fixture_id
            && self.priority == other.priority
            && self.send_zero == other.send_zero
    }
}

impl ConfigurableNode for FixtureNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let fixture_manager = injector.get::<FixtureManager>().unwrap();
        let fixtures = fixture_manager
            .get_fixtures()
            .into_iter()
            .map(|fixture| IdVariant {
                value: fixture.id,
                label: fixture.name.clone(),
            })
            .collect();

        vec![
            setting!(id FIXTURE_SETTING, self.fixture_id, fixtures).disabled(),
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

impl PipelineNode for FixtureNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Fixture".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
        }
    }

    fn display_name(&self, injector: &Injector) -> String {
        if let Some(fixture) = injector
            .get::<FixtureManager>()
            .and_then(|manager| manager.get_fixture(self.fixture_id))
        {
            format!("Fixture ({})", fixture.name)
        } else {
            format!("Fixture (ID {})", self.fixture_id)
        }
    }

    fn list_ports(&self, injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        let fixture_manager = injector.get::<FixtureManager>();
        fixture_manager
            .and_then(|manager| manager.get_fixture(self.fixture_id))
            .map(|fixture| fixture.current_mode.controls.controls().get_ports())
            .unwrap_or_default()
    }

    fn node_type(&self) -> NodeType {
        NodeType::Fixture
    }
}

impl ProcessingNode for FixtureNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(manager) = context.inject::<FixtureManager>() {
            if let Some(mut fixture) = manager.get_fixture_mut(self.fixture_id) {
                let ports = fixture
                    .current_mode
                    .controls
                    .controls()
                    .get_ports()
                    .into_iter()
                    .collect::<HashMap<_, _>>();
                write_ports(ports, context, self.send_zero, |control, value| {
                    fixture.write_fader_control(control, value, self.priority)
                });
            } else {
                log::error!("could not find fixture for id {}", self.fixture_id);
            }
        } else {
            log::warn!("missing fixture module");
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
