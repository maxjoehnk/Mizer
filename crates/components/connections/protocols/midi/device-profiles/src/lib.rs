pub use crate::profile::{Control, DeviceControl, DeviceProfile, Group, MidiDeviceControl, Page};
use crate::profile_reader::read_profile;
use anyhow::Context;
use mizer_util::find_path;
use std::fs;
use std::path::Path;

mod profile;
mod profile_reader;

pub(crate) mod scripts;

pub fn load_profiles<P: AsRef<Path>>(path: P) -> anyhow::Result<Vec<DeviceProfile>> {
    if let Some(path) = find_path(path) {
        log::trace!("Loading MIDI Device Profiles from {path:?}");
        let dir_iterator = fs::read_dir(&path).context("listing profiles")?;
        let mut profiles = Vec::new();
        for dir in dir_iterator {
            let dir = dir?;
            let profile = read_profile(&dir.path()).context(format!("Reading profile {dir:?}"))?;
            profiles.push(profile);
        }
        log::info!("Loaded {} MIDI Device Profiles", profiles.len());
        log::trace!("{:?}", profiles);

        Ok(profiles)
    } else {
        Ok(Default::default())
    }
}
