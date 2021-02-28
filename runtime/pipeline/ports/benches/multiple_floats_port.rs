use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};

use mizer_ports::*;

pub fn criterion_benchmark(c: &mut Criterion) {
    let mut group = c.benchmark_group("multiple float ports memory");
    for power in 0..8 {
        let size = 10u64.pow(power);
        group.throughput(Throughput::Elements(size));
        group.bench_with_input(
            BenchmarkId::from_parameter(size),
            &size,
            |b, size| {
                let (tx, rx) = mizer_ports::memory::channel::<Vec<f64>>();
                let size = *size as usize;
                let buffer = vec![0.; size];
                b.iter(|| {
                    tx.send(buffer.clone());
                    let _ = rx.recv().unwrap();
                })
            },
        );
    }
    group.finish();
}

criterion_group!(benches, criterion_benchmark);
criterion_main!(benches);
