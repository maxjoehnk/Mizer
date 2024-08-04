use itertools::Itertools;
use mizer_ui_api::table::*;
use crate::definition::{ChannelResolution, FixtureChannelDefinition, FixtureMode};

pub struct FixtureDefinitionDmxChannelTable;

impl TableHandler for FixtureDefinitionDmxChannelTable {
    type Data = FixtureMode;

    fn get_table(&self, data: Self::Data) -> anyhow::Result<TableData> {
        let columns = vec![
            TableColumn {
                label: "Name".into(),
            },
            TableColumn {
                label: "Address".into(),
            },
        ];
        let rows = data.channels.into_iter()
            .sorted_by_key(|(_, channel)| channel.first_address())
            .map(Self::build_row)
            .collect();

        Ok(TableData {
            columns,
            rows,
        })
    }
}

impl FixtureDefinitionDmxChannelTable {
    fn build_row((name, definition): (String, FixtureChannelDefinition)) -> TableRow {
        TableRow {
            id: name.clone(),
            cells: vec![
                TableCell {
                    content: TableCellContent::Text(name),
                },
                TableCell {
                    content: TableCellContent::Text(match definition.resolution {
                        ChannelResolution::Coarse(coarse) => format!("8 Bit ({coarse})"),
                        ChannelResolution::Fine(coarse, fine) => format!("16 Bit ({coarse}, {fine})"),
                        ChannelResolution::Finest(coarse, fine, finest) => format!("24 Bit ({coarse}, {fine}, {finest})"),
                        ChannelResolution::Ultra(coarse, fine, finest, ultra) => format!("32 Bit ({coarse}, {fine}, {finest}, {ultra})"),
                    }),
                },
            ],
            children: Default::default()
        }
    }
}
