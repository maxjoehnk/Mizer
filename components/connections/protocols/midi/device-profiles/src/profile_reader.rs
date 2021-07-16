use crate::profile::DeviceProfile;
use crate::scripts::outputs::parse_outputs_ast;
use crate::scripts::pages::get_pages;
use std::fs;
use std::path::Path;

pub fn read_profile(path: &Path) -> anyhow::Result<DeviceProfile> {
    let mut profile = read_config(path)?;
    generate_pages(&mut profile, path)?;
    generate_output_script(&mut profile, path)?;

    Ok(profile)
}

fn read_config(path: &Path) -> anyhow::Result<DeviceProfile> {
    let profile_path = path.join("profile.yml");
    let mut file = fs::File::open(profile_path)?;
    let profile = serde_yaml::from_reader(&mut file)?;

    Ok(profile)
}

fn generate_pages(profile: &mut DeviceProfile, path: &Path) -> anyhow::Result<()> {
    if let Some(script_name) = profile
        .scripts
        .as_ref()
        .and_then(|scripts| scripts.pages.as_ref())
    {
        profile.pages = get_pages(path.join(script_name))?;
    }

    Ok(())
}

fn generate_output_script(profile: &mut DeviceProfile, path: &Path) -> anyhow::Result<()> {
    if let Some(script_name) = profile
        .scripts
        .as_ref()
        .and_then(|scripts| scripts.outputs.as_ref())
    {
        profile.output_script = Some(parse_outputs_ast(path.join(script_name))?);
    }

    Ok(())
}
