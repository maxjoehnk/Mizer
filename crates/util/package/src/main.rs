use anyhow::Context;
use std::fs;
use std::fs::{DirEntry, File};
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
        settings.paths.midi_device_profiles = vec![
            PathBuf::from("device-profiles/midi"),
            PathBuf::from("~/Documents/Mizer/Midi Device Profiles"),
        ]
        .into();
        settings.paths.fixture_libraries.open_fixture_library = vec![
            PathBuf::from("fixtures/open-fixture-library"),
            PathBuf::from("~/Documents/Mizer/Fixture Definitions/Open Fixture Library"),
        ]
        .into();
        settings.paths.fixture_libraries.qlcplus = vec![
            PathBuf::from("fixtures/qlcplus"),
            PathBuf::from("~/Documents/Mizer/Fixture Definitions/QLC+"),
        ]
        .into();
        settings.paths.fixture_libraries.gdtf = vec![
            PathBuf::from("fixtures/gdtf"),
            PathBuf::from("~/Documents/Mizer/Fixture Definitions/GDTF"),
        ]
        .into();
        settings.paths.fixture_libraries.mizer = vec![
            PathBuf::from("fixtures/mizer"),
            PathBuf::from("~/Documents/Mizer/Fixture Definitions/Mizer"),
        ]
        .into();
    })?;

    Ok(())
}

#[cfg(target_os = "macos")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.copy("Mizer.app")?;
    artifact.copy_all_with_suffix_to(".dylib", "Mizer.app/Contents/Frameworks")?;
    artifact.copy_to(
        "deps/libndi.dylib",
        "Mizer.app/Contents/Frameworks/libndi.dylib",
    )?;
    artifact.copy_all_with_suffix_to(".framework", "Mizer.app/Contents/Frameworks")?;
    artifact.copy_source(
        "crates/components/fixtures/open-fixture-library/.fixtures",
        "Mizer.app/Contents/Resources/fixtures/open-fixture-library",
    )?;
    artifact.copy_source(
        "crates/components/fixtures/qlcplus/.fixtures",
        "Mizer.app/Contents/Resources/fixtures/qlcplus",
    )?;
    artifact.copy_source(
        "crates/components/fixtures/mizer-definitions/.fixtures",
        "Mizer.app/Contents/Resources/fixtures/mizer",
    )?;
    artifact.copy_source(
        "crates/components/connections/protocols/midi/device-profiles/profiles",
        "Mizer.app/Contents/Resources/device-profiles/midi",
    )?;
    artifact.copy_settings("Mizer.app/Contents/Resources/settings.toml", |settings| {
        settings.paths.media_storage = PathBuf::from("~/.mizer-media");
        settings.paths.midi_device_profiles = vec![
            PathBuf::from("../Resources/device-profiles/midi"),
            PathBuf::from("~/Documents/Mizer/Midi Device Profiles"),
        ]
        .into();
        settings.paths.fixture_libraries.open_fixture_library = vec![
            PathBuf::from("../Resources/fixtures/open-fixture-library"),
            PathBuf::from("~/Documents/Mizer/Fixture Definitions/Open Fixture Library"),
        ]
        .into();
        settings.paths.fixture_libraries.qlcplus = vec![
            PathBuf::from("../Resources/fixtures/qlcplus"),
            PathBuf::from("~/Documents/Mizer/Fixture Definitions/QLC+"),
        ]
        .into();
        settings.paths.fixture_libraries.gdtf = vec![
            PathBuf::from("../Resources/fixtures/gdtf"),
            PathBuf::from("~/Documents/Mizer/Fixture Definitions/GDTF"),
        ]
        .into();
        settings.paths.fixture_libraries.mizer = vec![
            PathBuf::from("../Resources/fixtures/mizer"),
            PathBuf::from("~/Documents/Mizer/Fixture Definitions/Mizer"),
        ]
        .into();
    })?;

    change_rpath(
        &artifact.artifact_dir,
        "@executable_path",
        "@executable_path/../Frameworks",
    )?;
    generate_icns(&artifact.cwd, &artifact.artifact_dir)?;

    Ok(())
}

#[cfg(target_os = "windows")]
fn main() -> anyhow::Result<()> {
    let artifact = Artifact::new()?;
    artifact.copy("mizer.exe")?;
    artifact.link("data")?;
    artifact.link("lib")?;
    artifact.link_to("libmizer_ui_ffi.dll", "lib/libmizer_ui_ffi.dll")?;
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
        settings.paths.midi_device_profiles = vec![
            PathBuf::from("device-profiles\\midi"),
            PathBuf::from("~\\Documents\\Mizer\\Midi Device Profiles"),
        ]
        .into();
        settings.paths.fixture_libraries.open_fixture_library = vec![
            PathBuf::from("fixtures\\open-fixture-library"),
            PathBuf::from("~\\Documents\\Mizer\\Fixture Definitions\\Open Fixture Library"),
        ]
        .into();
        settings.paths.fixture_libraries.qlcplus = vec![
            PathBuf::from("fixtures\\qlcplus"),
            PathBuf::from("~\\Documents\\Mizer\\Fixture Definitions\\QLC+"),
        ]
        .into();
        settings.paths.fixture_libraries.gdtf = vec![
            PathBuf::from("fixtures\\gdtf"),
            PathBuf::from("~\\Documents\\Mizer\\Fixture Definitions\\GDTF"),
        ]
        .into();
        settings.paths.fixture_libraries.mizer = vec![
            PathBuf::from("fixtures\\mizer"),
            PathBuf::from("~\\Documents\\Mizer\\Fixture Definitions\\Mizer"),
        ]
        .into();
    })?;

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

    fn copy<P: AsRef<Path>>(&self, file: P) -> anyhow::Result<()> {
        self.copy_to(file.as_ref(), file.as_ref())
    }

    fn copy_to<P: AsRef<Path>, Q: AsRef<Path>>(&self, from: P, to: Q) -> anyhow::Result<()> {
        let from = self.build_dir.join(from);
        let to = self.artifact_dir.join(to);

        fs::create_dir_all(to.parent().unwrap())?;

        copy_all(&from, &to).context(format!("Copying from {from:?} to {to:?}"))?;

        Ok(())
    }

    fn copy_source<P: AsRef<Path>, Q: AsRef<Path>>(&self, from: P, to: Q) -> anyhow::Result<()> {
        let from = self.cwd.join(from);
        let to = self.artifact_dir.join(to);

        if let Some(parent) = to.parent() {
            fs::create_dir_all(parent)?;
        }

        copy_all(&from, &to).context(format!("Copying from {from:?} to {to:?}"))?;

        Ok(())
    }

    fn copy_all_with_suffix_to<P: AsRef<Path>>(
        &self,
        suffix: &str,
        target: P,
    ) -> anyhow::Result<()> {
        let files = self.get_files_with_suffix(suffix)?;

        for file in files {
            self.copy_to(file.path(), target.as_ref().join(&file.file_name()))?;
        }

        Ok(())
    }

    fn link<P: AsRef<Path>>(&self, file: P) -> anyhow::Result<()> {
        self.link_to(file.as_ref(), file.as_ref())
    }

    fn link_to<P: AsRef<Path>, Q: AsRef<Path>>(&self, from: P, to: Q) -> anyhow::Result<()> {
        let from = self.build_dir.join(from);
        let to = self.artifact_dir.join(to);

        fs::create_dir_all(to.parent().unwrap())?;

        link(&from, &to)?;

        Ok(())
    }

    fn link_source<P: AsRef<Path>, Q: AsRef<Path>>(&self, from: P, to: Q) -> anyhow::Result<()> {
        let from = self.cwd.join(from);
        let to = self.artifact_dir.join(to);

        if let Some(parent) = to.parent() {
            fs::create_dir_all(parent)?;
        }

        link(&from, &to)?;

        Ok(())
    }

    fn link_all_with_suffix_to<P: AsRef<Path>>(
        &self,
        suffix: &str,
        target: P,
    ) -> anyhow::Result<()> {
        let files = self.get_files_with_suffix(suffix)?;

        for file in files {
            self.link_to(file.path(), target.as_ref().join(&file.file_name()))?;
        }

        Ok(())
    }

    fn get_files_with_suffix(&self, suffix: &str) -> anyhow::Result<Vec<DirEntry>> {
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
        Ok(files)
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
}

fn link(from: &Path, to: &Path) -> anyhow::Result<()> {
    if fs::symlink_metadata(to).is_ok() {
        fs::remove_file(to)?;
    }
    
    #[cfg(target_family = "unix")]
    {
        println!("Linking from {:?} to {:?}", from, to);
        std::os::unix::fs::symlink(from, to)?;
    }
    
    Ok(())
}

fn copy_all(from: &Path, to: &Path) -> anyhow::Result<()> {
    if from.is_dir() {
        fs::remove_dir_all(to).ok();
        fs::create_dir_all(to)?;
        let files = fs::read_dir(from)?;
        for file in files {
            let file = file?;
            let from = file.path();
            let to = to.join(file.file_name());
            if fs::symlink_metadata(&from)?.is_symlink() {
                let target = fs::read_link(&from)?;
                if target.is_absolute() {
                    println!("Copying from {:?} to {:?}", target, to);
                    fs::copy(&target, &to)?;
                } else {
                    link(&target, &to)?;
                }
                continue;
            }
            if from.is_dir() {
                println!("Copying directory from {:?} to {:?}", from, to);
                fs::create_dir_all(&to)?;
                copy_all(&from, &to)?;
                continue;
            }
            println!("Copying from {:?} to {:?}", from, to);
            fs::copy(&from, &to)?;
        }
    } else {
        fs::remove_file(to).ok();

        println!("Copying from {:?} to {:?}", from, to);
        fs::copy(from, to).context("Copying single file")?;
    }

    Ok(())
}
