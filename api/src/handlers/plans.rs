use crate::models::*;
use crate::RuntimeApi;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixtureStates;

#[derive(Clone)]
pub struct PlansHandler<R: RuntimeApi> {
    fixture_manager: FixtureManager,
    runtime: R,
}

impl<R: RuntimeApi> PlansHandler<R> {
    pub fn new(fixture_manager: FixtureManager, runtime: R) -> Self {
        Self {
            fixture_manager,
            runtime,
        }
    }

    pub fn get_plans(&self) -> Plans {
        let plans = self.runtime.plans();
        let plans = plans.into_iter().map(Plan::from).collect();

        Plans {
            plans,
            ..Default::default()
        }
    }

    pub fn add_plan(&self, name: String) -> Plans {
        self.runtime.add_plan(name);

        self.get_plans()
    }

    pub fn remove_plan(&self, id: String) -> Plans {
        self.runtime.remove_plan(id);

        self.get_plans()
    }

    pub fn rename_plan(&self, id: String, name: String) -> Plans {
        self.runtime.rename_plan(id, name);

        self.get_plans()
    }

    pub fn state_ref(&self) -> FixtureStates {
        self.fixture_manager.states.clone()
    }

    pub fn add_fixture_selection(&self, plan_id: String) {
        let view = self.fixture_manager.get_programmer().view();
        let state = view.read();
        self.runtime.add_fixtures_to_plan(plan_id, state.fixtures);
    }

    pub fn move_fixture_selection(&self, plan_id: String, offset: (i32, i32)) {
        let view = self.fixture_manager.get_programmer().view();
        let state = view.read();
        self.runtime
            .move_fixtures_in_plan(plan_id, state.fixtures, offset);
    }

    pub fn move_fixture(&self, plan_id: String, fixture_id: FixtureId, offset: (i32, i32)) {
        self.runtime
            .move_fixtures_in_plan(plan_id, vec![fixture_id.into()], offset);
    }
}
