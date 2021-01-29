use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};

use mizer::*;
use mizer_pipeline::Pipeline;
use mizer_project_files::Project;
use mizer_fixtures::manager::FixtureManager;

pub fn criterion_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("pixel pipeline");
    for (width, height) in [
        (1, 1),
        (10, 10),
        (100, 100),
        (1000, 1000),
        (1920, 1080),
        (3840, 2160),
    ]
    .iter()
    {
        group.throughput(Throughput::Elements((width * height) as u64));
        group.bench_with_input(
            BenchmarkId::from_parameter(format!("({}, {})", width, height)),
            &(*width, *height),
            |b, dimensions| {
                let mut pipeline = build_pipeline(dimensions);
                b.iter(|| pipeline.process())
            },
        );
    }
    group.finish();
}

fn build_pipeline<'a>(dimensions: &(i64, i64)) -> Pipeline<'a> {
    let mut pipeline = Pipeline::default();
    let project = Project::load(&project_config(dimensions)).unwrap();
    let fixture_manager = FixtureManager::new();
    pipeline.load_project(project, &fixture_manager).unwrap();

    pipeline
}

fn project_config((width, height): &(i64, i64)) -> String {
    format!(
        r#"
nodes:
  - type: pixel-pattern
    id: pixel-pattern-0
    config:
      pattern: rgb-iterate
  - type: pixel-dmx
    id: pixel-dmx-0
    config:
      width: {}
      height: {}
channels:
  - output@pixel-pattern-0 -> input@pixel-dmx-0
"#,
        width, height
    )
}

criterion_group!(benches, criterion_benchmark);
criterion_main!(benches);
