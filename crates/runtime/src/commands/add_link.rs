use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_node::NodeLink;

use crate::pipeline::Pipeline;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AddLinkCommand {
    pub link: NodeLink,
}

impl<'a> Command<'a> for AddLinkCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = Option<NodeLink>;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Add Link from '{}:{}' to '{}:{}'",
            self.link.source, self.link.source_port, self.link.target, self.link.target_port
        )
    }

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut state = None;
        if pipeline.get_node_dyn(&self.link.target).is_none() {
            return Err(anyhow::anyhow!("Target node does not exist"));
        }
        let metadata = pipeline
            .try_get_input_port_metadata(&self.link.target, &self.link.target_port)
            .ok_or_else(|| anyhow::anyhow!("Target port does not exist"))?;
        if metadata.multiple != Some(true) {
            if let Some(existing_link) =
                pipeline.find_input_link(&self.link.target, &self.link.target_port)
            {
                pipeline.delete_link(&existing_link);
                state = Some(existing_link);
            };
        }
        pipeline.add_link(self.link.clone())?;

        Ok(((), state))
    }

    fn revert(&self, pipeline: &mut Pipeline, previous_link: Self::State) -> anyhow::Result<()> {
        pipeline.delete_link(&self.link);
        if let Some(previous_link) = previous_link {
            pipeline.add_link(previous_link)?;
        }

        Ok(())
    }
}
