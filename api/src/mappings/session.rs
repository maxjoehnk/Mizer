use crate::models::Session_oneof__filePath;

impl From<String> for Session_oneof__filePath {
    fn from(path: String) -> Self {
        Self::filePath(path)
    }
}
