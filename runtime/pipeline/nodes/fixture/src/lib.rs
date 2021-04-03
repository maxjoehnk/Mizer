use serde::{Deserialize, Serialize};

use mizer_fixtures::manager::FixtureManager;
use mizer_node::*;

#[derive(Default, Clone, Deserialize, Serialize)]
pub struct FixtureNode {
    #[serde(rename = "fixture")]
    pub fixture_id: u32,
    #[serde(skip)]
    pub fixture_manager: Option<FixtureManager>,
}

impl std::fmt::Debug for FixtureNode {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct("FixtureNode")
            .field("fixture_id", &self.fixture_id)
            .finish()
    }
}

impl PartialEq<Self> for FixtureNode {
    fn eq(&self, other: &FixtureNode) -> bool {
        self.fixture_id == other.fixture_id
    }
}

impl PipelineNode for FixtureNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "FixtureNode".into(),
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        self.fixture_manager
            .as_ref()
            .and_then(|manager| manager.get_fixture(self.fixture_id))
            .and_then(|fixture| {
                fixture
                    .get_channels()
                    .iter()
                    .find(|c| port == c.name)
                    .cloned()
            })
            .map(|_| PortMetadata {
                direction: PortDirection::Input,
                port_type: PortType::Single,
                ..Default::default()
            })
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        self.fixture_manager
            .as_ref()
            .and_then(|manager| manager.get_fixture(self.fixture_id))
            .map(|fixture| {
                fixture
                    .get_channels()
                    .iter()
                    .map(|channel| {
                        (
                            channel.name.as_str().into(),
                            PortMetadata {
                                port_type: PortType::Single,
                                direction: PortDirection::Input,
                                ..Default::default()
                            },
                        )
                    })
                    .collect()
            })
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
                for port in context.input_ports() {
                    if let Some(value) = context.read_port(port.clone()) {
                        fixture.write(&port.0, value);
                    }
                }
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
