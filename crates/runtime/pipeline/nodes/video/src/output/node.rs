use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::window::{EventLoopHandle, WindowRef};
use mizer_wgpu::{WgpuContext, WgpuPipeline};

use crate::output::wgpu_pipeline::OutputWgpuPipeline;

const INPUT_PORT: &str = "Input";

const FULLSCREEN_SETTING: &str = "Fullscreen";
const SCREEN_SETTING: &str = "Screen";
const WINDOW_NAME_SETTING: &str = "Window Name";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoOutputNode {
    #[serde(default)]
    pub fullscreen: bool,
    /// Empty string == no screen selected
    #[serde(default)]
    pub screen: String,
    #[serde(default)]
    pub window_name: String,
}

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

impl ConfigurableNode for VideoOutputNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let event_loop = injector.get::<EventLoopHandle>().unwrap();
        let screens = event_loop.available_screens();
        let mut screens: Vec<_> = screens
            .into_iter()
            .map(|screen| SelectVariant::Item {
                label: format!("{} ({}x{})", screen.name, screen.size.0, screen.size.1).into(),
                value: screen.id.into(),
            })
            .collect();
        screens.insert(0, SelectVariant::from(String::default())); // No selection

        vec![
            setting!(FULLSCREEN_SETTING, self.fullscreen),
            setting!(select SCREEN_SETTING, &self.screen, screens).optional(),
            setting!(WINDOW_NAME_SETTING, &self.window_name).optional(),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(bool setting, FULLSCREEN_SETTING, self.fullscreen);
        update!(select setting, SCREEN_SETTING, self.screen);
        update!(text setting, WINDOW_NAME_SETTING, self.window_name);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Video Output".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(INPUT_PORT, PortType::Texture)]
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

        let state = state.as_mut().unwrap();
        state.window.handle_events(wgpu_context);
        if !self.window_name.is_empty() {
            state.window.set_title(&self.window_name);
        }
        let target_screen = if !self.screen.is_empty() {
            event_loop.get_screen(&self.screen)
        } else {
            None
        };
        state.window.set_fullscreen(self.fullscreen, target_screen);
        let surface = state.window.surface()?;
        if let Some(texture) = context.read_texture(INPUT_PORT) {
            let stage = state
                .pipeline
                .render_input(wgpu_context, &surface.view(), &texture);

            wgpu_pipeline.add_stage(stage);
        } else {
            let stage = state.pipeline.clear(wgpu_context, &surface.view());

            wgpu_pipeline.add_stage(stage);
        }
        wgpu_pipeline.add_surface(surface);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
