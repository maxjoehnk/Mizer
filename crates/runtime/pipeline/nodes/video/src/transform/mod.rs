use anyhow::anyhow;
use cgmath::{Deg, Matrix4, Vector3};
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_wgpu::{TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use crate::transform::wgpu_pipeline::TransformWgpuPipeline;

mod wgpu_pipeline;

const INPUT_PORT: &str = "Input";
const OUTPUT_PORT: &str = "Output";
const ROTATION_X_PORT: &str = "Rotate X";
const ROTATION_Y_PORT: &str = "Rotate Y";
const ROTATION_Z_PORT: &str = "Rotate Z";
const TRANSLATION_X_PORT: &str = "Translate X";
const TRANSLATION_Y_PORT: &str = "Translate Y";
const TRANSLATION_Z_PORT: &str = "Translate Z";
const SCALE_X_PORT: &str = "Scale X";
const SCALE_Y_PORT: &str = "Scale Y";

const ROTATION_X_SETTING: &str = "rotate-x";
const ROTATION_Y_SETTING: &str = "rotate-y";
const ROTATION_Z_SETTING: &str = "rotate-z";
const TRANSLATION_X_SETTING: &str = "translate-x";
const TRANSLATION_Y_SETTING: &str = "translate-y";
const TRANSLATION_Z_SETTING: &str = "translate-z";
const SCALE_X_SETTING: &str = "scale-x";
const SCALE_Y_SETTING: &str = "scale-y";

const X_LABEL: &str = "X";
const Y_LABEL: &str = "Y";
const Z_LABEL: &str = "Z";

#[rustfmt::skip]
pub const OPENGL_TO_WGPU_MATRIX: Matrix4<f32> = Matrix4::new(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 0.5, 0.0,
    0.0, 0.0, 0.5, 1.0,
);

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct VideoTransformNode {
    pub rotation_x: f64,
    pub rotation_y: f64,
    pub rotation_z: f64,
    pub translation_x: f64,
    pub translation_y: f64,
    pub translation_z: f64,
    pub scale_x: f64,
    pub scale_y: f64,
}

impl Default for VideoTransformNode {
    fn default() -> Self {
        Self {
            rotation_x: 0.0,
            rotation_y: 0.0,
            rotation_z: 0.0,
            translation_x: 0.0,
            translation_y: 0.0,
            translation_z: 0.0,
            scale_x: 1.0,
            scale_y: 1.0,
        }
    }
}

impl ConfigurableNode for VideoTransformNode {
    fn settings(&self, _injector: &ReadOnlyInjectionScope) -> Vec<NodeSetting> {
        vec![
            setting!(ROTATION_X_SETTING, self.rotation_x)
                .category("Rotation")
                .label(X_LABEL)
                .min(-360.0)
                .max(360.0),
            setting!(ROTATION_Y_SETTING, self.rotation_y)
                .category("Rotation")
                .label(Y_LABEL)
                .min(-360.0)
                .max(360.0),
            setting!(ROTATION_Z_SETTING, self.rotation_z)
                .category("Rotation")
                .label(Z_LABEL)
                .min(-360.0)
                .max(360.0),
            setting!(TRANSLATION_X_SETTING, self.translation_x)
                .category("Translation")
                .label(X_LABEL),
            setting!(TRANSLATION_Y_SETTING, self.translation_y)
                .category("Translation")
                .label(Y_LABEL),
            setting!(TRANSLATION_Z_SETTING, self.translation_z)
                .category("Translation")
                .label(Z_LABEL),
            setting!(SCALE_X_SETTING, self.scale_x)
                .min(0.)
                .max_hint(1.)
                .category("Scale")
                .label(X_LABEL),
            setting!(SCALE_Y_SETTING, self.scale_y)
                .min(0.)
                .max_hint(1.)
                .category("Scale")
                .label(Y_LABEL),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float setting, ROTATION_X_SETTING, self.rotation_x);
        update!(float setting, ROTATION_Y_SETTING, self.rotation_y);
        update!(float setting, ROTATION_Z_SETTING, self.rotation_z);
        update!(float setting, TRANSLATION_X_SETTING, self.translation_x);
        update!(float setting, TRANSLATION_Y_SETTING, self.translation_y);
        update!(float setting, TRANSLATION_Z_SETTING, self.translation_z);
        update!(float setting, SCALE_X_SETTING, self.scale_x);
        update!(float setting, SCALE_Y_SETTING, self.scale_y);

        update_fallback!(setting)
    }
}

impl PipelineNode for VideoTransformNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Video Transform".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, _injector: &ReadOnlyInjectionScope) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Texture),
            output_port!(OUTPUT_PORT, PortType::Texture),
            input_port!(ROTATION_X_PORT, PortType::Single),
            input_port!(ROTATION_Y_PORT, PortType::Single),
            input_port!(ROTATION_Z_PORT, PortType::Single),
            input_port!(TRANSLATION_X_PORT, PortType::Single),
            input_port!(TRANSLATION_Y_PORT, PortType::Single),
            input_port!(TRANSLATION_Z_PORT, PortType::Single),
            input_port!(SCALE_X_PORT, PortType::Single),
            input_port!(SCALE_Y_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoTransform
    }
}

impl ProcessingNode for VideoTransformNode {
    type State = Option<VideoTransformState>;

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
            *state = Some(VideoTransformState::new(wgpu_context, texture_registry)?);
        }

        let rotation_x = context
            .read_port(ROTATION_X_PORT)
            .unwrap_or(self.rotation_x);
        let rotation_y = context
            .read_port(ROTATION_Y_PORT)
            .unwrap_or(self.rotation_y);
        let rotation_z = context
            .read_port(ROTATION_Z_PORT)
            .unwrap_or(self.rotation_z);
        let translation_x = context
            .read_port(TRANSLATION_X_PORT)
            .unwrap_or(self.translation_x);
        let translation_y = context
            .read_port(TRANSLATION_Y_PORT)
            .unwrap_or(self.translation_y);
        let translation_z = context
            .read_port(TRANSLATION_Z_PORT)
            .unwrap_or(self.translation_z);
        let scale_x = context.read_port(SCALE_X_PORT).unwrap_or(self.scale_x);
        let scale_y = context.read_port(SCALE_Y_PORT).unwrap_or(self.scale_y);

        let rotation_matrix = Matrix4::from_angle_x(Deg(rotation_x))
            * Matrix4::from_angle_y(Deg(rotation_y))
            * Matrix4::from_angle_z(Deg(rotation_z));
        let translation_matrix =
            Matrix4::from_translation(Vector3::new(translation_x, translation_y, translation_z));
        let scale_matrix = Matrix4::from_nonuniform_scale(scale_x, scale_y, 1.0);

        let matrix = translation_matrix * rotation_matrix * scale_matrix;
        let matrix = matrix.cast().unwrap();
        let matrix = OPENGL_TO_WGPU_MATRIX * matrix;

        let state = state.as_mut().unwrap();
        context.write_port(OUTPUT_PORT, state.target_texture);
        state.pipeline.write_params(wgpu_context, matrix.into());

        let output = texture_registry
            .get(&state.target_texture)
            .ok_or_else(|| anyhow!("Missing target texture"))?;
        if let Some(input) = context.read_texture(INPUT_PORT) {
            let stage = state.pipeline.render(wgpu_context, &output, &input)?;

            wgpu_pipeline.add_stage(stage);
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

pub struct VideoTransformState {
    pipeline: TransformWgpuPipeline,
    target_texture: TextureHandle,
}

impl VideoTransformState {
    fn new(context: &WgpuContext, texture_registry: &TextureRegistry) -> anyhow::Result<Self> {
        Ok(Self {
            pipeline: TransformWgpuPipeline::new(context)?,
            target_texture: texture_registry.register(
                context,
                1920,
                1080,
                Some("Transform target"),
            ),
        })
    }
}
