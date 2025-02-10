use std::sync::Arc;

use mizer_node::{Inject, NodeContext, PortId};
use mizer_wgpu::{BufferHandle, TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

pub struct TextureToPixelsConverter {
    buffer_handle: Arc<BufferHandle>,
    port_id: PortId,
}

impl TextureToPixelsConverter {
    pub fn new(context: &impl NodeContext, input_port: impl Into<PortId>) -> anyhow::Result<Self> {
        let wgpu_context = context.try_inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.try_inject::<WgpuPipeline>().unwrap();

        let buffer_handle = wgpu_pipeline.create_export_buffer(wgpu_context, 1920, 1080);

        Ok(Self {
            buffer_handle,
            port_id: input_port.into(),
        })
    }

    pub fn process(&self, context: &impl NodeContext) -> anyhow::Result<()> {
        let wgpu_context = context.try_inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.try_inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.try_inject::<TextureRegistry>().unwrap();

        if let Some(texture_handle) = context.read_port::<_, TextureHandle>(self.port_id.clone()) {
            tracing::trace!("got texture handle");
            if let Some(texture) = texture_registry.get_texture_ref(&texture_handle) {
                tracing::trace!("got texture");
                wgpu_pipeline.export_to_buffer(
                    wgpu_context,
                    &texture,
                    Arc::clone(&self.buffer_handle),
                );
            }
        }

        Ok(())
    }

    pub fn post_process(&self, context: &impl NodeContext) -> anyhow::Result<Option<Vec<u8>>> {
        let wgpu_pipeline = context.try_inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.try_inject::<TextureRegistry>().unwrap();

        if let Some(texture_handle) = context.read_port::<_, TextureHandle>(self.port_id.clone()) {
            if texture_registry.get_texture_ref(&texture_handle).is_some() {
                let buffer_access = wgpu_pipeline.get_buffer(&self.buffer_handle);
                return if let Some(data) = buffer_access.read() {
                    Ok(Some(data.to_vec()))
                } else {
                    Ok(None)
                };
            }
        }

        Ok(None)
    }
}
