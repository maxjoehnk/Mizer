use serde::{Deserialize, Serialize};
use mizer_commander::{Query, Ref};
use crate::CommandHistory;

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct GetCommandHistoryQuery;

impl<'a> Query<'a> for GetCommandHistoryQuery {
    type Dependencies = Ref<CommandHistory>;
    type Result = (Vec<(String, u128)>, usize);

    fn query(&self, history: &CommandHistory) -> anyhow::Result<Self::Result> {
        let result = history.items();
        let cursor = history.index();

        Ok((result, cursor))
    }
}