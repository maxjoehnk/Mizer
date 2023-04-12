use mizer_settings::Settings;
use std::fs;
use std::path::{Path, PathBuf};

#[cfg(target_os = "linux")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.link("mizer")?;
    #[cfg(feature = "ui")]
    artifact.link("data")?;
    #[cfg(feature = "ui")]
    artifact.link("lib")?;
    #[cfg(feature = "ui")]
    artifact.link_to("libmizer_ui_ffi.so", "lib/libmizer_ui_ffi.so")?;
    artifact.link_source(
        "components/fixtures/open-fixture-library/.fixtures",
        "fixtures/open-fixture-library",
    )?;
    artifact.link_source("components/fixtures/qlcplus/.fixtures", "fixtures/qlcplus")?;
    artifact.link_source(
        "components/connections/protocols/midi/device-profiles/profiles",
        "device-profiles/midi",
    )?;
    artifact.copy_settings("settings.toml", |settings| {
        settings.paths.midi_device_profiles = PathBuf::from("device-profiles/midi");
        settings.paths.fixture_libraries.open_fixture_library =
            Some(PathBuf::from("fixtures/open-fixture-library"));
        settings.paths.fixture_libraries.qlcplus = Some(PathBuf::from("fixtures/qlcplus"));
        settings.paths.fixture_libraries.qlcplus = Some(PathBuf::from("fixtures/qlcplus"));
        settings.paths.fixture_libraries.gdtf = Some(PathBuf::from("fixtures/gdtf"));
    })?;

    Ok(())
}

#[cfg(target_os = "macos")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.link("Mizer.app")?;
    artifact.link_all_with_suffix_to(".dylib", "Mizer.app/Contents/Frameworks")?;
    artifact.link_all_with_suffix_to(".framework", "Mizer.app/Contents/Frameworks")?;
    artifact.link_source(
        "components/fixtures/open-fixture-library/.fixtures",
        "Mizer.app/Contents/Resources/fixtures/open-fixture-library",
    )?;
    artifact.link_source(
        "components/fixtures/qlcplus/.fixtures",
        "Mizer.app/Contents/Resources/fixtures/qlcplus",
    )?;
    artifact.link_source(
        "components/connections/protocols/midi/device-profiles/profiles",
        "Mizer.app/Contents/Resources/device-profiles/midi",
    )?;
    artifact.copy_settings("Mizer.app/Contents/MacOS/settings.toml", |settings| {
        settings.paths.midi_device_profiles =
            PathBuf::from("Contents/Resources/device-profiles/midi");
        settings.paths.fixture_libraries.open_fixture_library = Some(PathBuf::from(
            "Contents/Resources/fixtures/open-fixture-library",
        ));
        settings.paths.fixture_libraries.qlcplus =
            Some(PathBuf::from("Contents/Resources/fixtures/qlcplus"));
        settings.paths.fixture_libraries.gdtf =
            Some(PathBuf::from("Contents/Resources/fixtures/gdtf"));
    })?;

    Ok(())
}

fn build_dir(cwd: &Path) -> PathBuf {
    cwd.join("target/release")
}

fn create_artifact_dir(cwd: &Path) -> anyhow::Result<PathBuf> {
    let artifact_path = cwd.join("artifact");
    if artifact_path.exists() {
        fs::remove_dir_all(&artifact_path)?;
    } else {
        fs::create_dir_all(&artifact_path)?;
    }

    Ok(artifact_path)
}

struct Artifact {
    cwd: PathBuf,
    build_dir: PathBuf,
    artifact_dir: PathBuf,
}

impl Artifact {
    fn new() -> anyhow::Result<Self> {
        let cwd = std::env::current_dir()?;
        let path = build_dir(&cwd);
        let artifact_dir = create_artifact_dir(&cwd)?;

        Ok(Artifact {
            cwd,
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
            println!("Linking from {:?} to {:?}", from, to);
            std::os::unix::fs::symlink(&from, &to)?;
        }

        Ok(())
    }

    fn link_source<P: AsRef<Path>, Q: AsRef<Path>>(&self, from: P, to: Q) -> anyhow::Result<()> {
        let from = self.cwd.join(from);
        let to = self.artifact_dir.join(to);

        if let Some(parent) = to.parent() {
            fs::create_dir_all(parent)?;
        }

        #[cfg(target_family = "unix")]
        {
            println!("Linking from {:?} to {:?}", from, to);
            std::os::unix::fs::symlink(&from, &to)?;
        }

        Ok(())
    }

    fn copy_settings<P: AsRef<Path>, F: FnOnce(&mut Settings)>(
        &self,
        to: P,
        editor: F,
    ) -> anyhow::Result<()> {
        let to = self.artifact_dir.join(to);
        let mut settings = Settings::load()?;
        editor(&mut settings);
        settings.save_to(to)?;

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

                let filename_matches = file
                    .file_name()
                    .into_string()
                    .unwrap_or_default()
                    .ends_with(suffix);

                println!(
                    "Matching {:?} with suffix {} = {}",
                    &file, suffix, filename_matches
                );
                if filename_matches {
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
