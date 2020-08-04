use mizer_node_api::*;
use std::net::TcpStream;
use crate::protocol::SetColors;
use std::io::Write;

pub struct OPCOutputNode {
    socket: TcpStream,
    // host: String,
    // port: u16,
    width: u64,
    height: u64,
    channels: Vec<PixelChannel>,
}

impl OPCOutputNode {
    pub fn new<S: Into<String>>(host: S, port: Option<u16>, dimensions: (u64, u64)) -> Self {
        let host = host.into();
        let port = port.unwrap_or(7890);
        log::trace!("New OPCOutputNode({}:{})", &host, port);

        let socket = TcpStream::connect((host.as_str(), port)).unwrap();

        OPCOutputNode {
            socket,
            width: dimensions.0,
            height: dimensions.1,
            channels: Vec::new(),
        }
    }

    fn flush(&mut self) {
        let mut pixels = None;
        for channel in &self.channels {
            match channel.receiver.recv_last() {
                Ok(data @ Some(_)) => {
                    pixels = data;
                },
                Ok(None) => {},
                Err(e) => log::error!("{:?}", e)
            }
        }

        if let Some(pixels) = pixels {
            let msg = SetColors(1, pixels).to_buffer();

            self.socket
                .write(&msg)
                .unwrap();
        }
    }
}

impl InputNode for OPCOutputNode {
    fn connect_pixel_input(&mut self, input: &str, channel: PixelChannel) -> ConnectionResult {
        if input == "pixels" {
            channel.back_channel.send((self.width, self.height));
            self.channels.push(channel);
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl OutputNode for OPCOutputNode {}

impl ProcessingNode for OPCOutputNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("OPCOutputNode")
            .with_inputs(vec![NodeInput::new("pixels", NodeChannel::Pixels)])
    }

    fn process(&mut self) {
        self.flush()
    }
}
