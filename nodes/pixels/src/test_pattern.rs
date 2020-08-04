use mizer_node_api::*;

pub struct PixelPatternGeneratorNode {
    pattern: Pattern,
    sender: Vec<(PixelSender, Pixels, PatternState)>,
}

pub enum Pattern {
    RGBIterate,
    RGBSnake
}

enum PatternState {
    Iterate {
        index: usize,
        color: Color
    }
}

impl PixelPatternGeneratorNode {
    pub fn new(pattern: Pattern) -> Self {
        PixelPatternGeneratorNode {
            pattern,
            sender: Vec::new(),
        }
    }
}

impl ProcessingNode for PixelPatternGeneratorNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("PixelPatternGeneratorNode")
            .with_outputs(vec![NodeOutput::new("output", NodeChannel::Pixels)])
    }

    fn process(&mut self) {
        for (sender, pixels, state) in self.sender.iter_mut() {
            sender.recv();
            let (width, height) = sender.dimensions();
            let pixel_count = width * height;
            if pixel_count != pixels.len() as u64 {
                pixels.resize(pixel_count as usize, Color::BLACK);
            }
            match (&self.pattern, state) {
                (Pattern::RGBIterate, PatternState::Iterate { index, color }) => {
                    if (*index) as u64 == pixel_count {
                        *index = 0;
                        next_color(color);
                    }

                    pixels[*index] = *color;
                    *index += 1;
                },
                _ => {}
            }
            sender.send(pixels.clone());
        }
    }
}

impl InputNode for PixelPatternGeneratorNode {

}

impl OutputNode for PixelPatternGeneratorNode {
    fn connect_to_pixel_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
        if output == "output" {
            let (sender, channel) = PixelChannel::new();
            node.connect_pixel_input(input, channel)?;
            self.sender.push((sender, Vec::new(), PatternState::Iterate { index: 0, color: Color::new(255, 0, 0) }));
            Ok(())
        }else {
            Err(ConnectionError::InvalidOutput)
        }
    }
}

fn next_color(color: &mut Color) {
    let (r, g, b) = match (color.r, color.g, color.b) {
        (0, 0, 0) => (255, 0, 0),
        (255, 0, 0) => (0, 255, 0),
        (0, 255, 0) => (0, 0, 255),
        (0, 0, 255) => (255, 255, 0),
        (255, 255, 0) => (0, 255, 255),
        (0, 255, 255) => (255, 255, 255),
        (255, 255, 255) => (0, 0, 0),
        _ => unreachable!()
    };
    color.r = r;
    color.g = g;
    color.b = b;
}
