use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use crate::{Plan, PlanStorage};

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct ListPlansQuery;

impl<'a> Query<'a> for ListPlansQuery {
    type Dependencies = Ref<PlanStorage>;
    type Result = Vec<Plan>;

    fn query(&self, plan_storage: &PlanStorage) -> anyhow::Result<Self::Result> {
        Ok(plan_storage.read())
    }

    fn requires_main_loop(&self) -> bool {
        false
    }
}
