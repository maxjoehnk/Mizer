use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
#[serde(untagged)]
pub enum StructuredData {
    Text(String),
    Float(f64),
    Int(i64),
    Boolean(bool),
    Array(Vec<StructuredData>),
    Object(HashMap<String, StructuredData>),
}

impl Default for StructuredData {
    fn default() -> Self {
        // TODO: should this be the default?
        Self::Boolean(false)
    }
}
