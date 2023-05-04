use criterion::{criterion_group, criterion_main, Criterion};

use mizer_ports::*;

pub fn criterion_benchmark(c: &mut Criterion) {
    c.bench_function("single float port memory", |b| {
        let (tx, rx) = memory::channel::<f64>();
        b.iter(|| {
            tx.send(1.);
            let _ = rx.recv();
        })
    });
}

criterion_group!(benches, criterion_benchmark);
criterion_main!(benches);
