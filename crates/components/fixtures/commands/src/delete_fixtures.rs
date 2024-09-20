use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::fixture::Fixture;
use mizer_fixtures::manager::FixtureManager;

#[derive(Debug, Deserialize, Serialize)]
pub struct DeleteFixturesCommand {
    pub fixture_ids: Vec<u32>,
}

impl<'a> Command<'a> for DeleteFixturesCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = Vec<Fixture>;
    type Result = ();

    fn label(&self) -> String {
        let fixture_ids = self
            .fixture_ids
            .iter()
            .map(|id| id.to_string())
            .collect::<Vec<_>>();

        format!("Delete Fixtures ({})", fixture_ids.join(", "))
    }

    fn apply(
        &self,
        fixture_manager:
            &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut fixtures = Vec::new();

        for fixture in self
            .fixture_ids
            .iter()
            .filter_map(|fixture_id| fixture_manager.delete_fixture(*fixture_id))
        {
            fixtures.push(fixture);
        }

        Ok(((), fixtures))
    }

    fn revert(
        &self,
        fixture_manager:
            &FixtureManager,
        fixtures: Self::State,
    ) -> anyhow::Result<()> {
        for fixture in fixtures {
            fixture_manager.add_fixture(
                fixture.id,
                fixture.name,
                fixture.definition,
                Some(fixture.channel_mode.name.to_string()),
                fixture.channel,
                fixture.universe.into(),
                fixture.configuration,
            );
        }

        Ok(())
    }
}
