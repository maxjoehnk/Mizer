use crate::{Project, ProjectManager};
use mizer_node_ports::NodePortState;

impl ProjectManager for NodePortState {
    fn new_project(&self) {
        self.clear();
    }

    fn load(&self, project: &Project) -> anyhow::Result<()> {
        self.clear();
        self.load_ports(project.ports.clone());

        Ok(())
    }

    fn save(&self, project: &mut Project) {
        project.ports = self.list_ports();
    }

    fn clear(&self) {
        self.clear_ports();
    }
}
