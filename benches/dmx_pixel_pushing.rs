use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};

use mizer_module::{Module, Runtime};
use mizer_project_files::{Project, ProjectManagerMut};
use mizer_protocol_dmx::DmxModule;
use mizer_runtime::DefaultRuntime;

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
                let mut runtime = build_runtime(dimensions);
                b.iter(|| runtime.process())
            },
        );
    }
    group.finish();
}

fn build_runtime(dimensions: &(i64, i64)) -> DefaultRuntime {
    let mut runtime = DefaultRuntime::new();
    let project = Project::load(&project_config(dimensions)).unwrap();
    DmxModule.register(&mut runtime).unwrap();
    runtime.load(&project).unwrap();

    runtime
}

fn project_config((width, height): &(i64, i64)) -> String {
    format!(
        r#"
nodes:
  - type: pixel-pattern
    path: /pixel-pattern-0
    config:
      pattern: rgb-iterate
  - type: pixel-dmx
    path: /pixel-dmx-0
    config:
      output: output
      width: {}
      height: {}
channels:
  - output@/pixel-pattern-0 -> input@/pixel-dmx-0
"#,
        width, height
    )
}

criterion_group!(benches, criterion_benchmark);
criterion_main!(benches);
