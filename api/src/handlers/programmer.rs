use crate::RuntimeApi;
use mizer_fixtures::manager::FixtureManager;
use crate::models::programmer::*;

#[derive(Clone)]
pub struct ProgrammerHandler<R> {
    fixture_manager: FixtureManager,
    runtime: R,
}

impl<R: RuntimeApi> ProgrammerHandler<R> {
    pub fn new(
        fixture_manager: FixtureManager,
        runtime: R,
    ) -> Self {
        Self {
            fixture_manager,
            runtime,
        }
    }

    pub fn write_channels(&self, request: WriteChannelsRequest) {
        let value = request.value.unwrap();
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.write_channels(request.channel, value.into());
    }

    pub fn select_fixtures(&self, fixture_ids: Vec<u32>) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.select_fixtures(fixture_ids);
    }

    pub fn clear(&self) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.clear();
    }

    pub fn highlight(&self, highlight: bool) {
        let mut programmer = self.fixture_manager.get_programmer();
        programmer.highlight = highlight;
    }
}
