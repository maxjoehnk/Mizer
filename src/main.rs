use mizer_node_api::*;

use crate::nodes::*;

mod nodes;

fn main() {
    env_logger::init();
    let mut logger = LogNode::new();
    let mut artnet = ArtnetOutputNode::new("0.0.0.0", None);
    let mut converter1 = ConvertToDmxNode::new(None, Some(0));
    let mut converter2 = ConvertToDmxNode::new(None, Some(18));
    let mut oscillator = OscillatorNode::new(OscillatorType::Sine);
    let mut clock = ClockNode::new(128f64);
    let mut osc = OscInputNode::new(None, 7000, "/1/fader1");
    let mut file = VideoFileNode::new("/home/max/Code/0_mizer/mizer-video-projector/assets/DOC000 Alley Booze - H.264 1080p.mov");
    let mut effect = VideoEffectNode::new(VideoEffectType::Twirl);
    let mut screen = VideoOutputNode::new();
    file.connect_to_video_input(&mut effect);
    effect.connect_to_video_input(&mut screen);
    clock.connect_to_clock_input(&mut oscillator);
    let mut fader = FaderNode::new();
    converter1.connect_to_dmx_input(&mut logger);
    converter1.connect_to_dmx_input(&mut artnet);
    converter2.connect_to_dmx_input(&mut artnet);
    osc.connect_to_numeric_input(&mut converter1);
    oscillator.connect_to_numeric_input(&mut converter2);
    fader.set_float_property("value", 50f64);
    let mut nodes: Vec<Node> = vec![
        clock.into(),
        osc.into(),
        oscillator.into(),
        fader.into(),
        converter1.into(),
        converter2.into(),
        logger.into(),
        artnet.into(),
        file.into(),
        effect.into(),
        screen.into(),
    ];
    loop {
        for node in nodes.iter_mut() {
            node.process();
        }
        std::thread::sleep(std::time::Duration::from_millis(16));
    }
}
