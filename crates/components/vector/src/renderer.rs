use std::num::NonZeroUsize;
use std::time::{Duration, Instant};

use parking_lot::Mutex;
use vello::{AaSupport, RenderParams, RendererOptions};

use mizer_wgpu::{TextureView, WgpuContext};

use crate::VectorData;

pub struct VectorWgpuRenderer {
    renderer: Mutex<vello::Renderer>,
}

impl VectorWgpuRenderer {
    pub fn new(wgpu_context: &WgpuContext) -> anyhow::Result<Self> {
        let renderer = vello::Renderer::new(
            &wgpu_context.device,
            RendererOptions {
                antialiasing_support: AaSupport::all(),
                use_cpu: false,
                num_init_threads: Some(NonZeroUsize::new(1).unwrap()),
            },
        )
        .map_err(|err| anyhow::anyhow!("{err:?}"))?;

        Ok(Self {
            renderer: Mutex::new(renderer),
        })
    }

    pub fn render(
        &self,
        data: &VectorData,
        wgpu_context: &WgpuContext,
        texture: &TextureView,
    ) -> anyhow::Result<()> {
        let mut renderer = self
            .renderer
            .try_lock_until(Instant::now() + Duration::from_secs(1))
            .ok_or_else(|| anyhow::anyhow!("Failed to lock vello renderer"))?;

        renderer
            .render_to_texture(
                &wgpu_context.device,
                &wgpu_context.queue,
                &data.0,
                texture,
                &RenderParams {
                    height: 1080,
                    width: 1920,
                    antialiasing_method: vello::AaConfig::Msaa16,
                    base_color: vello::peniko::Color::TRANSPARENT,
                },
            )
            .map_err(|err| anyhow::anyhow!("{err:?}"))?;

        Ok(())
    }
}
