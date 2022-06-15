use mizer_commander::{sub_command, Command, Ref, RefMut};
use mizer_layouts::LayoutStorage;
use mizer_nodes::Node;
use mizer_runtime::commands::DeleteNodeCommand;
use mizer_runtime::pipeline_access::PipelineAccess;
use mizer_runtime::{ExecutionPlanner, NodeDowncast};
use mizer_sequencer::{Effect, EffectEngine, Sequence, Sequencer};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize, Hash)]
pub struct DeleteEffectCommand {
    pub effect_id: u32,
}

impl<'a> Command<'a> for DeleteEffectCommand {
    type Dependencies = Ref<EffectEngine>;
    type State = Effect;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Effect '{}'", self.effect_id)
    }

    fn apply(&self, effect_engine: &EffectEngine) -> anyhow::Result<(Self::Result, Self::State)> {
        let effect = effect_engine
            .delete_effect(self.effect_id)
            .ok_or_else(|| anyhow::anyhow!("Unknown effect {}", self.effect_id))?;

        Ok(((), effect))
    }

    fn revert(&self, effect_engine: &EffectEngine, effect: Self::State) -> anyhow::Result<()> {
        effect_engine.add_effect(effect);

        Ok(())
    }
}
