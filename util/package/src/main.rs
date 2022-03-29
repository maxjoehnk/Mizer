use std::fs;
use std::path::{Path, PathBuf};
use mizer_settings::Settings;

#[cfg(target_os = "linux")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.link("mizer")?;
    artifact.link("data")?;
    artifact.link("lib")?;
    artifact.link_source("components/fixtures/open-fixture-library/.fixtures", "fixtures/open-fixture-library")?;
    artifact.link_source("components/fixtures/qlcplus/.fixtures", "fixtures/qlcplus")?;
    artifact.link_source("components/fixtures/gdtf/.fixtures", "fixtures/gdtf")?;
    artifact.link_source("components/connections/protocols/midi/device-profiles/profiles", "device-profiles/midi")?;
    artifact.copy_settings("settings.toml", |settings| {
        settings.paths.midi_device_profiles = PathBuf::from("device-profiles/midi");
        settings.paths.fixture_libraries.open_fixture_library = Some(PathBuf::from("fixtures/open-fixture-library"));
        settings.paths.fixture_libraries.qlcplus = Some(PathBuf::from("fixtures/qlcplus"));
        settings.paths.fixture_libraries.gdtf = Some(PathBuf::from("fixtures/gdtf"));
    })?;

    Ok(())
}

#[cfg(target_os = "macos")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.link("Mizer.app")?;
    artifact.link_to("mizer", "Mizer.app/Contents/MacOS/mizer")?;
    artifact.link_all_with_suffix_to(".dylib", "Mizer.app/Contents/MacOS")?;
    artifact.link_all_with_suffix_to(".framework", "Mizer.app/Contents/Frameworks")?;
    artifact.write_file("Mizer.app/Contents/Info.plist", generate_info_plist)?;

    Ok(())
}

fn generate_info_plist(file: &mut fs::File) -> anyhow::Result<()> {
    use apple_bundle::info_plist::prelude::*;
    let plist = InfoPlist {
        identification: Identification {
            bundle_identifier: "me.maxjoehnk.mizer".into(),
            ..Default::default()
        },
        naming: Naming {
            bundle_name: Some("Mizer".into()),
            ..Default::default()
        },
        bundle_version: BundleVersion {
            // TODO: read from Cargo.toml
            bundle_short_version_string: Some("0.1.0".into()),
            ..Default::default()
        },
        operating_system_version: OperatingSystemVersion {
            minimum_system_version: Some("10.13".into()),
            ..Default::default()
        },
        launch: Launch {
            bundle_executable: Some("mizer".into()),
            ..Default::default()
        },
        graphics: Graphics {
            high_resolution_capable: Some(true),
            ..Default::default()
        },
        ..Default::default()
    };
    apple_bundle::plist::to_writer_xml(file, &plist)?;

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

    fn copy_settings<P: AsRef<Path>, F: FnOnce(&mut Settings)>(&self, to: P, editor: F) -> anyhow::Result<()> {
        let to = self.artifact_dir.join(to);
        let mut settings = Settings::load()?;
        editor(&mut settings);
        settings.save_to(to)?;

        Ok(())
    }

    fn write_file<P: AsRef<Path>, F: FnOnce(&mut fs::File) -> anyhow::Result<()>>(&self, path: P, writer: F) -> anyhow::Result<()> {
        let path = self.artifact_dir.join(path);
        let mut file = std::fs::File::create(path)?;
        writer(&mut file)?;

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

                println!("Matching {:?} with suffix {} = {}", &file, suffix, is_file && filename_matches);
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
