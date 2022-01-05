pub use crate::profile::{Control, ControlType, DeviceProfile, Group, Page};
use crate::profile_reader::read_profile;
use std::fs;

mod profile;
mod profile_reader;

pub(crate) mod scripts;

pub fn load_profiles(path: &str) -> anyhow::Result<Vec<DeviceProfile>> {
    let dir_iterator = fs::read_dir(path)?;
    let mut profiles = Vec::new();
    for dir in dir_iterator {
        let dir = dir?;
        let profile = read_profile(&dir.path())?;
        profiles.push(profile);
    }
    log::info!("Loaded {} MIDI Device Profiles", profiles.len());
    log::trace!("{:?}", profiles);
    Ok(profiles)
}
