use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::convert::TryInto;

use mizer_fixtures::definition::{
    ColorChannel, FixtureControl, FixtureControlType, FixtureControls, FixtureFaderControl,
};
use mizer_fixtures::fixture::IFixtureMut;
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
            preview_type: PreviewType::None,
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        self.fixture_manager
            .as_ref()
            .and_then(|manager| manager.get_fixture(self.fixture_id))
            .and_then(|fixture| fixture.current_mode.controls.get_ports().remove(port))
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        self.fixture_manager
            .as_ref()
            .and_then(|manager| manager.get_fixture(self.fixture_id))
            .map(|fixture| {
                fixture
                    .current_mode
                    .controls
                    .get_ports()
                    .into_iter()
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
                let ports: HashMap<PortId, PortMetadata> =
                    fixture.current_mode.controls.get_ports();
                for port in context.input_ports() {
                    if let Some(port_metadata) = ports.get(&port) {
                        match port_metadata.port_type {
                            PortType::Color => {
                                if let Some(value) = context.read_port_changes::<_, Color>(port.clone()) {
                                    fixture.write_control(
                                        FixtureFaderControl::Color(ColorChannel::Red),
                                        value.red,
                                    );
                                    fixture.write_control(
                                        FixtureFaderControl::Color(ColorChannel::Green),
                                        value.green,
                                    );
                                    fixture.write_control(
                                        FixtureFaderControl::Color(ColorChannel::Blue),
                                        value.blue,
                                    );
                                }
                            }
                            PortType::Single => {
                                if let Some(value) = context.read_port_changes(port.clone()) {
                                    let control = FixtureControl::from(port.as_str());
                                    fixture.write_control(control.try_into().unwrap(), value);
                                }
                            }
                            _ => unimplemented!(),
                        }
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

trait FixtureControlPorts {
    fn get_ports(&self) -> HashMap<PortId, PortMetadata>;
}

impl<TChannel> FixtureControlPorts for FixtureControls<TChannel> {
    fn get_ports(&self) -> HashMap<PortId, PortMetadata> {
        self.controls()
            .into_iter()
            .map(|(name, control_type)| {
                (
                    name.to_string().into(),
                    PortMetadata {
                        port_type: if control_type == FixtureControlType::Color {
                            PortType::Color
                        } else {
                            PortType::Single
                        },
                        direction: PortDirection::Input,
                        ..Default::default()
                    },
                )
            })
            .collect()
    }
}
