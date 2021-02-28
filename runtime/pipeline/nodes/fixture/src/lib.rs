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
