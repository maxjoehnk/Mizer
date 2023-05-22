use serde::{Deserialize, Serialize};

use crate::fixture_ports::{write_ports, FixtureControlPorts};
use mizer_fixtures::fixture::IFixtureMut;
use mizer_fixtures::manager::FixtureManager;
use mizer_node::*;

const FIXTURE_SETTING: &str = "Fixture";

#[derive(Default, Clone, Deserialize, Serialize)]
pub struct FixtureNode {
    #[serde(rename = "fixture")]
    pub fixture_id: u32,
    #[serde(skip)]
    pub fixture_manager: Option<FixtureManager>,
}

impl std::fmt::Debug for FixtureNode {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct(stringify!(FixtureNode))
            .field("fixture_id", &self.fixture_id)
            .finish()
    }
}

impl PartialEq<Self> for FixtureNode {
    fn eq(&self, other: &FixtureNode) -> bool {
        self.fixture_id == other.fixture_id
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

        vec![setting!(id FIXTURE_SETTING, self.fixture_id, fixtures).disabled()]
    }
}

impl PipelineNode for FixtureNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(FixtureNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        self.fixture_manager
            .as_ref()
            .and_then(|manager| manager.get_fixture(self.fixture_id))
            .and_then(|fixture| {
                fixture
                    .current_mode
                    .controls
                    .controls()
                    .get_ports()
                    .remove(port)
            })
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        self.fixture_manager
            .as_ref()
            .and_then(|manager| manager.get_fixture(self.fixture_id))
            .map(|fixture| {
                fixture
                    .current_mode
                    .controls
                    .controls()
                    .get_ports()
                    .into_iter()
                    .collect()
            })
            .unwrap_or_default()
    }

    fn node_type(&self) -> NodeType {
        NodeType::Fixture
    }

    fn prepare(&mut self, injector: &Injector) {
        self.fixture_manager = injector.get().cloned();
    }
}

impl ProcessingNode for FixtureNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(manager) = context.inject::<FixtureManager>() {
            if let Some(mut fixture) = manager.get_fixture_mut(self.fixture_id) {
                let ports = fixture.current_mode.controls.controls().get_ports();
                write_ports(ports, context, |control, value| {
                    fixture.write_fader_control(control, value)
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
