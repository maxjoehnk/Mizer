use mizer_midi_device_profiles::load_profiles;

pub fn main() -> anyhow::Result<()> {
    let args = std::env::args().collect::<Vec<_>>();
    let profiles = load_profiles()?;
    let profile = profiles.into_iter().find(|profile| profile.id == args[1]);

    let profile = profile.expect("unknown device profile");

    println!("{:#?}", profile);

    Ok(())
}
