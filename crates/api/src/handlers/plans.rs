use crate::proto::fixtures::FixtureId;
use crate::proto::plans::*;
use crate::RuntimeApi;
use mizer_command_executor::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixtureStates;
use mizer_plan::ImageId;
use mizer_util::Base64Image;

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
    #[profiling::function]
    pub fn get_plans(&self) -> Plans {
        let plans = self.runtime.query(ListPlansQuery).unwrap();
        let plans = plans.into_iter().map(Plan::from).collect();

        Plans {
            plans,
            ..Default::default()
        }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_plan(&self, name: String) -> Plans {
        self.runtime.run_command(AddPlanCommand { name }).unwrap();

        self.get_plans()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_plan(&self, id: String) -> Plans {
        self.runtime.run_command(RemovePlanCommand { id }).unwrap();

        self.get_plans()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn rename_plan(&self, id: String, name: String) -> Plans {
        self.runtime
            .run_command(RenamePlanCommand { id, name })
            .unwrap();

        self.get_plans()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn state_ref(&self) -> FixtureStates {
        self.fixture_manager.states.clone()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
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
    #[profiling::function]
    pub fn move_fixture_selection(&self, plan_id: String, offset: (f64, f64)) {
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
    #[profiling::function]
    pub fn move_fixture(&self, plan_id: String, fixture_id: FixtureId, offset: (f64, f64)) {
        self.runtime
            .run_command(MoveFixturesInPlanCommand {
                fixture_ids: vec![fixture_id.into()],
                offset,
                id: plan_id,
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
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

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn spread_fixtures(&self, req: SpreadFixturesRequest) {
        let view = self.fixture_manager.get_programmer().view();
        let state = view.read();
        self.runtime
            .run_command(SpreadFixturesInPlanCommand {
                geometry: req.geometry().into(),
                plan_id: req.plan_id,
                fixture_ids: state.all_fixtures(),
            })
            .unwrap();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn transform_selection(&self, req: TransformFixturesRequest) -> anyhow::Result<()> {
        let view = self.fixture_manager.get_programmer().view();
        let state = view.read();
        self.runtime
            .run_command(TransformFixturesInPlanCommand {
                id: req.plan_id,
                fixture_ids: state.all_fixtures(),
                rotation: req.rotation,
            })?;
            
        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_image(&self, request: AddImageRequest) -> anyhow::Result<()> {
        self.runtime.run_command(AddPlanImageCommand {
            plan: request.plan_id,
            x: request.x,
            y: request.y,
            width: request.width,
            height: request.height,
            transparency: request.transparency,
            data: Base64Image::from_buffer(request.data),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn move_image(&self, request: MoveImageRequest) -> anyhow::Result<()> {
        self.runtime.run_command(MovePlanImageCommand {
            plan: request.plan_id,
            image: ImageId::try_from(request.image_id)?,
            x: request.x,
            y: request.y,
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn resize_image(&self, request: ResizeImageRequest) -> anyhow::Result<()> {
        self.runtime.run_command(ResizePlanImageCommand {
            plan: request.plan_id,
            image: ImageId::try_from(request.image_id)?,
            width: request.width,
            height: request.height,
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_image(&self, request: RemoveImageRequest) -> anyhow::Result<()> {
        self.runtime.run_command(RemovePlanImageCommand {
            plan_id: request.plan_id,
            image_id: ImageId::try_from(request.image_id)?,
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_screen(&self, request: AddScreenRequest) -> anyhow::Result<()> {
        self.runtime.run_command(AddPlanScreenCommand {
            plan: request.plan_id,
            x: request.x,
            y: request.y,
            width: request.width,
            height: request.height,
        })?;

        Ok(())
    }
}
