use mizer_protocol_laser::ilda::IldaMediaReader;
use mizer_protocol_laser::laser::ether_dream::EtherDreamLaser;
use mizer_protocol_laser::laser::Laser;

pub fn main() {
    let args = std::env::args().collect::<Vec<_>>();
    let mut media_reader = IldaMediaReader::open_file(&args[1]).unwrap();
    let frames = media_reader.read_frames().unwrap();

    // TODO: update this example or maybe the public api surface of the laser discovery
    // let mut devices = EtherDreamLaser::find_devices().unwrap();
    // if let Some(device) = devices.next() {
    //     let mut device = device.unwrap();
    //     println!("sending frames");
    //     for frame in &frames {
    //         device.write_frame(frame.clone()).unwrap();
    //     }
    // }
}
