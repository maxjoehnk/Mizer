use itertools::Itertools;
use crate::definition::FixtureDefinition;
use mizer_ui_api::table::*;

pub struct FixtureDefinitionTable;

impl TableHandler for FixtureDefinitionTable {
    type Data = Vec<FixtureDefinition>;

    fn get_table(&self, data: Self::Data) -> anyhow::Result<TableData> {
        let columns = vec![
            TableColumn {
                label: "Name".into(),
            },
            TableColumn {
                label: "Manufacturer".into(),
            },
            TableColumn {
                label: "Provider".into(),
            },
            TableColumn {
                label: "Tags".into(),
            },
        ];
        let rows = data.into_iter()
            .sorted_by(|lhs, rhs| lhs.manufacturer.cmp(&rhs.manufacturer))
            .map(Self::build_row)
            .collect();

        Ok(TableData { columns, rows })
    }
}

impl FixtureDefinitionTable {
    fn build_row(data: FixtureDefinition) -> TableRow {
        TableRow {
            id: data.id,
            cells: vec![
                TableCell {
                    content: TableCellContent::Text(data.name),
                },
                TableCell {
                    content: TableCellContent::Text(data.manufacturer),
                },
                TableCell {
                    content: TableCellContent::Text(data.provider.to_string()),
                },
                TableCell {
                    content: TableCellContent::Text(data.tags.join(", ")),
                },
            ],
            children: Default::default(),
        }
    }
}
