use std::fs;
use std::fs::File;
use std::path::{Path, PathBuf};

use mizer_settings::Settings;

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
    artifact.link_to("deps/libndi.so.5", "lib/libndi.so.5")?;
    artifact.link_source(
        "crates/components/fixtures/open-fixture-library/.fixtures",
        "fixtures/open-fixture-library",
    )?;
    artifact.link_source(
        "crates/components/fixtures/qlcplus/.fixtures",
        "fixtures/qlcplus",
    )?;
    artifact.link_source(
        "crates/components/fixtures/mizer-definitions/.fixtures",
        "fixtures/mizer",
    )?;
    artifact.link_source(
        "crates/components/connections/protocols/midi/device-profiles/profiles",
        "device-profiles/midi",
    )?;
    artifact.copy_settings("settings.toml", |settings| {
        settings.paths.media_storage = PathBuf::from("~/.mizer-media");
        settings.paths.midi_device_profiles = PathBuf::from("device-profiles/midi");
        settings.paths.fixture_libraries.open_fixture_library =
            Some(PathBuf::from("fixtures/open-fixture-library"));
        settings.paths.fixture_libraries.qlcplus = Some(PathBuf::from("fixtures/qlcplus"));
        settings.paths.fixture_libraries.qlcplus = Some(PathBuf::from("fixtures/qlcplus"));
        settings.paths.fixture_libraries.gdtf = Some(PathBuf::from("fixtures/gdtf"));
        settings.paths.fixture_libraries.mizer = Some(PathBuf::from("fixtures/mizer"));
    })?;

    Ok(())
}

#[cfg(target_os = "macos")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.link("Mizer.app")?;
    artifact.link_all_with_suffix_to(".dylib", "Mizer.app/Contents/Frameworks")?;
    artifact.link_to(
        "deps/libndi.dylib",
        "Mizer.app/Contents/Frameworks/libndi.dylib",
    )?;
    artifact.link_all_with_suffix_to(".framework", "Mizer.app/Contents/Frameworks")?;
    artifact.link_source(
        "crates/components/fixtures/open-fixture-library/.fixtures",
        "Mizer.app/Contents/Resources/fixtures/open-fixture-library",
    )?;
    artifact.link_source(
        "crates/components/fixtures/qlcplus/.fixtures",
        "Mizer.app/Contents/Resources/fixtures/qlcplus",
    )?;
    artifact.link_source(
        "crates/components/fixtures/mizer-definitions/.fixtures",
        "Mizer.app/Contents/Resources/fixtures/mizer",
    )?;
    artifact.link_source(
        "crates/components/connections/protocols/midi/device-profiles/profiles",
        "Mizer.app/Contents/Resources/device-profiles/midi",
    )?;
    artifact.copy_settings("Mizer.app/Contents/MacOS/settings.toml", |settings| {
        settings.paths.media_storage = PathBuf::from("~/.mizer-media");
        settings.paths.midi_device_profiles =
            PathBuf::from("Contents/Resources/device-profiles/midi");
        settings.paths.fixture_libraries.open_fixture_library = Some(PathBuf::from(
            "Contents/Resources/fixtures/open-fixture-library",
        ));
        settings.paths.fixture_libraries.qlcplus =
            Some(PathBuf::from("Contents/Resources/fixtures/qlcplus"));
        settings.paths.fixture_libraries.gdtf =
            Some(PathBuf::from("Contents/Resources/fixtures/gdtf"));
        settings.paths.fixture_libraries.mizer =
            Some(PathBuf::from("Contents/Resources/fixtures/mizer"));
    })?;

    change_rpath(&artifact.artifact_dir, "@executable_path", "@executable_path/../Frameworks")?;
    generate_icns(&artifact.cwd, &artifact.artifact_dir)?;

    Ok(())
}

#[cfg(target_os = "macos")]
fn generate_icns(source_dir: &Path, artifact_dir: &Path) -> anyhow::Result<()> {
    use icns::*;

    let mut icns = IconFamily::new();
    let path = source_dir.join("assets/logo@512.png");
    let file = File::open(path)?;
    let image = Image::read_png(file)?;
    icns.add_icon(&image)?;

    let output_path = artifact_dir.join("Mizer.app/Contents/Resources/AppIcon.icns");
    let output_file = File::create(output_path)?;
    icns.write(output_file)?;

    Ok(())
}

#[cfg(target_os = "macos")]
fn change_rpath(artifact_dir: &Path, from: &str, to: &str) -> anyhow::Result<()> {
    let path = artifact_dir.join("Mizer.app/Contents/MacOS/mizer");
    let output = std::process::Command::new("install_name_tool")
        .arg("-rpath")
        .arg(from)
        .arg(to)
        .arg(&path)
        .output()?;
    if !output.status.success() {
        println!("Failed to change rpath for {:?}", path);
        println!("stdout: {}", String::from_utf8_lossy(&output.stdout));
        println!("stderr: {}", String::from_utf8_lossy(&output.stderr));

        anyhow::bail!("Failed to change rpath for {:?}", path);
    }

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
