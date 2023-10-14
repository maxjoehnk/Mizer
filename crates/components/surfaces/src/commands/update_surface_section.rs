use std::hash::{Hash, Hasher};

use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};

use crate::{
    SurfaceRegistry, SurfaceSection, SurfaceSectionId, SurfaceTransform, SurfaceTransformPoint,
};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct UpdateSurfaceSectionCommand {
    pub id: SurfaceSectionId,
    pub input: Option<SurfaceTransform>,
    pub output: Option<SurfaceTransform>,
}

impl Hash for UpdateSurfaceSectionCommand {
    fn hash<H: Hasher>(&self, state: &mut H) {
        self.id.hash(state);
        hash_transform_param(state, self.input.as_ref());
        hash_transform_param(state, self.output.as_ref());
    }
}

impl<'a> Command<'a> for UpdateSurfaceSectionCommand {
    type Dependencies = Ref<SurfaceRegistry>;
    type State = SurfaceSection;
    type Result = ();

    fn label(&self) -> String {
        format!("Update Surface Section {:?}", &self.id)
    }

    fn apply(
        &self,
        surface_registry: &SurfaceRegistry,
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut surface = surface_registry
            .get_mut(&self.id.surface_id)
            .ok_or_else(|| anyhow::anyhow!("Surface not found"))?;
        let section = surface
            .sections
            .iter_mut()
            .find(|section| section.id == self.id)
            .ok_or_else(|| anyhow::anyhow!("Surface section not found"))?;
        let old_section = section.clone();
        if let Some(input) = self.input.as_ref() {
            section.input = *input;
        }
        if let Some(output) = self.output.as_ref() {
            section.output = *output;
        }

        Ok(((), old_section))
    }

    fn revert(
        &self,
        surface_registry: &SurfaceRegistry,
        old_section: Self::State,
    ) -> anyhow::Result<()> {
        let mut surface = surface_registry
            .get_mut(&self.id.surface_id)
            .ok_or_else(|| anyhow::anyhow!("Surface not found"))?;
        let section = surface
            .sections
            .iter_mut()
            .find(|section| section.id == self.id)
            .ok_or_else(|| anyhow::anyhow!("Surface section not found"))?;
        *section = old_section;

        Ok(())
    }
}

fn hash_transform_param<H: Hasher>(state: &mut H, param: Option<&SurfaceTransform>) {
    if let Some(transform) = param {
        state.write_u8(1);
        hash_transform(state, transform);
    } else {
        state.write_u8(0);
    }
}

fn hash_transform<H: Hasher>(state: &mut H, point: &SurfaceTransform) {
    hash_transform_point(state, &point.top_left);
    hash_transform_point(state, &point.top_right);
    hash_transform_point(state, &point.bottom_left);
    hash_transform_point(state, &point.bottom_right);
}

fn hash_transform_point<H: Hasher>(state: &mut H, point: &SurfaceTransformPoint) {
    state.write_u64(point.x.to_bits());
    state.write_u64(point.y.to_bits());
}
