use mizer_protocol_midi::*;

pub fn main() -> anyhow::Result<()> {
    let connection_manager = MidiConnectionManager::new();
    let devices = connection_manager.list_available_devices();

    println!("{:#?}", devices);

    Ok(())
}
