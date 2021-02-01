use mizer_node_api::{ProcessingNode, NodeDetails, NodeInput, NodeChannel, SourceNode, DestinationNode, LaserChannel, ConnectionResult, ConnectionError};
use mizer_protocol_laser::{Laser, LaserFrame};
use mizer_devices::{DeviceManager};

pub struct LaserNode {
    device_manager: DeviceManager,
    inputs: Vec<LaserChannel>,
    device_id: String,
    frames: Vec<LaserFrame>,
    current_frame: usize,
}

impl LaserNode {
    pub fn new(device_manager: DeviceManager, device_id: String) -> Self {
        LaserNode {
            device_manager,
            inputs: Default::default(),
            device_id,
            frames: Default::default(),
            current_frame: Default::default(),
        }
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
        if let Some(mut laser) = self.device_manager.get_laser_mut(&self.device_id) {
            if self.current_frame >= self.frames.len() {
                self.current_frame = 0;
            }
            let frame = &self.frames[self.current_frame];
            if let Err(err) = laser.write_frame(frame.clone()) {
                log::error!("Error writing frame to laser dac {:?}", &err);
                return;
            }
            self.current_frame += 1;
        }
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
