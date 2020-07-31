use mizer_node_api::*;

pub struct LogNode {
    dmx_channels: Vec<DmxChannel>,
}

impl LogNode {
    pub fn new() -> Self {
        LogNode {
            dmx_channels: Vec::new(),
        }
    }
}

impl ProcessingNode for LogNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("LogNode")
            .with_inputs(vec![NodeInput::dmx("dmx")])
    }

    fn process(&mut self) {
        for channel in self.dmx_channels.iter() {
            match channel.recv() {
                Ok(Some(value)) => log::info!("Dmx {}:{} => {}", channel.universe, channel.channel, value),
                Ok(None) => {},
                Err(err) => log::error!("{:?}", err),
            }
        }
    }
}

impl InputNode for LogNode {
    fn connect_dmx_input(&mut self, input: &str, channels: &[DmxChannel]) -> ConnectionResult {
        if input == "dmx" {
            for channel in channels {
                self.dmx_channels.push(channel.clone());
            }
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl OutputNode for LogNode {}
