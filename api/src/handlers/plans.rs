use crate::models::fixtures::FixtureId;
use crate::models::plans::*;
use crate::RuntimeApi;
use mizer_command_executor::*;
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

    #[tracing::instrument(skip(self))]
    pub fn get_plans(&self) -> Plans {
        let plans = self.runtime.plans();
        let plans = plans.into_iter().map(Plan::from).collect();

        Plans {
            plans,
            ..Default::default()
        }
    }

    #[tracing::instrument(skip(self))]
    pub fn add_plan(&self, name: String) -> Plans {
        self.runtime.run_command(AddPlanCommand { name }).unwrap();

        self.get_plans()
    }

    #[tracing::instrument(skip(self))]
    pub fn remove_plan(&self, id: String) -> Plans {
        self.runtime.run_command(RemovePlanCommand { id }).unwrap();

        self.get_plans()
    }

    #[tracing::instrument(skip(self))]
    pub fn rename_plan(&self, id: String, name: String) -> Plans {
        self.runtime
            .run_command(RenamePlanCommand { id, name })
            .unwrap();

        self.get_plans()
    }

    #[tracing::instrument(skip(self))]
    pub fn state_ref(&self) -> FixtureStates {
        self.fixture_manager.states.clone()
    }

    #[tracing::instrument(skip(self))]
    pub fn add_fixture_selection(&self, plan_id: String) {
        let view = self.fixture_manager.get_programmer().view();
        let state = view.read();
        self.runtime
            .run_command(AddFixturesToPlanCommand {
                id: plan_id,
                fixture_ids: state.all_fixtures(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn move_fixture_selection(&self, plan_id: String, offset: (i32, i32)) {
        let view = self.fixture_manager.get_programmer().view();
        let state = view.read();
        self.runtime
            .run_command(MoveFixturesInPlanCommand {
                fixture_ids: state.all_fixtures(),
                offset,
                id: plan_id,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn move_fixture(&self, plan_id: String, fixture_id: FixtureId, offset: (i32, i32)) {
        self.runtime
            .run_command(MoveFixturesInPlanCommand {
                fixture_ids: vec![fixture_id.into()],
                offset,
                id: plan_id,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    pub fn align_fixtures(
        &self,
        plan_id: String,
        direction: align_fixtures_request::AlignDirection,
        groups: u32,
        row_gap: u32,
        column_gap: u32,
    ) {
        let view = self.fixture_manager.get_programmer().view();
        let state = view.read();
        self.runtime
            .run_command(AlignFixturesInPlanCommand {
                id: plan_id,
                fixture_ids: state.all_fixtures(),
                direction: direction.into(),
                groups,
                row_gap,
                column_gap,
            })
            .unwrap();
    }
}
