use ltc::LTCDecoder;
use serde::{Deserialize, Serialize};
use mizer_audio_nodes::{AudioContext, Signal};
use mizer_clock::Timecode;
use mizer_node::*;

const AUDIO_INPUT: &str = "LTC";
const TIMECODE_OUTPUT: &str = "Clock";

const FPS_SETTING: &str = "FPS";

const SAMPLE_RATE: u32 = 44_100;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct LtcDecoderNode {
    pub fps: f64,
}

impl Default for LtcDecoderNode {
    fn default() -> Self {
        Self {
            fps: 30.0,
        }
    }
}

impl ConfigurableNode for LtcDecoderNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(FPS_SETTING, self.fps),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, FPS_SETTING, self.fps);

        update_fallback!(setting)
    }
}

impl PipelineNode for LtcDecoderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "LTC Decoder".into(),
            preview_type: PreviewType::Timecode,
            category: NodeCategory::Standard,
        }
    }

    fn display_name(&self, _injector: &Injector) -> String {
        format!("LTC Decoder ({} FPS)", self.fps)
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(AUDIO_INPUT, PortType::Multi),
            output_port!(TIMECODE_OUTPUT, PortType::Clock),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::LtcDecoder
    }
}

impl ProcessingNode for LtcDecoderNode {
    type State = LTCDecoder;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some(mut signal) = context.input_signal(AUDIO_INPUT) else {
            return Ok(());
        };

        let frames = context.transfer_size_per_channel();

        let frames = (0..frames).map(|_| {
            let [mono, _] = signal.next();
            
            mono as f32
        }).collect::<Vec<_>>();
        

        let mut timecode_frame = None;
        if state.write_samples(&frames) {
            for frame in state {
                timecode_frame = Some(frame);
            }
        }

        if let Some(frame) = timecode_frame {
            let timecode = Timecode {
                hours: frame.hour as u64,
                minutes: frame.minute as u64,
                seconds: frame.second as u64,
                frames: frame.frame as u64,
                negative: false
            };
            context.write_timecode_preview(timecode);
            let timestamp = timecode.to_duration(context.fps());
            context.write_port(TIMECODE_OUTPUT, timestamp);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        LTCDecoder::new(SAMPLE_RATE as f32 / self.fps as f32, Default::default())
    }
}
