use mizer_protocol_midi::*;
use mizer_clock::Timecode;
use mizer_node::*;
use serde::{Deserialize, Serialize};
use mizer_message_bus::Subscriber;

const TIMECODE_OUTPUT: &str = "Clock";

const DEVICE_SETTING: &str = "Device";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct MtcDecoderNode {
    pub device: String,
}

impl ConfigurableNode for MtcDecoderNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let connection_manager = injector.get::<MidiConnectionManager>().unwrap();
        let devices = connection_manager.list_available_devices();
        let devices = devices
            .into_iter()
            .filter(|device| device.has_input())
            .map(|device| SelectVariant::from(device.name))
            .collect();

        vec![setting!(select DEVICE_SETTING, &self.device, devices)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, DEVICE_SETTING, self.device);

        update_fallback!(setting)
    }
}

impl PipelineNode for MtcDecoderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "MTC Decoder".into(),
            preview_type: PreviewType::Timecode,
            category: NodeCategory::Connections,
        }
    }

    fn display_name(&self, _injector: &Injector) -> String {
        format!("MTC Decoder ({})", self.device)
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            output_port!(TIMECODE_OUTPUT, PortType::Clock),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::MtcDecoder
    }
}

impl ProcessingNode for MtcDecoderNode {
    type State = (QuarterFrameBuilder, Option<(String, Subscriber<MidiEvent>)>);

    fn process(&self, context: &impl NodeContext, (frame_builder, state): &mut Self::State) -> anyhow::Result<()> {
        let Some(connection_manager) = context.try_inject::<MidiConnectionManager>() else {
            return Ok(());
        };
        if matches!(state, Some((device_name, _)) if device_name != &self.device) || state.is_none() {
            if let Some(device) = connection_manager.request_device(&self.device)? {
                let events = device.events();

                *state = Some((self.device.clone(), events));
            } else {
                return Ok(());
            }
        }
        if let Some((device_name, subscriber)) = state && device_name == &self.device {
            let event = subscriber.iter()
                .filter_map(|event| if let MidiMessage::Timecode(timecode, frame_rate) = event.msg {
                    Some((timecode, frame_rate))
                }else if let MidiMessage::TimecodeQuarterFrame(frame, value) = event.msg {
                    frame_builder.push_frame(frame, value)
                }else {
                    None
                })
                .last();
            let Some((timecode, frame_rate)) = event else {
                return Ok(());
            };

            let timecode = Timecode {
                hours: timecode.hours as u64,
                minutes: timecode.minutes as u64,
                seconds: timecode.seconds as u64,
                frames: timecode.frames as u64,
                negative: false,
            };

            context.write_timecode_preview(timecode);
            let timestamp = timecode.to_duration(to_fps(frame_rate));
            context.write_port(TIMECODE_OUTPUT, timestamp);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

fn to_fps(frame_rate: FrameRate) -> f64 {
    match frame_rate {
        FrameRate::FPS24 => 24.0,
        FrameRate::FPS25 => 25.0,
        FrameRate::DF30 => 29.97,
        FrameRate::NDF30 => 30.0,
    }
}

#[derive(Default)]
pub struct QuarterFrameBuilder(MtcTimecode);

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

