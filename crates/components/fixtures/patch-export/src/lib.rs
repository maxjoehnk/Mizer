use mizer_fixtures::fixture::Fixture;

const HEADER: &str = "ID,Name,Address,Manufacturer,Model,Mode";

#[derive(Default, Debug, Clone)]
pub struct PatchExporter {}

impl PatchExporter {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn export_csv(&self, fixtures: &[&Fixture]) -> anyhow::Result<Vec<u8>> {
        let mut content = fixtures
            .iter()
            .map(|fixture| {
                format!(
                    "{},{},{}.{},{},{},{}",
                    fixture.id,
                    fixture.name,
                    fixture.universe,
                    fixture.channel,
                    fixture.definition.manufacturer,
                    fixture.definition.name,
                    fixture.channel_mode.name
                )
            })
            .collect::<Vec<_>>();
        content.insert(0, HEADER.to_string());

        let buffer = content.join("\n").as_bytes().to_vec();

        Ok(buffer)
    }
}
