use mizer_surfaces::SurfaceRegistry;

use crate::{Project, ProjectManagerMut};

impl ProjectManagerMut for SurfaceRegistry {
    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        self.add_surfaces(project.surfaces.clone());
        Ok(())
    }

    fn save(&self, project: &mut Project) {
        project.surfaces = self.list_surfaces();
    }

    fn clear(&mut self) {
        self.clear_surfaces()
    }
}
