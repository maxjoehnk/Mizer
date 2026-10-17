use crate::{FixtureConfig, Project, ProjectManager};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::{Position, Preset, PresetValue, Presets};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
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
                mizer_console::error!(
                    mizer_console::ConsoleCategory::Projects,
                    "No fixture definition for fixture id {}. Missing fixture definition: {}",
                    fixture.id,
                    fixture.fixture
                );
            }
        }
        for group in &project.groups {
            self.groups.insert(group.id, group.clone());
        }
        project.presets.load(&self.presets)?;
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
    pub color: Vec<Preset<Vec<f64>>>,
    #[serde(default)]
    pub position: Vec<Preset<Position>>,
}

impl PresetsStore {
    fn load(&self, presets: &Presets) -> anyhow::Result<()> {
        for preset in self.intensity.iter() {
            presets.intensity.insert(preset.id, preset.clone());
        }
        for preset in self.shutter.iter() {
            presets.shutter.insert(preset.id, preset.clone());
        }
        for preset in self.color.iter() {
            let value = match &preset.value {
                PresetValue::Universal(values) if values.len() == 3 => PresetValue::Universal((values[0], values[1], values[2], None)),
                PresetValue::Universal(values) if values.len() == 4 => PresetValue::Universal((values[0], values[1], values[2], Some(values[3]))),
                PresetValue::Universal(values) => anyhow::bail!("Invalid universal color preset: {values:?}"),
                PresetValue::Selective(fixtures) => PresetValue::Selective(fixtures.iter().map(|(fixture, color)| {
                    if color.len() == 3 {
                        Ok((*fixture, (color[0], color[1], color[2], None)))
                    } else if color.len() == 4 {
                        Ok((*fixture, (color[0], color[1], color[2], Some(color[3]))))
                    } else {
                        anyhow::bail!("Invalid selective color preset: {color:?}");
                    }
                }).collect::<anyhow::Result<HashMap<_, _>>>()?),
            };
            let preset = Preset {
                id: preset.id,
                label: preset.label.clone(),
                value,
            };
            presets.color.insert(preset.id, preset);
        }
        for preset in self.position.iter() {
            presets.position.insert(preset.id, preset.clone());
        }

        Ok(())
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
            .map(|entry| {
                let value = match entry.value {
                    PresetValue::Universal((red, green, blue, None)) => PresetValue::Universal(vec![red, green, blue]),
                    PresetValue::Universal((red, green, blue, Some(amber))) => PresetValue::Universal(vec![red, green, blue, amber]),
                    PresetValue::Selective(fixtures) => PresetValue::Selective(
                        fixtures
                            .iter()
                            .map(|(fixture, color)| {
                                let value = match *color {
                                    (red, green, blue, None) => vec![red, green, blue],
                                    (red, green, blue, Some(amber)) => vec![red, green, blue, amber],
                                };

                                (*fixture, value)
                            })
                            .collect(),
                    ),
                };
                Preset {
                    id: entry.id,
                    label: entry.label.clone(),
                    value,
                }
            })
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
