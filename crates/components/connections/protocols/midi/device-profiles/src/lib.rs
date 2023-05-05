pub use crate::profile::{Control, ControlType, DeviceProfile, Group, Page};
use crate::profile_reader::read_profile;
use mizer_util::find_path;
use std::fs;
use std::path::Path;

mod profile;
mod profile_reader;

pub(crate) mod scripts;

pub fn load_profiles<P: AsRef<Path>>(path: P) -> anyhow::Result<Vec<DeviceProfile>> {
    if let Some(path) = find_path(path) {
        log::trace!("Loading MIDI Device Profiles from {path:?}");
        let dir_iterator = fs::read_dir(&path)?;
        let mut profiles = Vec::new();
        for dir in dir_iterator {
            let dir = dir?;
            let profile = read_profile(&dir.path())?;
            profiles.push(profile);
        }
        log::info!("Loaded {} MIDI Device Profiles", profiles.len());
        log::trace!("{:?}", profiles);

        Ok(profiles)
    } else {
        Ok(Default::default())
    }
}
