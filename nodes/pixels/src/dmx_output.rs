use mizer_node_api::*;

pub struct PixelDmxNode {
    width: u64,
    height: u64,
    start_universe: u16,
    channels: Vec<PixelChannel>,
    outputs: Vec<BatchedDmxSender>,
}

impl PixelDmxNode {
    pub fn new(width: u64, height: u64, start_universe: Option<u16>) -> Self {
        PixelDmxNode {
            width,
            height,
            start_universe: start_universe.unwrap_or(1),
            channels: Vec::new(),
            outputs: Vec::new(),
        }
    }
}

impl ProcessingNode for PixelDmxNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("PixelDmxNode")
            .with_outputs(vec![NodeOutput::dmx("output")])
            .with_inputs(vec![NodeInput::new("input", NodeChannel::Pixels)])
    }

    fn process(&mut self) {
        let mut pixels = None;
        for channel in &self.channels {
            match channel.receiver.recv_last() {
                Ok(data @ Some(_)) => pixels = data,
                Ok(None) => (),
                Err(e) => log::error!("{:?}", e),
            }
        }
        if let Some(pixels) = pixels {
            let data = pixels.into_iter()
                .flat_map(|color| vec![color.r, color.g, color.b])
                .collect::<Vec<_>>();
            for output in &self.outputs {
                let universes = data.chunks(512);
                universes
                    .zip(output.iter())
                    .for_each(|(channels, sender)| {
                        sender.send(Vec::from(channels));
                    });
            }
        }
    }
}
impl InputNode for PixelDmxNode {
    fn connect_pixel_input(&mut self, input: &str, channel: PixelChannel) -> ConnectionResult {
        if input == "input" {
            channel.back_channel.send((self.width, self.height));
            self.channels.push(channel);
            Ok(())
        }else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

const DMX_CHANNELS: u16 = 512;

impl OutputNode for PixelDmxNode {
    fn connect_to_dmx_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
        if output != "output" {
            return Err(ConnectionError::InvalidOutput(output.to_string()));
        }
        let channels_per_pixel = 3; // RGB, add configuration later
        let channel_count = self.width * self.height * channels_per_pixel;
        let universe_count = (channel_count / DMX_CHANNELS as u64) as u16;
        log::debug!("universes for pixels: {}", universe_count);
        let (sender, channel) = DmxChannel::batched(self.start_universe, universe_count);
        self.outputs.push(sender);
        node.connect_dmx_input(input, &[channel])?;
        Ok(())
    }
}
