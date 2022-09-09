use crate::definition::{FixtureFaderControl, SubFixtureDefinition};
use crate::fixture::{IFixture, IFixtureMut};
use crate::Fixture;

#[derive(Debug)]
pub struct SubFixtureMut<'a> {
    pub(crate) fixture: &'a mut Fixture,
    pub(crate) definition: SubFixtureDefinition,
}

#[derive(Debug)]
pub struct SubFixture<'a> {
    pub(crate) fixture: &'a Fixture,
    pub(crate) definition: &'a SubFixtureDefinition,
}

impl<'a> IFixtureMut for SubFixtureMut<'a> {
    fn write_fader_control(&mut self, control: FixtureFaderControl, value: f64) {
        profiling::scope!("SubFixtureMut::write_fader_control");
        self.fixture
            .sub_fixture_values
            .insert((self.definition.id, control), value);
    }
}

impl<'a> IFixture for SubFixtureMut<'a> {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("SubFixtureMut::read_control");
        self.fixture
            .sub_fixture_values
            .get(&(self.definition.id, control))
            .copied()
    }
}

impl<'a> IFixture for SubFixture<'a> {
    fn read_control(&self, control: FixtureFaderControl) -> Option<f64> {
        profiling::scope!("SubFixture::read_control");
        self.fixture
            .sub_fixture_values
            .get(&(self.definition.id, control))
            .copied()
    }
}
