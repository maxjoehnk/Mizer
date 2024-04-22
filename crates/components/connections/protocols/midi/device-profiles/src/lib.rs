use std::fs;
use std::fs::DirEntry;
use std::path::Path;

use anyhow::Context;

use mizer_util::find_path;

pub use crate::profile::{
    Control, ControlStep, ControlStepVariant, DeviceControl, DeviceProfile, Group,
    MidiDeviceControl, Page,
};
use crate::profile_reader::read_profile;

mod profile;
mod profile_reader;

pub(crate) mod scripts;

pub fn load_profiles<P: AsRef<Path>>(path: P) -> anyhow::Result<Vec<DeviceProfile>> {
    if let Some(path) = find_path(path) {
        tracing::debug!("Loading MIDI Device Profiles from {path:?}");
        let dir_iterator = fs::read_dir(&path).context("listing profiles")?;
        let mut profiles = Vec::new();
        for dir in dir_iterator {
            let dir = dir?;
            match load_dir(&dir) {
                Err(err) => {
                    tracing::error!("Error loading profile {}: {:?}", dir.path().display(), err);
                    continue;
                }
                Ok(Some(profile)) => profiles.push(profile),
                _ => {}
            }
        }
        tracing::info!("Loaded {} MIDI Device Profiles", profiles.len());
        tracing::trace!("{:?}", profiles);

        Ok(profiles)
    } else {
        Ok(Default::default())
    }
}

fn load_dir(dir: &DirEntry) -> anyhow::Result<Option<DeviceProfile>> {
    if !dir.metadata()?.is_dir() {
        return Ok(None);
    }
    let profile = read_profile(&dir.path()).context(format!("Reading profile {dir:?}"))?;

    Ok(Some(profile))
}
