use serde::{Deserialize, Serialize};

use crate::output::wgpu_pipeline::OutputWgpuPipeline;
use mizer_node::*;
use mizer_wgpu::window::{EventLoopHandle, WindowRef};
use mizer_wgpu::{WgpuContext, WgpuPipeline};

#[derive(Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoOutputNode;

pub struct VideoOutputState {
    window: WindowRef,
    pipeline: OutputWgpuPipeline,
}

impl VideoOutputState {
    fn new(event_loop: &EventLoopHandle, context: &WgpuContext) -> anyhow::Result<Self> {
        let window = event_loop.new_window(context, Some("Mizer Video Output"))?;
        let pipeline = OutputWgpuPipeline::new(context);

        Ok(VideoOutputState { window, pipeline })
    }
}

impl ConfigurableNode for VideoOutputNode {}

impl PipelineNode for VideoOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Video Output".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!("Input", PortType::Texture)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoOutput
    }
}

impl ProcessingNode for VideoOutputNode {
    type State = Option<VideoOutputState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let event_loop = context.inject::<EventLoopHandle>().unwrap();
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        if state.is_none() {
            *state = Some(VideoOutputState::new(event_loop, wgpu_context)?);
        }

        if let Some(state) = state {
            state.window.handle_events(wgpu_context);
            let surface = state.window.surface()?;
            if let Some(texture) = context.read_texture("Input") {
                let stage = state
                    .pipeline
                    .render(wgpu_context, &surface.view(), &texture);

                wgpu_pipeline.add_stage(stage);
                wgpu_pipeline.add_surface(surface);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
