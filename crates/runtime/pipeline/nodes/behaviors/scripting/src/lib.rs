use rhai::{Engine, Map, Scope, AST};
use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct ScriptingNode {
    pub script: String,
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
            name: stringify!(ScriptingNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!("value", PortType::Single)]
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
        let value: Result<f64, _> = state
            .engine
            .call_fn(&mut state.scope, &state.ast, "main", ());
        match value {
            Ok(value) => {
                context.write_port("value", value);

                Ok(())
            }
            Err(e) => Err(anyhow::anyhow!("{:?}", e)),
        }
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.script = config.script.clone();
    }
}
