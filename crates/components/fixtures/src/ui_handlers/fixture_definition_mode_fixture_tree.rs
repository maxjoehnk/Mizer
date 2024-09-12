use std::collections::HashMap;
use mizer_ui_api::table::*;
use crate::channels::{FixtureChannel, FixtureChannelDefinition, FixtureChannelMode};

pub struct FixtureDefinitionTreeTable;

impl TableHandler for FixtureDefinitionTreeTable {
    type Data = FixtureChannelMode;

    fn get_table(&self, data: Self::Data) -> anyhow::Result<TableData> {
        let columns = vec![
            TableColumn {
                label: "Name".into(),
            },
            TableColumn {
                label: "DMX Channel".into(),
            },
            TableColumn { label: "".into() },
        ];
        let rows = data
            .children
            .into_iter()
            .map(|children| TableRow {
                id: children.id.to_string(),
                cells: vec![
                    TableCell {
                        content: TableCellContent::Text(children.name.to_string()),
                    },
                    TableCell::empty(),
                    TableCell::empty(),
                ],
                children: Self::build_controls(&children.channels),
            })
            .chain(Self::build_controls(&data.channels))
            .collect();

        Ok(TableData { columns, rows })
    }
}

impl FixtureDefinitionTreeTable {
    fn build_controls(controls: &HashMap<FixtureChannel, FixtureChannelDefinition>) -> Vec<TableRow> {
        controls.iter()
            .map(|(channel, definition)| {
                TableRow {
                    id: channel.to_string(),
                    cells: vec![
                        TableCell {
                            content: TableCellContent::Text(channel.to_string()),
                        },
                        TableCell {
                            content: TableCellContent::Text(format!("{:?}", definition.channels)),
                        },
                        TableCell::empty(),
                    ],
                    children: Default::default(),
                }
            })
            .collect()
    }
}
