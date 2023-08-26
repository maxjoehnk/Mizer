use std::convert::TryFrom;
use std::io::{BufRead, Write};
use std::num::ParseIntError;
use std::str::FromStr;

use mizer_protocol_midi::*;

pub fn main() -> anyhow::Result<()> {
    let connection_manager = MidiConnectionManager::new();
    let devices = connection_manager.list_available_devices();

    let args = std::env::args().collect::<Vec<_>>();
    let device = devices
        .into_iter()
        .find(|device| device.name.contains(&args[1]));
    let device = device.expect("no matching device found");

    let mut device = device.connect()?;

    let reader = std::io::stdin();

    write_prompt();
    for line in reader.lock().lines() {
        let line = line?;
        let parts = line.split(' ').collect::<Vec<_>>();
        match parts.as_slice() {
            ["note", channel, note, value] => {
                let channel = u8::from_str(channel)?;
                let note = u8::from_str(note)?;
                let value = u8::from_str(value)?;
                let channel = Channel::try_from(channel - 1).unwrap();

                let msg = MidiMessage::NoteOn(channel, note, value);
                device.write(msg)?;
            }
            ["cc", channel, note, value] => {
                let channel = u8::from_str(channel)?;
                let note = u8::from_str(note)?;
                let value = u8::from_str(value)?;
                let channel = Channel::try_from(channel - 1).unwrap();

                let msg = MidiMessage::ControlChange(channel, note, value);
                device.write(msg)?;
            }
            ["sysex", manu1, manu2, manu3, model, data @ ..] => {
                let manu1 = u8::from_str(manu1)?;
                let manu2 = u8::from_str(manu2)?;
                let manu3 = u8::from_str(manu3)?;
                let model = u8::from_str(model)?;
                let data = data
                    .iter()
                    .map(|d| u8::from_str(d))
                    .collect::<Result<Vec<_>, ParseIntError>>()?;

                let msg = MidiMessage::Sysex((manu1, manu2, manu3), model, data);
                device.write(msg)?;
            }
            _ => (),
        }
        write_prompt();
    }

    Ok(())
}

fn write_prompt() {
    print!("> ");
    std::io::stdout().flush().unwrap();
}
