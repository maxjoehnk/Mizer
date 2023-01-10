use crate::fixture_ports::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_node::edge::Edge;
use mizer_node::{
    Injector, NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId,
    PortMetadata, PortType, PreviewType, ProcessingNode,
};
use serde::{Deserialize, Serialize};

const CALL_PORT: &str = "Call";
const ACTIVE_PORT: &str = "Active";

#[derive(Default, Clone, Deserialize, Serialize)]
pub struct GroupNode {
    pub id: u32,
    #[serde(skip)]
    pub fixture_manager: Option<FixtureManager>,
}

impl GroupNode {}

impl std::fmt::Debug for GroupNode {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct(stringify!(GroupNode))
            .field("id", &self.id)
            .finish()
    }
}

impl PartialEq for GroupNode {
    fn eq(&self, other: &Self) -> bool {
        self.id == other.id
    }
}

impl PipelineNode for GroupNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(GroupNode).into(),
            preview_type: PreviewType::None,
        }
    }

    // TODO: nodes need a way to notify the pipeline of new ports
    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        let fixture_channels: Vec<_> = if let Some(fixture_manager) = self.fixture_manager.as_ref()
        {
            fixture_manager
                .get_group_fixture_controls(self.id)
                .get_ports()
                .into_iter()
                .collect()
        } else {
            Default::default()
        };
        fixture_channels
            .into_iter()
            .chain(vec![
                (
                    CALL_PORT.into(),
                    PortMetadata {
                        port_type: PortType::Single,
                        direction: PortDirection::Input,
                        ..Default::default()
                    },
                ),
                (
                    ACTIVE_PORT.into(),
                    PortMetadata {
                        port_type: PortType::Single,
                        direction: PortDirection::Output,
                        ..Default::default()
                    },
                ),
            ])
            .collect()
    }

    fn node_type(&self) -> NodeType {
        NodeType::Group
    }

    fn prepare(&mut self, injector: &Injector) {
        self.fixture_manager = injector.get().cloned();
    }
}

impl ProcessingNode for GroupNode {
    type State = Edge;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(fixture_manager) = context.inject::<FixtureManager>() {
            self.call_group(context, state, fixture_manager);
            self.write_to_fixtures(context, fixture_manager);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, _config: &Self) {}
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
            .get_ports();

        write_ports(ports, context, |control, value| {
            fixture_manager.write_group_control(self.id, control, value)
        });
    }
}
