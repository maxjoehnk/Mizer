use std::path::{Path, PathBuf};

const IMPORT_BASE_PATH_ENV: &str = "MIZER_IMPORT_PATH";

pub fn find_path<P: AsRef<Path>>(file: P) -> Option<PathBuf> {
    let file = file.as_ref();
    let file = shellexpand::full(file.to_str().unwrap())
        .ok()
        .map(|expanded| PathBuf::from(expanded.into_owned()))
        .unwrap_or_else(|| file.to_path_buf());
    let file = file.as_path();
    let mut paths = vec![PathBuf::from(file)];
    if let Some(path) = std::env::current_exe()
        .ok()
        .and_then(|executable| executable.parent().map(|path| path.to_path_buf()))
        .map(|path| path.join(file))
    {
        paths.push(path);
    }
    if let Some(path) = std::env::var(IMPORT_BASE_PATH_ENV)
        .ok()
        .map(|path| PathBuf::from(path).join(file))
    {
        paths.push(path);
    }

    tracing::trace!("Looking for file: {}. Found: {:?}", file.display(), paths);

    paths.into_iter().find(|path| path.exists())
}
