use std::time::Duration;

use mizer_node_api::*;

use crate::nodes::*;
use crate::pipeline::Pipeline;

mod nodes;
mod pipeline;

const FRAME_DELAY_60FPS: Duration = Duration::from_millis(16);

fn main() -> anyhow::Result<()> {
    env_logger::init();
    let mut artnet = ArtnetOutputNode::new("0.0.0.0", None);
    let mut converter1 = ConvertToDmxNode::new(None, Some(0));
    let mut converter2 = ConvertToDmxNode::new(None, Some(18));
    let mut oscillator = OscillatorNode::new(OscillatorType::Sine);
    let mut clock = ClockNode::new(128f64);
    let mut osc = OscInputNode::new(None, 7000, "/1/fader1");
    let mut script = ScriptingNode::new(include_str!("../examples/test_script.rhai"));
    let mut fader = FaderNode::new();
    let mut file = VideoFileNode::new("/home/max/Code/0_mizer/mizer-video-projector/assets/DOC000 Alley Booze - H.264 1080p.mov");
    let mut effect = VideoEffectNode::new(VideoEffectType::Twirl);
    let mut transform = VideoTransformNode::new();
    let mut screen = VideoOutputNode::new();
    file.connect_to_video_input("output", &mut effect, "input")?;
    effect.connect_to_video_input("output", &mut transform, "input")?;
    transform.connect_to_video_input("output", &mut screen, "input")?;
    clock.connect_to_clock_input("clock", &mut oscillator, "clock")?;
    clock.set_numeric_property("speed", 90f64);
    converter1.connect_to_dmx_input("dmx", &mut artnet, "dmx")?;
    converter2.connect_to_dmx_input("dmx", &mut artnet, "dmx")?;
    osc.connect_to_numeric_input("value", &mut script, "")?;
    script.connect_to_numeric_input("value", &mut converter1, "value")?;
    oscillator.connect_to_numeric_input("value", &mut converter2, "value")?;
    oscillator.connect_to_numeric_input("value", &mut transform, "rotate-x")?;
    oscillator.connect_to_numeric_input("value", &mut transform, "rotate-y")?;
    oscillator.set_numeric_property("ratio", 4f64);
    oscillator.set_numeric_property("max", 1f64);
    fader.set_numeric_property("value", 0.5f64);
    let mut pipeline = Pipeline::default();
    pipeline.add_node(clock);
    pipeline.add_node(osc);
    pipeline.add_node(oscillator);
    pipeline.add_node(fader);
    pipeline.add_node(converter1);
    pipeline.add_node(converter2);
    pipeline.add_node(artnet);
    pipeline.add_node(script);
    pipeline.add_node(file);
    pipeline.add_node(effect);
    pipeline.add_node(transform);
    pipeline.add_node(screen);
    log::info!("{:?}", pipeline);

    loop {
        let before = std::time::Instant::now();
        pipeline.process();
        let after = std::time::Instant::now();
        let frame_time = after.duration_since(before);
        if frame_time <= FRAME_DELAY_60FPS {
            std::thread::sleep(FRAME_DELAY_60FPS - frame_time);
        }
    }
}

