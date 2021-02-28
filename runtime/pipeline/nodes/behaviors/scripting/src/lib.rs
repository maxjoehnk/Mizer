use rhai::{AST, Engine, Map, Scope};
use serde::{Deserialize, Serialize};

use mizer_node::{NodeContext, NodeDetails, ProcessingNode, PipelineNode, NodeType};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct ScriptingNode {
    script: String,
}

pub struct ScriptingNodeState<'a> {
    engine: Engine,
    scope: Scope<'a>,
    ast: AST,
    script: String,
}

impl<'a> Default for ScriptingNodeState<'a> {
    fn default() -> Self {
        let mut scope = Scope::default();
        scope.set_value("state", Map::new());

        Self {
            engine: Default::default(),
            ast: Default::default(),
            script: Default::default(),
            scope,
        }
    }
}

impl ScriptingNode {}

impl PipelineNode for ScriptingNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "ScriptingNode".into()
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::Scripting
    }
}

impl ProcessingNode for ScriptingNode {
    type State = ScriptingNodeState<'static>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if self.script != state.script {
            state.ast = state.engine.compile(&self.script)?;
            state.script = self.script.clone();
        }
        match state.engine.call_fn::<_, f64>(&mut state.scope, &state.ast, "main", ()) {
            Ok(value) => {
                context.write_port("value", value);

                Ok(())
            }
            Err(e) => {
                Err(anyhow::anyhow!("{:?}", e))
            }
        }
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
