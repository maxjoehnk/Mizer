use crate::{FixtureConfig, Project, ProjectManager};
use mizer_fixtures::manager::FixtureManager;

impl ProjectManager for FixtureManager {
    fn load(&self, project: &Project) -> anyhow::Result<()> {
        for fixture in &project.fixtures {
            let def = self.get_definition(&fixture.fixture);
            if let Some(def) = def {
                self.add_fixture(
                    fixture.id,
                    fixture.name.clone(),
                    def,
                    fixture.mode.clone(),
                    fixture.output.clone(),
                    fixture.channel,
                    fixture.universe,
                );
            } else {
                log::warn!("No fixture definition for fixture id {}", fixture.fixture);
            }
        }
        Ok(())
    }

    fn save(&self, project: &mut Project) {
        for fixture in self.fixtures.iter() {
            project.fixtures.push(FixtureConfig {
                id: fixture.id,
                name: fixture.name.clone(),
                universe: fixture.universe.into(),
                channel: fixture.channel,
                fixture: fixture.definition.id.clone(),
                mode: fixture.current_mode.name.clone().into(),
                output: fixture.output.clone(),
            });
        }
    }

    fn clear(&self) {
        self.fixtures.clear();
    }
}
