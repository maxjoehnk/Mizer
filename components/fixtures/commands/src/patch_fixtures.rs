use mizer_commander::{sub_command, Command, Ref, RefMut};
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;
use mizer_node::{NodeDesigner, NodeType};
use mizer_nodes::FixtureNode;
use mizer_runtime::commands::AddNodeCommand;
use mizer_runtime::pipeline_access::PipelineAccess;
use mizer_runtime::ExecutionPlanner;
use regex::Regex;
use serde::{Deserialize, Serialize};
use std::str::FromStr;

lazy_static::lazy_static! {
    static ref FIXTURE_NAME_REGEX: Regex = Regex::new("^(?P<name>.*?)(?P<counter>[0-9]+)?$").unwrap();
}

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct PatchFixturesCommand {
    pub definition_id: String,
    pub mode: String,
    pub start_id: u32,
    pub start_channel: u32,
    pub universe: u32,
    pub name: String,
    pub count: u32,
}

impl PatchFixturesCommand {
    fn build_name(captures: &regex::Captures, index: u32) -> String {
        let base_name = &captures["name"];
        if let Some(counter) = captures.name("counter") {
            let counter = u32::from_str(counter.as_str()).unwrap();
            let counter = counter + index;

            format!("{}{}", base_name, counter)
        } else {
            base_name.to_string()
        }
    }
}

impl<'a> Command<'a> for PatchFixturesCommand {
    type Dependencies = (
        Ref<FixtureManager>,
        Ref<FixtureLibrary>,
        RefMut<PipelineAccess>,
        RefMut<ExecutionPlanner>,
    );
    type State = Vec<sub_command!(AddNodeCommand)>;
    type Result = ();

    fn label(&self) -> String {
        format!("Patch {} Fixtures ", self.count)
    }

    fn apply(
        &self,
        (fixture_manager, fixture_library, pipeline, planner): (
            &FixtureManager,
            &FixtureLibrary,
            &mut PipelineAccess,
            &mut ExecutionPlanner,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let definition = fixture_library
            .get_definition(&self.definition_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown definition"))?;
        let captures = FIXTURE_NAME_REGEX.captures(&self.name).unwrap();
        let mode = definition
            .get_mode(&self.mode)
            .ok_or_else(|| anyhow::anyhow!("Unknown fixture mode"))?;
        let mut paths = Vec::with_capacity(self.count as usize);
        for i in 0..self.count {
            let fixture_id = self.start_id + i;
            let name = Self::build_name(&captures, i);
            let offset = mode.dmx_channels() * (i as u16);
            fixture_manager.add_fixture(
                fixture_id,
                name,
                definition.clone(),
                self.mode.clone().into(),
                None,
                (self.start_channel as u16) + offset,
                Some(self.universe as u16),
                Default::default(),
            );
            let node = FixtureNode {
                fixture_id,
                fixture_manager: Some(fixture_manager.clone()),
            };
            let sub_cmd = AddNodeCommand {
                node_type: NodeType::Fixture,
                designer: NodeDesigner {
                    hidden: true,
                    ..Default::default()
                },
                node: Some(node.into()),
            };
            let (_, path) = sub_cmd.apply((pipeline, planner))?;
            paths.push((sub_cmd, path));
        }

        Ok(((), paths))
    }

    fn revert(
        &self,
        (fixture_manager, _, pipeline, planner): (
            &FixtureManager,
            &FixtureLibrary,
            &mut PipelineAccess,
            &mut ExecutionPlanner,
        ),
        state: Self::State,
    ) -> anyhow::Result<()> {
        for i in 0..self.count {
            let fixture_id = self.start_id + i;
            fixture_manager.delete_fixture(fixture_id);
        }
        for (cmd, path) in state {
            cmd.revert((pipeline, planner), path)?;
        }

        Ok(())
    }
}
