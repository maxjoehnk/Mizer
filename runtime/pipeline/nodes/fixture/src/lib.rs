use serde::{Deserialize, Serialize};

use mizer_fixtures::manager::FixtureManager;
use mizer_node::*;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct FixtureNode {
    #[serde(rename = "fixture")]
    fixture_id: String,
}

impl PipelineNode for FixtureNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "FixtureNode".into(),
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::Fixture
    }

    fn introspect_port(&self, port: &PortId, injector: &Injector) -> Option<PortMetadata> {
        injector
            .get::<FixtureManager>()
            .and_then(|manager| manager.get_fixture(&self.fixture_id))
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
}

impl ProcessingNode for FixtureNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(manager) = context.inject::<FixtureManager>() {
            if let Some(mut fixture) = manager.get_fixture_mut(&self.fixture_id) {
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
