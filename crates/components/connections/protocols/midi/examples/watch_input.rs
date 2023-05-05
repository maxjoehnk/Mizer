use mizer_protocol_midi::*;

pub fn main() -> anyhow::Result<()> {
    let provider = MidiDeviceProvider::new();
    let devices = provider.list_devices()?;

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
