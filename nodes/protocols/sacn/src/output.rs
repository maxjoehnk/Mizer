use std::collections::HashMap;
use sacn::DmxSource;

use mizer_node_api::*;

pub struct StreamingAcnOutputNode {
    source: DmxSource,
    buffer: HashMap<u16, [u8; 512]>,
    channels: Vec<DmxChannel>,
}

impl StreamingAcnOutputNode {
    pub fn new() -> Self {
        log::trace!("New StreamingAcnOutputNode");

        let source = DmxSource::new("mizer").unwrap();

        StreamingAcnOutputNode {
            source,
            buffer: HashMap::new(),
            channels: Vec::new(),
        }
    }

    fn recv(&mut self) {
        for channel in &self.channels {
            match channel.recv() {
                Ok(Some(value)) => {
                    for (universe, values) in value {
                        if !self.buffer.contains_key(&universe) {
                            self.buffer.insert(universe, [0; 512]);
                        }
                        let buffer = self.buffer.get_mut(&universe).unwrap();
                        for (channel_index, value) in values.iter().enumerate() {
                            if let Some(value) = value {
                                buffer[channel_index] = *value;
                            }
                        }
                    }
                },
                Ok(None) => continue,
                Err(e) => println!("{:?}", e)
            }
        }
    }

    fn flush(&mut self) {
        for (universe, buffer) in self.buffer.iter() {
            self.source.send(*universe, buffer).unwrap();
        }
    }
}

impl SourceNode for StreamingAcnOutputNode {
    fn connect_dmx_input(&mut self, input: &str, channels: &[DmxChannel]) -> ConnectionResult {
        if input == "dmx" {
            for channel in channels {
                self.channels.push(channel.clone());
            }
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl DestinationNode for StreamingAcnOutputNode {}

impl ProcessingNode for StreamingAcnOutputNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("StreamingAcnOutputNode")
            .with_inputs(vec![NodeInput::dmx("dmx")])
    }

    fn process(&mut self) {
        self.recv();
        self.flush();
    }
}
