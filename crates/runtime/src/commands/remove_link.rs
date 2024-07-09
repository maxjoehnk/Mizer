use mizer_commander::{Command, RefMut};
use mizer_node::NodeLink;
use serde::{Deserialize, Serialize};
use crate::Pipeline;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RemoveLinkCommand {
    pub link: NodeLink,
}

impl<'a> Command<'a> for RemoveLinkCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Remove Link from '{}:{}' to '{}:{}'",
            self.link.source, self.link.source_port, self.link.target, self.link.target_port
        )
    }

    fn apply(
        &self,
        pipeline: &mut Pipeline,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        pipeline.delete_link(&self.link);

        Ok(((), ()))
    }

    fn revert(
        &self,
        pipeline: &mut Pipeline,
        _: Self::State,
    ) -> anyhow::Result<()> {
        pipeline.add_link(self.link.clone())?;

        Ok(())
    }
}
