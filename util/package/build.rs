use std::fs;
use std::path::{Path, PathBuf};

#[cfg(target_os = "linux")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.link("mizer")?;
    artifact.link("data")?;
    artifact.link("lib")?;

    Ok(())
}

#[cfg(target_os = "macos")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.link("Mizer.app")?;
    artifact.link_to("mizer", "Mizer.app/Contents/MacOS/mizer")?;
    artifact.link_all_with_suffix_to(".dylib", "Mizer.app/Contents/MacOS")?;
    artifact.link_all_with_suffix_to(".framework", "Mizer.app/Contents/Frameworks")?;

    Ok(())
}

fn build_dir() -> PathBuf {
    let out_dir = std::env::var("OUT_DIR").unwrap();
    let mut path = PathBuf::from(out_dir);
    path.pop();
    path.pop();
    path.pop();

    path
}

fn create_artifact_dir(build_dir: &Path) -> anyhow::Result<PathBuf> {
    let artifact_path = build_dir.join("artifact");
    if artifact_path.exists() {
        fs::remove_dir_all(&artifact_path)?;
    } else {
        fs::create_dir_all(&artifact_path)?;
    }

    Ok(artifact_path)
}

struct Artifact {
    build_dir: PathBuf,
    artifact_dir: PathBuf,
}

impl Artifact {
    fn new() -> anyhow::Result<Self> {
        let path = build_dir();
        let artifact_dir = create_artifact_dir(&path)?;

        Ok(Artifact {
            build_dir: path,
            artifact_dir,
        })
    }

    fn link<P: AsRef<Path>>(&self, file: P) -> anyhow::Result<()> {
        self.link_to(file.as_ref(), file.as_ref())
    }

    fn link_to<P: AsRef<Path>, Q: AsRef<Path>>(&self, from: P, to: Q) -> anyhow::Result<()> {
        let from = self.build_dir.join(from);
        let to = self.artifact_dir.join(to);

        fs::create_dir_all(to.parent().unwrap())?;

        #[cfg(target_family = "unix")]
        {
            std::os::unix::fs::symlink(&from, &to)?;
        }

        Ok(())
    }

    fn link_all_with_suffix_to<P: AsRef<Path>>(
        &self,
        suffix: &str,
        target: P,
    ) -> anyhow::Result<()> {
        let files = fs::read_dir(&self.build_dir)?;
        let files = files
            .into_iter()
            .map(|file| {
                let file = file?;

                let is_file = file.file_type()?.is_file();
                let filename_matches = file
                    .file_name()
                    .into_string()
                    .unwrap_or_default()
                    .ends_with(suffix);

                if is_file && filename_matches {
                    Ok(Some(file))
                } else {
                    Ok(None)
                }
            })
            .filter_map(|file: anyhow::Result<_>| file.ok().flatten())
            .collect::<Vec<_>>();

        for file in files {
            self.link_to(file.path(), target.as_ref().join(&file.file_name()))?;
        }

        Ok(())
    }
}
