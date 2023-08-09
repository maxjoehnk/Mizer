use mizer_fixtures::fixture::Fixture;

const PDF_TEMPLATE: &str = include_str!("../template.tex");

#[derive(Debug, Clone)]
pub struct PatchExporter {}

impl PatchExporter {
    pub fn new() -> Self {
        Self {}
    }

    pub fn export(&self, fixtures: &[&Fixture]) -> anyhow::Result<Vec<u8>> {
        let content = generate_table(fixtures);
        let template = PDF_TEMPLATE.replace("{{content}}", &content);
        std::fs::write("patch.tex", &template)?;
        let pdf = tectonic::latex_to_pdf(template)
            .map_err(|err| anyhow::anyhow!("Unable to generate fixture patch: {err:?}"))?;

        Ok(pdf)
    }
}

fn generate_table(fixtures: &[&Fixture]) -> String {
    let mut table = Vec::new();

    for fixture in fixtures {
        table.push(generate_table_row(fixture));
    }

    table.join(" \\\\\n")
}

fn generate_table_row(fixture: &Fixture) -> String {
    format!(
        "{id} & {universe}.{channel} & {mode} & {model} & {manufacturer}",
        id = fixture.id,
        model = fixture.definition.name,
        manufacturer = fixture.definition.manufacturer,
        mode = fixture.current_mode.name,
        universe = fixture.universe,
        channel = fixture.channel
    )
}
