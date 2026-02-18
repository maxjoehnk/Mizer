use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};
use serde::{Deserialize, Serialize};

const INPUT_COLOR_PORT: &str = "Color";

const OUTPUT_TEXTURE_PORT: &str = "Output";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct StaticColorNode {}

impl ConfigurableNode for StaticColorNode {}

impl PipelineNode for StaticColorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Static Color".into(),
            preview_type: PreviewType::Color,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_COLOR_PORT, PortType::Color),
            output_port!(OUTPUT_TEXTURE_PORT, PortType::Texture),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::StaticColor
    }
}

impl ProcessingNode for StaticColorNode {
    type State = Option<StaticColorNodeState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let Some(wgpu_context) = context.try_inject::<WgpuContext>() else {
            return Ok(());
        };
        let Some(wgpu_pipeline) = context.try_inject::<WgpuPipeline>() else {
            return Ok(());
        };
        let Some(texture_registry) = context.try_inject::<TextureRegistry>() else {
            return Ok(());
        };
        if state.is_none() {
            *state = Some(StaticColorNodeState::new(wgpu_context, texture_registry)?);
        }
        let state = state.as_mut().unwrap();
        if let Some(color) = context.color_input(INPUT_COLOR_PORT).read() {
            if let Some(target_texture) = texture_registry.get(&state.target_texture) {
                let mut command_buffer = wgpu_context.create_command_buffer("");
                {
                    let _render_pass = command_buffer.create_clear_pass(
                        &target_texture,
                        color.red,
                        color.green,
                        color.blue,
                        color.alpha,
                    );
                }
                wgpu_pipeline.add_stage(command_buffer.finish());

                context.write_port(OUTPUT_TEXTURE_PORT, state.target_texture);
            }

            context.write_color_preview(color);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

pub struct StaticColorNodeState {
    target_texture: TextureHandle,
}

impl StaticColorNodeState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("Static Color target"),
            ),
        })
    }
}
