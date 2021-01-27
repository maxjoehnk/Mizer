use mizer_protocol_laser::ilda::IldaMediaReader;
use mizer_protocol_laser::laser::ether_dream::EtherDreamLaser;
use mizer_protocol_laser::laser::Laser;

pub fn main() {
    let args = std::env::args().collect::<Vec<_>>();
    let mut media_reader = IldaMediaReader::open_file(&args[1]).unwrap();
    let frames = media_reader.read_frames().unwrap();

    let devices = EtherDreamLaser::find_devices().unwrap();
    println!("found {} ether dream devices", devices.len());
    for mut device in devices {
        println!("sending frames");
        for frame in &frames {
            device.write_frame(frame.clone()).unwrap();
        }
    }
}
