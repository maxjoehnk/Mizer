use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};

use benchmark_runtime::build_runtime;
use mizer_module::Runtime;
use mizer_project_files::{Project, ProjectManagerMut};

mod benchmark_runtime;

pub fn oscillator_bench(c: &mut Criterion) {
    let mut group = c.benchmark_group("oscillator nodes");
    for count in [1, 10, 100, 1000].iter() {
        group.throughput(Throughput::Elements(*count as u64));
        group.bench_with_input(BenchmarkId::from_parameter(count), count, |b, count| {
            let project = Project::load(&project_config(*count)).unwrap();
            let mut runtime = build_runtime();
            runtime.load(&project).unwrap();
            b.iter(|| runtime.process())
        });
    }
    group.finish();
}

fn project_config(count: i32) -> String {
    let nodes = (0..count)
        .map(|i| {
            format!(
                r#"
- path: /oscillator-{i}
  type: oscillator
  config:
    type: sine
    interval: 1.0
    max: 1.0
    min: 0.0
    offset: 0.0
    reverse: false"#
            )
        })
        .collect::<Vec<_>>()
        .join("\n");

    format!(
        r#"
nodes:
{nodes}
channels: []
"#,
    )
}

criterion_group!(benches, oscillator_bench);
criterion_main!(benches);
