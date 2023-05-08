use mizer_midi_device_profiles::load_profiles;

#[test]
fn load_profiles_should_not_fail() -> anyhow::Result<()> {
    let result = load_profiles("profiles")?;

    assert!(!result.is_empty());
    Ok(())
}
