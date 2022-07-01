use mizer_commander::{Command, Ref};
use mizer_fixtures::fixture::FixtureConfiguration;
use mizer_fixtures::manager::FixtureManager;
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct UpdateFixtureCommand {
    pub fixture_id: u32,
    pub invert_pan: Option<bool>,
    pub invert_tilt: Option<bool>,
}

impl<'a> Command<'a> for UpdateFixtureCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = FixtureConfiguration;
    type Result = ();

    fn label(&self) -> String {
        format!("Update Fixture {}", self.fixture_id)
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut fixture = fixture_manager
            .get_fixture_mut(self.fixture_id)
            .ok_or_else(|| anyhow::anyhow!("Missing fixture"))?;

        let config = fixture.configuration;

        if let Some(invert_pan) = self.invert_pan {
            fixture.configuration.invert_pan = invert_pan;
        }
        if let Some(invert_tilt) = self.invert_tilt {
            fixture.configuration.invert_tilt = invert_tilt;
        }

        Ok(((), config))
    }

    fn revert(&self, fixture_manager: &FixtureManager, state: Self::State) -> anyhow::Result<()> {
        let mut fixture = fixture_manager
            .get_fixture_mut(self.fixture_id)
            .ok_or_else(|| anyhow::anyhow!("Missing fixture"))?;
        fixture.configuration = state;

        Ok(())
    }
}
