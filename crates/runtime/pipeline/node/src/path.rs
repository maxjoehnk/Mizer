use std::ops::Deref;

use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Hash, PartialOrd, Ord, PartialEq, Eq, Deserialize, Serialize)]
#[repr(transparent)]
#[serde(transparent)]
pub struct NodePath(String);

impl std::fmt::Display for NodePath {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        std::fmt::Display::fmt(&self.0, f)
    }
}

impl From<String> for NodePath {
    fn from(path: String) -> Self {
        if !path.starts_with('/') {
            Self(format!("/{path}"))
        } else {
            Self(path)
        }
    }
}

impl From<NodePath> for String {
    fn from(path: NodePath) -> Self {
        path.0
    }
}

impl From<&str> for NodePath {
    fn from(path: &str) -> Self {
        Self::from(path.to_string())
    }
}

impl Deref for NodePath {
    type Target = String;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl PartialEq<String> for NodePath {
    fn eq(&self, other: &String) -> bool {
        &self.0 == other
    }
}

impl PartialEq<&str> for NodePath {
    fn eq(&self, other: &&str) -> bool {
        &self.0 == other
    }
}

impl Default for NodePath {
    fn default() -> Self {
        Self(String::new())
    }
}

impl NodePath {
    pub fn join(&self, other: &NodePath) -> Self {
        if other.starts_with("/") || self.ends_with("/") {
            format!("{}{}", self, other).into()
        } else {
            format!("{}/{}", self, other).into()
        }
    }
}
