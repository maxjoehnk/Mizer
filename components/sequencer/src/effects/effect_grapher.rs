use std::fs;
use std::ops::Add;
use std::path::Path;

use mizer_util::clock::{Clock, TestClock};
use super::*;
use super::instance::EffectInstance;
use std::collections::HashMap;
use itertools::Itertools;
use mizer_fixtures::definition::{FixtureFaderControl, FixtureDefinition, FixtureMode, FixtureControls, FixtureChannelDefinition, ChannelResolution, AxisGroup};
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::fixture::IFixture;
use mizer_fixtures::FixtureId;

const FRAMES_PER_STEP: usize = 60;

pub fn graph_effect(effect: Effect, fixtures: Vec<u32>) -> anyhow::Result<()> {
    let (fixture_frames, history_ticks) = run_effect(&effect, fixtures)?;
    generate_graph(&effect, fixture_frames, history_ticks)?;

    Ok(())
}

pub fn graph_position_effect(effect: Effect) -> anyhow::Result<()> {
    let (fixture_frames, _) = run_effect(&effect, vec![1])?;
    generate_position_graph(&effect, fixture_frames)?;

    Ok(())
}

fn run_effect(effect: &Effect, fixtures: Vec<u32>) -> anyhow::Result<(HashMap<(u32, FixtureFaderControl), Vec<f64>>, Vec<f64>)> {
    let mut clock = TestClock::default();
    let mut history_ticks = Vec::new();
    let mut fixture_frames = HashMap::<(u32, FixtureFaderControl), Vec<f64>>::new();
    let fixture_manager = FixtureManager::new(Default::default());
    for fixture_id in fixtures.iter() {
        add_test_fixture(&fixture_manager, *fixture_id);
    }
    let mut effect_instance = EffectInstance::new(effect, fixtures.into_iter().map(FixtureId::Fixture).collect());
    let frames = effect.channels.iter().map(|c| c.steps.len()).max().unwrap_or_default() * FRAMES_PER_STEP;

    for _ in 0..frames {
        let frame = clock.tick();
        history_ticks.push(frame.frame);

        effect_instance.process(&effect, &fixture_manager, frame);

        collect_fixture_frames(&fixture_manager, &mut fixture_frames);
    }

    Ok((fixture_frames, history_ticks))
}

fn generate_graph(effect: &Effect, fixture_frames: HashMap<(u32, FixtureFaderControl), Vec<f64>>, history_ticks: Vec<f64>) -> anyhow::Result<()> {
    let dir = Path::new(".snapshots");
    fs::create_dir_all(dir)?;
    let name = format!("{}-time", effect.name);
    generate_script_file(&dir, &name, fixture_frames.keys().cloned().sorted_by_key(|(id, _)| *id).collect())?;
    for ((id, control), values) in fixture_frames.iter().sorted_by_key(|((id, _), _)| id) {
        generate_data_file(&dir, &format!("{}-{:?}", id, control), &values, &history_ticks)?;
    }
    generate_plot(&dir, &name)?;
    cleanup_script(&dir, &name)?;
    for ((id, control), values) in fixture_frames.iter() {
        cleanup_data(&dir, &format!("{}-{:?}", id, control))?;
    }

    Ok(())
}

fn generate_position_graph(effect: &Effect, fixture_frames: HashMap<(u32, FixtureFaderControl), Vec<f64>>) -> anyhow::Result<()> {
    let dir = Path::new(".snapshots");
    fs::create_dir_all(dir)?;
    let name = format!("{}-position", effect.name);
    generate_position_script_file(&dir, &name)?;
    let pan = fixture_frames.get(&(1, FixtureFaderControl::Pan)).unwrap();
    let tilt = fixture_frames.get(&(1, FixtureFaderControl::Tilt)).unwrap();
    generate_data_file(&dir, &name, &tilt, &pan)?;
    generate_plot(&dir, &name)?;
    cleanup_script(&dir, &name)?;
    cleanup_data(&dir, &name)?;

    Ok(())
}

fn add_test_fixture(fixture_manager: &FixtureManager, id: u32) {
    fixture_manager.add_fixture(id, "Fixture".into(), FixtureDefinition {
        id: "test-fixture".into(),
        name: "Test Fixture".into(),
        manufacturer: "Mizer".into(),
        modes: vec![FixtureMode {
            name: "Default".into(),
            channels: vec![
                FixtureChannelDefinition {
                    name: "intensity".into(),
                    resolution: ChannelResolution::Coarse(0)
                },
                FixtureChannelDefinition {
                    name: "pan".into(),
                    resolution: ChannelResolution::Coarse(0)
                },
                FixtureChannelDefinition {
                    name: "tilt".into(),
                    resolution: ChannelResolution::Coarse(0)
                },
            ],
            controls: FixtureControls {
                intensity: Some("intensity".to_string()),
                pan: Some(AxisGroup {
                    channel: "pan".into(),
                    angle: None,
                }),
                tilt: Some(AxisGroup {
                    channel: "tilt".into(),
                    angle: None,
                }),
                ..Default::default()
            }.into(),
            sub_fixtures: vec![]
        }],
        physical: Default::default(),
        tags: Vec::new(),
    }, Some("Default".into()), None, 1, None);
}

fn collect_fixture_frames(fixture_manager: &FixtureManager, frames: &mut HashMap<(u32, FixtureFaderControl), Vec<f64>>) {
    for fixture in fixture_manager.get_fixtures() {
        for control in fixture.current_mode.controls.controls().into_iter().flat_map(|(controls, _)| controls.faders()) {
            if let Some(value) = fixture.read_control(control.clone()) {
                frames.entry((fixture.id, control))
                    .or_default()
                    .push(value);
            }
        }
    }
}

fn generate_script_file(dir: &Path, name: &str, files: Vec<(u32, FixtureFaderControl)>) -> anyhow::Result<()> {
    let channels = files.iter().map(|(id, control)| format!("'{}-{:?}.dat' title '{} {:?}' with lines", id, control, id, control)).collect::<Vec<_>>().join(", ");
    let script = format!("set xlabel 'Frames'\nset ylabel 'Value'\nset yrange[-1:1]\nset term svg enhanced\nset output '{}.svg'\nplot {}\n", name, channels);
    let file_path = dir.join(format!("{}.gnu", name));
    fs::write(file_path, script)?;

    Ok(())
}

fn generate_position_script_file(dir: &Path, name: &str) -> anyhow::Result<()> {
    let script = format!("set xlabel 'Pan'\nset ylabel 'Tilt'\nset yrange[-1:1]\nset xrange[-1:1]\nunset key\nset term svg enhanced\nset output '{}.svg'\nplot '{}.dat' with lines\n", name, name);
    let file_path = dir.join(format!("{}.gnu", name));
    fs::write(file_path, script)?;

    Ok(())
}

fn generate_data_file(
    dir: &Path,
    name: &str,
    y_axes: &[f64],
    x_axes: &[f64],
) -> anyhow::Result<()> {
    assert_eq!(y_axes.len(), x_axes.len());

    let data = y_axes
        .into_iter()
        .zip(x_axes)
        .map(|(value, frame)| format!("{} {}", frame, value))
        .reduce(|lhs, rhs| lhs.add("\n").add(&rhs))
        .unwrap_or_default();
    fs::write(dir.join(format!("{}.dat", name)), data)?;

    Ok(())
}

fn generate_plot(dir: &Path, name: &str) -> anyhow::Result<()> {
    let result = std::process::Command::new("gnuplot")
        .arg(format!("{}.gnu", name))
        .current_dir(dir)
        .spawn()?
        .wait()?;

    assert!(result.success(), "gnuplot failed to run");

    Ok(())
}

fn cleanup_script(dir: &Path, name: &str) -> anyhow::Result<()> {
    let script = dir.join(format!("{}.gnu", name));
    std::fs::remove_file(&script)?;

    Ok(())
}

fn cleanup_data(dir: &Path, name: &str) -> anyhow::Result<()> {
    let data = dir.join(format!("{}.dat", name));
    std::fs::remove_file(&data)?;

    Ok(())
}
