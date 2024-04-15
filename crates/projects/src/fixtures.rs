use crate::{FixtureConfig, Project, ProjectManager};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{Color, Position, Preset, Presets};
use serde::{Deserialize, Serialize};
use std::ops::Deref;

impl ProjectManager for FixtureManager {
    fn new_project(&self) {
        self.presets.load_defaults();
    }

    fn load(&self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("FixtureManager::load");
        for fixture in &project.fixtures {
            let def = self.get_definition(&fixture.fixture);
            if let Some(def) = def {
                self.add_fixture(
                    fixture.id,
                    fixture.name.clone(),
                    def,
                    fixture.mode.clone(),
                    fixture.channel,
                    fixture.universe,
                    fixture.configuration.clone(),
                );
            } else {
                tracing::warn!(
                    "No fixture definition for fixture id {}. Missing fixture definition: {}",
                    fixture.id,
                    fixture.fixture
                );
            }
        }
        for group in &project.groups {
            self.groups.insert(group.id, group.clone());
        }
        project.presets.load(&self.presets);
        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("FixtureManager::save");
        for fixture in self.get_fixtures() {
            project.fixtures.push(FixtureConfig {
                id: fixture.id,
                name: fixture.name.clone(),
                universe: fixture.universe.into(),
                channel: fixture.channel,
                fixture: fixture.definition.id.clone(),
                mode: fixture.current_mode.name.clone().into(),
                configuration: fixture.configuration.clone(),
            });
        }
        for group in self.get_groups() {
            project.groups.push(group.deref().clone());
        }
        project.presets = PresetsStore::store(&self.presets);
    }

    fn clear(&self) {
        self.fixtures.clear();
        self.groups.clear();
        self.presets.clear();
        self.states.clear();
    }
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct PresetsStore {
    #[serde(default)]
    pub intensity: Vec<Preset<f64>>,
    #[serde(default)]
    pub shutter: Vec<Preset<f64>>,
    #[serde(default)]
    pub color: Vec<Preset<Color>>,
    #[serde(default)]
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
        let intensity = presets
            .intensity
            .iter()
            .map(|entry| entry.value().clone())
            .collect();
        let shutter = presets
            .shutter
            .iter()
            .map(|entry| entry.value().clone())
            .collect();
        let color = presets
            .color
            .iter()
            .map(|entry| entry.value().clone())
            .collect();
        let position = presets
            .position
            .iter()
            .map(|entry| entry.value().clone())
            .collect();

        Self {
            intensity,
            shutter,
            color,
            position,
        }
    }
}
