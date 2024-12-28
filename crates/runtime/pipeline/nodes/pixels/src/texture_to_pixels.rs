use std::sync::Arc;

use image::{DynamicImage, GenericImageView, ImageBuffer, Rgba};

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

    pub fn post_process(
        &self,
        context: &impl NodeContext,
        width: u32,
        height: u32,
    ) -> anyhow::Result<Option<Vec<Rgba<u8>>>> {
        let wgpu_pipeline = context.try_inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.try_inject::<TextureRegistry>().unwrap();

        if let Some(texture_handle) = context.read_port::<_, TextureHandle>(self.port_id.clone()) {
            if texture_registry.get_texture_ref(&texture_handle).is_some() {
                let buffer_access = wgpu_pipeline.get_buffer(&self.buffer_handle);
                if let Some(data) = buffer_access.read() {
                    let data = data
                        .chunks_exact(4)
                        .flat_map(|data| match data {
                            [b, g, r, a] => [*r, *g, *b, *a],
                            _ => unreachable!("data was not split in proper 4 byte chunks"),
                        })
                        .collect::<Vec<_>>();
                    if let Some(image) =
                        ImageBuffer::<image::Rgba<u8>, _>::from_raw(1920, 1080, data)
                    {
                        let image = DynamicImage::ImageRgba8(image);
                        let image =
                            image.resize_exact(width, height, image::imageops::FilterType::Nearest);
                        let data = image
                            .pixels()
                            .map(|(_, _, pixel)| pixel)
                            .collect::<Vec<_>>();

                        return Ok(Some(data));
                    }
                };
            }
        }

        Ok(None)
    }
}
