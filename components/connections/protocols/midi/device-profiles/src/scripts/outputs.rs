use crate::scripts::ScriptError;
use rhai::{Array, Engine, Scope, AST};
use std::path::PathBuf;
use std::sync::Arc;

pub fn parse_outputs_ast(script: impl Into<PathBuf>) -> Result<OutputScript, ScriptError> {
    let mut engine = Engine::new();

    engine.set_max_expr_depths(0, 0).set_max_operations(0);

    let ast = engine.compile_file(script.into())?;

    let script = OutputScript { ast, engine: Arc::new(engine) };
    Ok(script)
}

#[derive(Clone)]
pub struct OutputScript {
    ast: AST,
    engine: Arc<Engine>,
}

impl OutputScript {
    pub fn write_output(&self, output: &str, value: u32) -> Result<Vec<u8>, ScriptError> {
        let mut scope = Scope::new();
        scope.set_value("name", output.to_string());
        scope.set_value("value", value);
        let buffer: Array = self.engine.eval_ast_with_scope(&mut scope, &self.ast)?;
        let buffer = buffer.into_iter().map(|d| d.cast()).collect();

        Ok(buffer)
    }
}
