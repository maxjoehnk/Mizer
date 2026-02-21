use mizer_commander::ExtractDependencies;
use mizer_command_executor::{AddLayoutControlWithNodeCommand, Command, DeletePresetCommand};
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{GenericPreset, Preset, PresetId, PresetValue};
use mizer_layouts::{ControlPosition, Layout, LayoutStorage};
use mizer_module::Runtime;
use mizer_node::{NodeLink, NodeType, PortType};
use mizer_nodes::{Node, PresetNode};
use mizer_runtime::commands::{AddLinkCommand, AddNodeCommand, StaticNodeDescriptor};
use mizer_runtime::{CoordinatorRuntime, Pipeline};

#[test]
pub fn add_layout_control_with_node_should_apply() -> anyhow::Result<()> {
    let (mut runtime, _) = RuntimeBuilder::new()
        .with_layout("default".into())
        .build()?;
    let command = AddLayoutControlWithNodeCommand {
        node_type: NodeType::Button,
        position: ControlPosition::default(),
        layout_id: "default".to_string(),
    };

    let (result, state) = {
        let injector = runtime.injector_mut();
        let dependencies = <AddLayoutControlWithNodeCommand as Command>::Dependencies::extract(injector);

        command.apply(dependencies)?
    };

    Ok(())
}

#[test]
pub fn add_node_should_apply() -> anyhow::Result<()> {
    let (mut runtime, _) = RuntimeBuilder::new().build()?;
    let command = AddNodeCommand {
        node_type: NodeType::Button,
        designer: Default::default(),
        node: None,
        parent: None,
        template: None,
    };

    let (result, state) = {
        let injector = runtime.injector_mut();
        let dependencies = <AddNodeCommand as Command>::Dependencies::extract(injector);

        command.apply(dependencies)?
    };

    Ok(())
}

#[test]
pub fn add_link_should_apply() -> anyhow::Result<()> {
    let (mut runtime, nodes) = RuntimeBuilder::new()
        .with_node(NodeType::Fader)?
        .with_node(NodeType::Fader)?
        .build()?;
    let command = AddLinkCommand {
        link: NodeLink {
            port_type: PortType::Single,
            source: nodes[0].path.clone(),
            source_port: "Output".into(),
            target: nodes[1].path.clone(),
            target_port: "Input".into(),
            local: true,
        }
    };

    let (result, state) = {
        let injector = runtime.injector_mut();
        let dependencies = <AddLinkCommand as Command>::Dependencies::extract(injector);

        command.apply(dependencies)?
    };

    Ok(())
}

#[test]
pub fn delete_preset_should_apply() -> anyhow::Result<()> {
    let (mut runtime, nodes) = RuntimeBuilder::new()
        .with_preset(GenericPreset::Color(Preset {
            id: 1,
            label: None,
            value: PresetValue::Universal(Default::default()),
        }))
        .with(PresetNode { id: PresetId::Color(1) })?
        .build()?;
    let command = DeletePresetCommand { id: PresetId::Color(1) };

    let (result, state) = {
        let injector = runtime.injector_mut();
        let dependencies = <DeletePresetCommand as Command>::Dependencies::extract(injector);

        command.apply(dependencies)?
    };

    Ok(())
}

struct RuntimeBuilder {
    runtime: CoordinatorRuntime,
    pipeline: Pipeline,
    fixture_manager: FixtureManager,
    nodes: Vec<(NodeType, Option<Node>)>,
    layouts: Vec<String>,
}

impl RuntimeBuilder {
    fn new() -> Self {
        Self {
            runtime: CoordinatorRuntime::new(),
            pipeline: Pipeline::new(),
            fixture_manager: FixtureManager::new(FixtureLibrary::default()),
            nodes: Default::default(),
            layouts: Default::default(),
        }
    }

    fn with_node(mut self, node_type: NodeType) -> anyhow::Result<Self> {
        let node = self.pipeline.add_node(self.runtime.injector_mut(), node_type, Default::default(), None, None)?;
        self.nodes.push((node_type, None));

        Ok(self)
    }

    fn with<T: Into<Node>>(mut self, node: T) -> anyhow::Result<Self> {
        let node = node.into();
        let node_type = node.node_type();
        self.nodes.push((node_type, Some(node)));

        Ok(self)
    }

    fn with_layout(mut self, layout: String) -> Self {
        self.layouts.push(layout);

        self
    }

    fn with_preset(self, preset: GenericPreset) -> Self {
        self.fixture_manager.presets.add(preset);

        self
    }

    fn build(mut self) -> anyhow::Result<(CoordinatorRuntime, Vec<StaticNodeDescriptor>)> {
        let layout_storage = self.runtime.injector().get::<LayoutStorage>().unwrap();
        layout_storage.set(self.layouts.into_iter().map(|name| Layout {
            id: name,
            controls: Default::default(),
        }).collect());
        self.runtime.provide(self.fixture_manager);

        let mut nodes = Vec::new();
        for (node_type, node) in self.nodes {
            let node = self.pipeline.add_node(self.runtime.injector(), node_type, Default::default(), node, None)?;
            nodes.push(node);
        }

        self.runtime.provide(self.pipeline);

        Ok((self.runtime, nodes))
    }
}
