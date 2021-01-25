use rhai::EvalAltResult;

pub mod outputs;
pub mod pages;

#[derive(Debug, Clone)]
pub struct ScriptError(String);

impl std::fmt::Display for ScriptError {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}

impl std::error::Error for ScriptError {}

impl From<Box<EvalAltResult>> for ScriptError {
    fn from(err: Box<EvalAltResult>) -> Self {
        ScriptError(err.to_string())
    }
}
