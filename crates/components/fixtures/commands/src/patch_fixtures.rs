use std::str::FromStr;

use regex::Regex;
use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};
use mizer_fixtures::fixture::Fixture;
use mizer_fixtures::library::FixtureLibrary;
use mizer_fixtures::manager::FixtureManager;

lazy_static::lazy_static! {
    static ref FIXTURE_NAME_REGEX: Regex = Regex::new("^(?P<name>.*?)(?P<counter>[0-9]+)?$").unwrap();
}

#[derive(Debug, Deserialize, Serialize)]
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
    
    pub fn preview(&self, fixture_library: &FixtureLibrary) -> anyhow::Result<Vec<Fixture>> {
        let mut previews = Vec::with_capacity(self.count as usize);
        let captures = FIXTURE_NAME_REGEX.captures(&self.name).unwrap();
        let definition = fixture_library
            .get_definition(&self.definition_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown definition"))?;
        let mode = definition
            .get_mode(&self.mode)
            .ok_or_else(|| anyhow::anyhow!("Unknown fixture mode"))?;
        for i in 0..self.count {
            let fixture_id = self.start_id + i;
            let name = Self::build_name(&captures, i);
            let (universe, channel) = calculate_address(
                self.universe as u16,
                self.start_channel as u16,
                mode.dmx_channels(),
                i as u16,
            );
            
            previews.push(Fixture::new(
                fixture_id,
                name,
                definition.clone(),
                Some(self.mode.clone()),
                channel,
                Some(universe),
                Default::default()
            ));
        }
        
        Ok(previews)
    }
}

impl<'a> Command<'a> for PatchFixturesCommand {
    type Dependencies = (
        Ref<FixtureManager>,
        Ref<FixtureLibrary>,
    );
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Patch {} Fixtures ", self.count)
    }

    fn apply(
        &self,
        (fixture_manager, fixture_library): (
            &FixtureManager,
            &FixtureLibrary,
        ),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let definition = fixture_library
            .get_definition(&self.definition_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown definition"))?;
        let captures = FIXTURE_NAME_REGEX.captures(&self.name).unwrap();
        let mode = definition
            .get_mode(&self.mode)
            .ok_or_else(|| anyhow::anyhow!("Unknown fixture mode"))?;
        for i in 0..self.count {
            let fixture_id = self.start_id + i;
            let name = Self::build_name(&captures, i);
            let (universe, channel) = calculate_address(
                self.universe as u16,
                self.start_channel as u16,
                mode.dmx_channels(),
                i as u16,
            );
            fixture_manager.add_fixture(
                fixture_id,
                name,
                definition.clone(),
                self.mode.clone().into(),
                channel,
                Some(universe),
                Default::default(),
            );
        }

        Ok(((), ()))
    }

    fn revert(
        &self,
        (fixture_manager, _): (
            &FixtureManager,
            &FixtureLibrary,
        ),
        _state: Self::State,
    ) -> anyhow::Result<()> {
        for i in 0..self.count {
            let fixture_id = self.start_id + i;
            fixture_manager.delete_fixture(fixture_id);
        }

        Ok(())
    }
}

fn calculate_address(universe: u16, start_channel: u16, channel_count: u16, i: u16) -> (u16, u16) {
    let fixtures_in_universe = (512 - start_channel) / channel_count;
    let offset = channel_count * i;
    let start_channel = start_channel + offset;
    let end = start_channel + channel_count;
    let universe_offset = end / 512u16;

    if universe_offset > 0 {
        let i = i - fixtures_in_universe;
        calculate_address(universe + 1, 1, channel_count, i)
    } else {
        (universe, start_channel)
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use crate::patch_fixtures::calculate_address;

    #[test_case(1, 1, 1, 0, (1, 1))]
    #[test_case(2, 1, 1, 0, (2, 1))]
    #[test_case(1, 2, 1, 0, (1, 2))]
    #[test_case(1, 512, 1, 0, (2, 1))]
    #[test_case(1, 512, 3, 170, (3, 1))]
    #[test_case(1, 1, 3, 170, (2, 1))]
    #[test_case(1, 1, 3, 171, (2, 4))]
    #[test_case(1, 1, 3, 299, (2, 388))]
    fn calculate_address_should_return_universe_and_channel(
        universe: u16,
        channel: u16,
        channel_count: u16,
        i: u16,
        expected: (u16, u16),
    ) {
        let result = calculate_address(universe, channel, channel_count, i);

        assert_eq!(expected, result);
    }
}
