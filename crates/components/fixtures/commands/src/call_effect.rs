use serde::{Deserialize, Serialize};
use mizer_commander::{Command, Ref};
use mizer_fixtures::manager::FixtureManager;

#[derive(Debug, Deserialize, Serialize)]
pub struct CallEffectCommand {
    pub effect_id: u32,
}

impl<'a> Command<'a> for CallEffectCommand {
    type Dependencies = Ref<FixtureManager>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        "Call Effect".to_string()
    }

    fn apply(
        &self,
        fixture_manager: &FixtureManager,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut programmer = fixture_manager.get_programmer();
        programmer.call_effect(self.effect_id);

        Ok(((), ()))
    }

    fn revert(
        &self,
        fixture_manager: &FixtureManager,
        _: Self::State,
    ) -> anyhow::Result<()> {
        todo!()
    }
}
