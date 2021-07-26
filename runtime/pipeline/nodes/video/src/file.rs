use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory, MessageType, SeekFlags, SeekType, State, ClockTime};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoFileNode {
    pub file: String,
}

pub struct VideoFileState {
    file_src: Element,
    decoder: Element,
    upload: Element,
    convert: Element,
}

impl PipelineNode for VideoFileNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "VideoFileNode".into(),
            preview_type: PreviewType::Texture,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "output".into(),
            PortMetadata {
                port_type: PortType::Gstreamer,
                direction: PortDirection::Output,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoFile
    }
}

impl ProcessingNode for VideoFileNode {
    type State = VideoFileState;

    fn process(&self, _: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let pipeline = PIPELINE.lock().unwrap();
        let bus = pipeline.bus().unwrap();
        if let Some(msg) = bus.pop() {
            log::trace!("pipeline {:?}", msg);
            if msg.type_() == MessageType::Eos {
                pipeline.seek(1.0, SeekFlags::FLUSH, SeekType::Set, Some(ClockTime::ZERO), SeekType::None, ClockTime::NONE)?;
                pipeline.set_state(State::Playing)?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        VideoFileState::new(&self.file)
    }
}

impl VideoFileState {
    fn new(file: &str) -> Self {
        let full_path = std::env::current_dir().unwrap_or_default();
        let path = full_path.join(file);
        let path = path.to_str().unwrap();
        let node = VideoFileState::build(path);
        node.link_decoder();

        node
    }

    fn build(file: &str) -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let file_src = ElementFactory::make("filesrc", None).unwrap();
        let decoder = ElementFactory::make("decodebin", None).unwrap();
        let upload = ElementFactory::make("glupload", None).unwrap();
        let convert = ElementFactory::make("glcolorconvert", None).unwrap();
        pipeline.add(&file_src).unwrap();
        pipeline.add(&decoder).unwrap();
        pipeline.add(&upload).unwrap();
        pipeline.add(&convert).unwrap();
        file_src
            .set_property("location", &glib::Value::from(file))
            .unwrap();
        file_src.link(&decoder).unwrap();
        upload.link(&convert).unwrap();

        Self {
            file_src,
            decoder,
            upload,
            convert,
        }
    }

    fn link_decoder(&self) {
        let sink = self.upload.static_pad("sink").unwrap();
        let video_caps: gstreamer::Caps = "video/x-raw".parse().unwrap();
        self.decoder.connect_pad_added(move |_, pad| {
            let caps = pad.current_caps().unwrap();
            log::trace!("connect_pad_added: {:?}", caps);
            if caps.can_intersect(&video_caps) {
                log::trace!("connecting pads");
                pad.link(&sink).unwrap();
            }
        });
    }
}

impl GstreamerNode for VideoFileState {
    fn link_to(&self, target: &dyn GstreamerNode) -> anyhow::Result<()> {
        self.convert.link(target.sink())?;
        Ok(())
    }

    fn sink(&self) -> &Element {
        unimplemented!()
    }
}
