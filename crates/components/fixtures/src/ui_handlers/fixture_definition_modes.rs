use mizer_ui_api::table::*;
use crate::definition::{ChannelResolution, FixtureChannelDefinition, FixtureDefinition, FixtureMode};

pub struct FixtureDefinitionModesTable;

impl TableHandler for FixtureDefinitionModesTable {
    type Data = FixtureDefinition;

    fn get_table(&self, data: Self::Data) -> anyhow::Result<TableData> {
        let columns = vec![
            TableColumn {
                label: "Name".into(),
            },
            TableColumn {
                label: "Channel Count".into(),
            },
        ];
        let rows = data.modes.into_iter()
            .map(Self::build_row)
            .collect();

        Ok(TableData {
            columns,
            rows,
        })
    }
}

impl FixtureDefinitionModesTable {
    fn build_row(mode: FixtureMode) -> TableRow {
        let dmx_channels = mode.dmx_channels() as u64;
        TableRow {
            id: mode.name.clone(),
            cells: vec![
                TableCell {
                    content: TableCellContent::Text(mode.name),
                },
                TableCell {
                    content: TableCellContent::Uint(dmx_channels),
                },
            ],
            children: mode.channels.into_iter()
                .map(Self::build_channel)
                .collect()
        }
    }

    fn build_channel((name, definition): (String, FixtureChannelDefinition)) -> TableRow {
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
