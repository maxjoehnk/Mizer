use std::cmp::Ordering;
use std::fs;
use std::path::Path;

use super::instance::EffectInstance;
use super::*;
use itertools::Itertools;
use mizer_fixtures::definition::{
    AxisGroup, ChannelResolution, FixtureChannelDefinition, FixtureControls, FixtureDefinition,
    FixtureFaderControl, FixtureMode,
};
use mizer_fixtures::fixture::IFixture;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::FixtureId;
use mizer_util::clock::{Clock, TestClock};
use plotters::coord::Shift;
use plotters::prelude::*;
use std::collections::HashMap;

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

fn run_effect(
    effect: &Effect,
    fixtures: Vec<u32>,
) -> anyhow::Result<(HashMap<(u32, FixtureFaderControl), Vec<f64>>, Vec<f64>)> {
    let mut clock = TestClock::default();
    let mut history_ticks = Vec::new();
    let mut fixture_frames = HashMap::<(u32, FixtureFaderControl), Vec<f64>>::new();
    let fixture_manager = FixtureManager::new(Default::default());
    for fixture_id in fixtures.iter() {
        add_test_fixture(&fixture_manager, *fixture_id);
    }
    let mut effect_instance = EffectInstance::new(
        effect,
        fixtures.into_iter().map(FixtureId::Fixture).collect(),
        1f64,
    );
    let frames = effect
        .channels
        .iter()
        .map(|c| c.steps.len())
        .max()
        .unwrap_or_default()
        * FRAMES_PER_STEP;

    for _ in 0..frames {
        let frame = clock.tick();
        history_ticks.push(frame.frame);

        effect_instance.process(effect, &fixture_manager, frame);

        collect_fixture_frames(&fixture_manager, &mut fixture_frames);
    }

    Ok((fixture_frames, history_ticks))
}

fn generate_graph(
    effect: &Effect,
    fixture_frames: HashMap<(u32, FixtureFaderControl), Vec<f64>>,
    history_ticks: Vec<f64>,
) -> anyhow::Result<()> {
    let dir = Path::new(".snapshots");
    fs::create_dir_all(dir)?;
    let name = format!("{}-time.svg", effect.name);
    let file_path = dir.join(name);

    let frames = history_ticks.iter().last().copied().unwrap_or_default();

    let backend = setup_chart(&file_path)?;
    let mut chart = ChartBuilder::on(&backend)
        .x_label_area_size(40)
        .y_label_area_size(40)
        .build_cartesian_2d(0f64..frames, -1f64..1f64)?;
    chart
        .configure_mesh()
        .disable_mesh()
        .x_labels(4)
        .x_desc("Frames")
        .y_labels(4)
        .y_desc("Value")
        .draw()?;
    for (i, ((id, control), values)) in fixture_frames
        .iter()
        .sorted_by(|a, b| {
            let id_ordering = a.0 .0.cmp(&b.0 .0);
            if id_ordering != Ordering::Equal {
                id_ordering
            } else {
                a.0 .1.cmp(&b.0 .1)
            }
        })
        .enumerate()
    {
        chart
            .draw_series(LineSeries::new(
                history_ticks.iter().zip(values).map(|(x, y)| (*x, *y)),
                Palette99::pick(i),
            ))?
            .label(format!("{id}-{control:?}"))
            .legend(move |(x, y)| {
                Rectangle::new([(x - 5, y - 5), (x + 5, y + 5)], Palette99::pick(i))
            });
    }
    chart
        .configure_series_labels()
        .position(SeriesLabelPosition::UpperRight)
        .margin(16)
        .label_font(("Calibri", 20))
        .draw()?;

    backend.present()?;

    Ok(())
}

fn generate_position_graph(
    effect: &Effect,
    fixture_frames: HashMap<(u32, FixtureFaderControl), Vec<f64>>,
) -> anyhow::Result<()> {
    let dir = Path::new(".snapshots");
    fs::create_dir_all(dir)?;
    let name = format!("{}-position.svg", effect.name);
    let file_path = dir.join(name);
    let pan = fixture_frames.get(&(1, FixtureFaderControl::Pan)).unwrap();
    let tilt = fixture_frames.get(&(1, FixtureFaderControl::Tilt)).unwrap();

    let backend = setup_chart(&file_path)?;
    let mut chart = ChartBuilder::on(&backend)
        .x_label_area_size(40)
        .y_label_area_size(40)
        .build_cartesian_2d(-1f64..1f64, -1f64..1f64)?;
    chart
        .configure_mesh()
        .disable_mesh()
        .x_labels(5)
        .x_desc("Pan")
        .y_labels(5)
        .y_desc("Tilt")
        .draw()?;
    chart.draw_series(LineSeries::new(
        pan.iter().zip(tilt).map(|(x, y)| (*x, *y)),
        BLUE,
    ))?;

    backend.present()?;

    Ok(())
}

fn setup_chart(path: &Path) -> anyhow::Result<DrawingArea<SVGBackend, Shift>> {
    let backend = SVGBackend::new(path, (600, 480)).into_drawing_area();
    backend.fill(&WHITE)?;
    let backend = backend.margin(8, 8, 8, 8);

    Ok(backend)
}

fn add_test_fixture(fixture_manager: &FixtureManager, id: u32) {
    fixture_manager.add_fixture(
        id,
        "Fixture".into(),
        FixtureDefinition {
            id: "test-fixture".into(),
            name: "Test Fixture".into(),
            manufacturer: "Mizer".into(),
            modes: vec![FixtureMode::new(
                "Default".into(),
                vec![
                    FixtureChannelDefinition {
                        name: "intensity".into(),
                        resolution: ChannelResolution::Coarse(0),
                    },
                    FixtureChannelDefinition {
                        name: "pan".into(),
                        resolution: ChannelResolution::Coarse(0),
                    },
                    FixtureChannelDefinition {
                        name: "tilt".into(),
                        resolution: ChannelResolution::Coarse(0),
                    },
                ],
                FixtureControls {
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
                }
                .into(),
                vec![],
            )],
            physical: Default::default(),
            tags: Vec::new(),
            provider: "Test",
        },
        Some("Default".into()),
        None,
        1,
        None,
        Default::default(),
    );
}

fn collect_fixture_frames(
    fixture_manager: &FixtureManager,
    frames: &mut HashMap<(u32, FixtureFaderControl), Vec<f64>>,
) {
    for fixture in fixture_manager.get_fixtures() {
        for control in fixture
            .current_mode
            .controls
            .controls()
            .into_iter()
            .flat_map(|(controls, _)| controls.faders())
        {
            if let Some(value) = fixture.read_control(control.clone()) {
                frames.entry((fixture.id, control)).or_default().push(value);
            }
        }
    }
}
