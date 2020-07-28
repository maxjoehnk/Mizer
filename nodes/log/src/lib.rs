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
    fn connect_dmx_input(&mut self, channels: &[DmxChannel]) {
        for channel in channels {
            self.dmx_channels.push(channel.clone());
        }
    }
}

impl OutputNode for LogNode {}
