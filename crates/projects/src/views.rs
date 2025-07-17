use mizer_ui_api::view::ViewRegistry;
use crate::{Project, ProjectManager};

impl ProjectManager for ViewRegistry {
    fn load(&self, project: &Project) -> anyhow::Result<()> {
        self.add_views(project.views.clone());
        
        Ok(())
    }

    fn save(&self, project: &mut Project) {
        project.views = self.views();
    }

    fn clear(&self) {
        self.clear_views();
    }
}