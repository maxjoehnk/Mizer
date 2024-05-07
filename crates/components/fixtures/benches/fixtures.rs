use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion, Throughput};
use mizer_fixtures::definition::{ChannelResolution, ColorChannel, ColorGroup, FixtureChannelDefinition, FixtureControlChannel, FixtureControls, FixtureDefinition, FixtureFaderControl, FixtureMode};
use mizer_fixtures::fixture::{Fixture, IFixtureMut};

pub fn fixtures_bench(c: &mut Criterion) {
    let mut group = c.benchmark_group("fixtures intensity");
    for count in [1, 10, 100, 1000].iter() {
        group.throughput(Throughput::Elements(*count as u64));
        group.bench_with_input(BenchmarkId::from_parameter(count), count, |b, count| {
            let mut fixtures = build_fixtures(*count);
            b.iter(|| {
                for fixture in fixtures.iter_mut() {
                    fixture.write_fader_control(FixtureFaderControl::Intensity, 1.0, Default::default());
                }
            })
        });
    }
    group.finish();
    let mut group = c.benchmark_group("fixtures color");
    for count in [1, 10, 100, 1000].iter() {
        group.throughput(Throughput::Elements(*count as u64));
        group.bench_with_input(BenchmarkId::from_parameter(count), count, |b, count| {
            let mut fixtures = build_fixtures(*count);
            b.iter(|| {
                for fixture in fixtures.iter_mut() {
                    fixture.write_fader_control(FixtureFaderControl::ColorMixer(ColorChannel::Red), 1.0, Default::default());
                }
            })
        });
    }
    group.finish();
}

fn build_fixtures(count: usize) -> Vec<Fixture> {
    let definition = FixtureDefinition {
        name: Default::default(),
        id: Default::default(),
        manufacturer: Default::default(),
        modes: vec![
            FixtureMode::new(Default::default(), vec![
                FixtureChannelDefinition {
                    name: "Intensity".to_string(),
                    resolution: ChannelResolution::Coarse(0),
                },
                FixtureChannelDefinition {
                    name: "Red".to_string(),
                    resolution: ChannelResolution::Coarse(1),
                },
                FixtureChannelDefinition {
                    name: "Green".to_string(),
                    resolution: ChannelResolution::Coarse(2),
                },
                FixtureChannelDefinition {
                    name: "Blue".to_string(),
                    resolution: ChannelResolution::Coarse(3),
                },
            ], FixtureControls {
                intensity: Some(FixtureControlChannel::Channel("Intensity".into())),
                color_mixer: Some(ColorGroup::Rgb {
                    red: FixtureControlChannel::Channel("Red".into()),
                    green: FixtureControlChannel::Channel("Green".into()),
                    blue: FixtureControlChannel::Channel("Blue".into()),
                    white: None,
                    amber: None,
                }),
                ..Default::default()
            }, Default::default()),
        ],
        physical: Default::default(),
        provider: "benchmark",
        tags: Default::default(),
    };
    let mut fixtures = Vec::with_capacity(count);
    for i in 0..count {
        let fixture = Fixture::new(i as u32, format!("fixture-{}", i), definition.clone(), None, 0, None, Default::default());
        fixtures.push(fixture);
    }

    fixtures
}

criterion_group!(benches, fixtures_bench);
criterion_main!(benches);
