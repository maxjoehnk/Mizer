use mizer_protocol_midi::*;

pub fn main() -> anyhow::Result<()> {
    let provider = MidiDeviceProvider::new();
    let devices = provider.list_devices()?;

    println!("{:#?}", devices);

    Ok(())
}
