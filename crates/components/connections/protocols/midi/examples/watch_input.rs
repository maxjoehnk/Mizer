use mizer_protocol_midi::*;
use mizer_protocol_midi::background_discovery::MidiBackgroundDiscovery;

pub fn main() -> anyhow::Result<()> {
    mizer_console::__init();
    let provider = MidiDeviceProvider::new();
    let background_discovery = MidiBackgroundDiscovery::new(&provider);
    background_discovery.start()?;
    std::thread::sleep(std::time::Duration::from_secs(5));
    let connection_manager = MidiConnectionManager::new(provider);
    let devices = connection_manager.list_available_devices();

    let args = std::env::args().collect::<Vec<_>>();
    let device = devices
        .into_iter()
        .find(|device| device.name.contains(&args[1]));
    let device = device.expect("no matching device found");

    let device = device.connect()?;

    println!("Listening for events...");

    let receiver = device.events();
    loop {
        if let Some(event) = receiver.read() {
            println!("{:?}", event.msg);
        }
    }
}
