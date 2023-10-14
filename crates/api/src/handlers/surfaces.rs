use futures::{Stream, StreamExt};

use mizer_command_executor::UpdateSurfaceSectionCommand;
use mizer_surfaces::{SurfaceRegistryApi, SurfaceSectionId};

use crate::proto::surfaces::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct SurfacesHandler<R: RuntimeApi> {
    api: SurfaceRegistryApi,
    runtime: R,
}

impl<R: RuntimeApi> SurfacesHandler<R> {
    pub fn new(runtime: R, api: SurfaceRegistryApi) -> Self {
        Self { runtime, api }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_input_mapping(
        &self,
        surface_id: String,
        section_id: usize,
        mapping: SurfaceTransform,
    ) -> anyhow::Result<()> {
        let id = SurfaceSectionId {
            surface_id: surface_id.parse()?,
            index: section_id,
        };
        self.runtime.run_command(UpdateSurfaceSectionCommand {
            id,
            input: Some(mapping.into()),
            output: None,
        })?;
        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_output_mapping(
        &self,
        surface_id: String,
        section_id: usize,
        mapping: SurfaceTransform,
    ) -> anyhow::Result<()> {
        let id = SurfaceSectionId {
            surface_id: surface_id.parse()?,
            index: section_id,
        };
        self.runtime.run_command(UpdateSurfaceSectionCommand {
            id,
            input: None,
            output: Some(mapping.into()),
        })?;
        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn observe_surfaces(&self) -> impl Stream<Item = Surfaces> {
        log::debug!("Observing surfaces");
        self.api
            .bus
            .subscribe()
            .into_stream()
            .map(|surfaces| surfaces.into_iter().map(|surface| surface.into()).collect())
            .map(|surfaces| {
                log::debug!("Emitting new surfaces");
                Surfaces { surfaces }
            })
    }
}
