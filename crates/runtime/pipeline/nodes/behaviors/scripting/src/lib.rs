use rhai::{Engine, Map, Scope, AST};
use serde::{Deserialize, Serialize};

use mizer_node::*;

const SCRIPT_SETTING: &str = "Script";

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

impl ConfigurableNode for ScriptingNode {
    fn settings(&self, _injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        vec![setting!(SCRIPT_SETTING, &self.script).multiline()]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, SCRIPT_SETTING, self.script);

        update_fallback!(setting)
    }
}

impl PipelineNode for ScriptingNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Scripting".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
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
}
