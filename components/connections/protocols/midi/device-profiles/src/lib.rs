use crate::profile::DeviceProfile;
use crate::profile_reader::read_profile;
use std::fs;

mod profile;
mod profile_reader;

pub(crate) mod scripts;

pub fn load_profiles() -> anyhow::Result<Vec<DeviceProfile>> {
    let dir_iterator = fs::read_dir("profiles")?;
    let mut profiles = Vec::new();
    for dir in dir_iterator {
        let dir = dir?;
        let profile = read_profile(&dir.path())?;
        profiles.push(profile);
    }
    Ok(profiles)
}
