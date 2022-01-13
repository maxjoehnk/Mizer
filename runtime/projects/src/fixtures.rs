use serde::{Deserialize, Serialize};
use crate::{FixtureConfig, Project, ProjectManager};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{Preset, Color, Position, Presets};

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
        for group in &project.groups {
            self.groups.insert(group.id, group.clone());
        }
        project.presets.load(&self.presets);
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
        for group in self.groups.iter() {
            project.groups.push(group.value().clone());
        }
        project.presets = PresetsStore::store(&self.presets);
    }

    fn clear(&self) {
        self.fixtures.clear();
        self.groups.clear();
        self.presets.clear();
    }
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct PresetsStore {
    pub intensity: Vec<Preset<f64>>,
    pub shutter: Vec<Preset<f64>>,
    pub color: Vec<Preset<Color>>,
    pub position: Vec<Preset<Position>>,
}

impl PresetsStore {
    fn load(&self, presets: &Presets) {
        for preset in self.intensity.iter() {
            presets.intensity.insert(preset.id, preset.clone());
        }
        for preset in self.shutter.iter() {
            presets.shutter.insert(preset.id, preset.clone());
        }
        for preset in self.color.iter() {
            presets.color.insert(preset.id, preset.clone());
        }
        for preset in self.position.iter() {
            presets.position.insert(preset.id, preset.clone());
        }
    }

    fn store(presets: &Presets) -> Self {
        let intensity = presets.intensity.iter().map(|entry| entry.value().clone()).collect();
        let shutter = presets.shutter.iter().map(|entry| entry.value().clone()).collect();
        let color = presets.color.iter().map(|entry| entry.value().clone()).collect();
        let position = presets.position.iter().map(|entry| entry.value().clone()).collect();

        Self {
            intensity,
            shutter,
            color,
            position,
        }
    }
}
