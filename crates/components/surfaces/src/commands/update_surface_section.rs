use serde::{Deserialize, Serialize};

use mizer_commander::{Command, Ref};

use crate::{SurfaceRegistry, SurfaceSection, SurfaceSectionId, SurfaceTransform};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct UpdateSurfaceSectionCommand {
    pub id: SurfaceSectionId,
    pub input: Option<SurfaceTransform>,
    pub output: Option<SurfaceTransform>,
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
