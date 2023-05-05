use std::path::{Path, PathBuf};

pub fn find_path<P: AsRef<Path>>(file: P) -> Option<PathBuf> {
    let file = file.as_ref();
    let mut paths = vec![PathBuf::from(file)];
    if let Some(path) = std::env::current_exe()
        .ok()
        .and_then(|executable| executable.parent().map(|path| path.to_path_buf()))
        .map(|path| path.join(file))
    {
        paths.push(path);
    }

    paths.into_iter().find(|path| path.exists())
}
