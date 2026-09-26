use mizer_protocol_midi::*;
use mizer_protocol_midi::background_discovery::*;

pub fn main() -> anyhow::Result<()> {
    mizer_console::__init();
    let provider = MidiDeviceProvider::new();
    let background_discovery = MidiBackgroundDiscovery::new(&provider);
    background_discovery.start()?;
    std::thread::sleep(std::time::Duration::from_secs(5));
    let connection_manager = MidiConnectionManager::new(provider);
    let devices = connection_manager.list_available_devices();

    println!("{:#?}", devices);

    Ok(())
}
