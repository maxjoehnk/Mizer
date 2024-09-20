use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;
use serde::{Deserialize, Serialize};
use mizer_fixtures::{ChannelLimit, FixtureConfiguration};
use mizer_fixtures::channels::FixtureChannel;

#[derive(Debug, Deserialize, Serialize)]
pub struct UpdateFixtureCommand {
    pub fixture_id: u32,
    pub invert_pan: Option<bool>,
    pub invert_tilt: Option<bool>,
    pub reverse_pixel_order: Option<bool>,
    pub name: Option<String>,
    pub address: Option<(u16, u16)>,
    pub limit: Option<(FixtureChannel, ChannelLimit)>,
}

impl<'a> Command<'a> for UpdateFixtureCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = (FixtureConfiguration, String, (u16, u16));
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

        let config = fixture.configuration.clone();
        let name = fixture.name.clone();
        let address = (fixture.universe, fixture.channel);

        if let Some(invert_pan) = self.invert_pan {
            fixture.configuration.invert_pan = invert_pan;
        }
        if let Some(invert_tilt) = self.invert_tilt {
            fixture.configuration.invert_tilt = invert_tilt;
        }
        if let Some(reverse_pixel_order) = self.reverse_pixel_order {
            fixture.configuration.reverse_pixel_order = reverse_pixel_order;
        }
        if let Some(name) = self.name.clone() {
            fixture.name = name;
        }
        if let Some((universe, channel)) = self.address {
            fixture.universe = universe;
            fixture.channel = channel;
        }
        if let Some((control, limits)) = self.limit.clone() {
            fixture.configuration.limits.insert(control, limits);
        }

        Ok(((), (config, name, address)))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        (config, name, (universe, channel)): Self::State,
    ) -> anyhow::Result<()> {
        let mut fixture = fixture_manager
            .get_fixture_mut(self.fixture_id)
            .ok_or_else(|| anyhow::anyhow!("Missing fixture"))?;
        fixture.configuration = config;
        fixture.name = name;
        fixture.universe = universe;
        fixture.channel = channel;

        Ok(())
    }
}
