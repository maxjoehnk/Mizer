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

    let mut frame_builder: QuarterFrameBuilder = Default::default();
    let receiver = device.events();
    loop {
        if let Some(event) = receiver.read() {
            if let MidiMessage::Timecode(tc, frame_rate) = event.msg {
                println!(
                    "{:0>2}:{:0>2}:{:0>2}.{:0>2} ({:?})",
                    tc.hours, tc.minutes, tc.seconds, tc.frames, frame_rate
                )
            }else if let MidiMessage::TimecodeQuarterFrame(frame, value) = event.msg {
                if let Some((tc, frame_rate)) = frame_builder.push_frame(frame, value) {
                    println!(
                        "{:0>2}:{:0>2}:{:0>2}.{:0>2} ({:?})",
                        tc.hours, tc.minutes, tc.seconds, tc.frames, frame_rate
                    )
                }
            }
        }
    }
}

#[derive(Default)]
struct QuarterFrameBuilder(MtcTimecode);

impl QuarterFrameBuilder {
    fn push_frame(&mut self, frame: u8, value: u8) -> Option<(MtcTimecode, FrameRate)> {
        if frame == 0 {
            self.0 = MtcTimecode::default();
        }
        match frame {
            0 => self.0.frames = value,
            1 => self.0.frames |= value << 4,
            2 => self.0.seconds = value,
            3 => self.0.seconds |= value << 4,
            4 => self.0.minutes = value,
            5 => self.0.minutes |= value << 4,
            6 => self.0.hours = value,
            7 => self.0.hours |= (value & 0b0001) << 4,
            _ => {},
        }

        if frame == 7 {
            let frame_rate = (value & 0b0110) >> 1;
            Some((self.0, frame_rate.try_into().unwrap()))
        } else {
            None
        }
    }
}

