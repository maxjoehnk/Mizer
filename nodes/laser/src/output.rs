use mizer_node_api::{ProcessingNode, NodeDetails, NodeInput, NodeChannel, SourceNode, DestinationNode, LaserChannel, ConnectionResult, ConnectionError};
use mizer_protocol_laser::laser::helios::HeliosLaser;
use mizer_protocol_laser::{Laser, LaserFrame};

pub struct LaserNode {
    inputs: Vec<LaserChannel>,
    device: HeliosLaser,
    frames: Vec<LaserFrame>,
    current_frame: usize,
}

impl LaserNode {
    pub fn new() -> anyhow::Result<Self> {
        let device = HeliosLaser::find_devices()?.remove(0);

        Ok(LaserNode {
            inputs: Default::default(),
            device,
            frames: Default::default(),
            current_frame: Default::default(),
        })
    }
}

impl ProcessingNode for LaserNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("LaserNode")
            .with_inputs(vec![NodeInput::new("input", NodeChannel::Laser)])
    }

    fn process(&mut self) {
        for input in self.inputs.iter() {
            if let Some(frames) = input.recv_last().unwrap() {
                self.frames = frames;
                self.current_frame = 0;
            }
        }
        if self.frames.is_empty() {
            return;
        }
        if self.current_frame >= self.frames.len() {
            self.current_frame = 0;
        }
        let frame = &self.frames[self.current_frame];
        self.device.write_frame(frame.clone()).unwrap();
        self.current_frame += 1;
    }
}

impl SourceNode for LaserNode {
    fn connect_laser_input(&mut self, input: &str, channel: LaserChannel) -> ConnectionResult {
        if input == "input" {
            self.inputs.push(channel);
            Ok(())
        }else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl DestinationNode for LaserNode {}
