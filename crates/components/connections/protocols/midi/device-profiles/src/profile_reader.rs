use crate::profile::{DeviceProfile, DeviceProfileConfig, ProfileErrors, ProfileScripts};
use crate::scripts::outputs::parse_outputs_ast;
use crate::scripts::pages::get_pages;
use anyhow::Context;
use std::fs;
use std::path::Path;

pub fn read_profile(path: &Path) -> anyhow::Result<DeviceProfile> {
    let config = read_config(path)?;
    let mut profile = DeviceProfile {
        id: config.id,
        manufacturer: config.manufacturer,
        name: config.name,
        keyword: config.keyword,
        pages: config.pages,
        output_script: None,
        layout: None,
        engine: Default::default(),
        errors: Default::default(),
        file_path: path.to_path_buf(),
    };
    if let Err(err) = generate_pages(&config.scripts, &mut profile, path) {
        profile
            .errors
            .push(ProfileErrors::PagesLoadingError(err.to_string()));
        tracing::error!(
            "Error generating pages for profile {}: {:?}",
            profile.name,
            err
        );
    }
    if let Err(err) = generate_output_script(&config.scripts, &mut profile, path) {
        profile
            .errors
            .push(ProfileErrors::OutputScriptLoadingError(err.to_string()));
        tracing::error!(
            "Error generating output script for profile {}: {:?}",
            profile.name,
            err
        );
    }
    if let Err(err) = read_layout(&config.layout_file, &mut profile, path) {
        profile
            .errors
            .push(ProfileErrors::LayoutLoadingError(err.to_string()));
        tracing::error!(
            "Error reading layout for profile {}: {:?}",
            profile.name,
            err
        );
    }

    Ok(profile)
}

fn read_config(path: &Path) -> anyhow::Result<DeviceProfileConfig> {
    let profile_path = path.join("profile.yml");
    let mut file = fs::File::open(profile_path)?;
    let profile = serde_yaml::from_reader(&mut file)?;

    Ok(profile)
}

fn generate_pages(
    scripts: &Option<ProfileScripts>,
    profile: &mut DeviceProfile,
    path: &Path,
) -> anyhow::Result<()> {
    if let Some(script_name) = scripts.as_ref().and_then(|scripts| scripts.pages.as_ref()) {
        profile.pages = get_pages(path.join(script_name))?;
    }

    Ok(())
}

fn generate_output_script(
    scripts: &Option<ProfileScripts>,
    profile: &mut DeviceProfile,
    path: &Path,
) -> anyhow::Result<()> {
    if let Some(script_name) = scripts
        .as_ref()
        .and_then(|scripts| scripts.outputs.as_ref())
    {
        let script = parse_outputs_ast(&profile.engine, path.join(script_name)).context(
            format!("Compiling output script for profile {}", profile.name),
        )?;
        profile.output_script = Some(script);
    }

    Ok(())
}

fn read_layout(
    layout_file: &Option<String>,
    profile: &mut DeviceProfile,
    path: &Path,
) -> anyhow::Result<()> {
    if let Some(filename) = layout_file.as_ref() {
        let layout_path = path.join(filename);
        let layout = std::fs::read_to_string(layout_path)?;
        profile.layout = Some(layout);
    }

    Ok(())
}
