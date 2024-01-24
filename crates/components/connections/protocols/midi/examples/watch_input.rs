use mizer_protocol_midi::*;

pub fn main() -> anyhow::Result<()> {
    let connection_manager = MidiConnectionManager::new(MidiDeviceProvider::new());
    let devices = connection_manager.list_available_devices();

    let args = std::env::args().collect::<Vec<_>>();
    let device = devices
        .into_iter()
        .find(|device| device.name.contains(&args[1]));
    let device = device.expect("no matching device found");

    let device = device.connect()?;

    let receiver = device.events();
    for event in receiver.iter() {
        println!("{:?}", event.msg);
    }

    Ok(())
}
