use itertools::Itertools;
use mizer_ui_api::table::*;
use crate::channels::{DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode};

pub struct FixtureDefinitionDmxChannelTable;

impl TableHandler for FixtureDefinitionDmxChannelTable {
    type Data = FixtureChannelMode;

    fn get_table(&self, data: Self::Data) -> anyhow::Result<TableData> {
        let columns = vec![
            TableColumn {
                label: "Name".into(),
            },
            TableColumn {
                label: "Address".into(),
            },
        ];
        let rows = data
            .channels
            .into_iter()
            .sorted_by_key(|(_, channel)| channel.first_address())
            .map(Self::build_row)
            .collect();

        Ok(TableData { columns, rows })
    }
}

impl FixtureDefinitionDmxChannelTable {
    fn build_row((channel, definition): (FixtureChannel, FixtureChannelDefinition)) -> TableRow {
        TableRow {
            id: channel.to_string(),
            cells: vec![
                TableCell {
                    content: TableCellContent::Text(channel.to_string()),
                },
                TableCell {
                    content: TableCellContent::Text(match definition.channels {
                        DmxChannels::Resolution8Bit { coarse } => format!("8 Bit ({coarse})"),
                        DmxChannels::Resolution16Bit { coarse, fine } => {
                            format!("16 Bit ({coarse}, {fine})")
                        }
                        DmxChannels::Resolution24Bit { coarse, fine, finest } => {
                            format!("24 Bit ({coarse}, {fine}, {finest})")
                        }
                        DmxChannels::Resolution32Bit { coarse, fine, finest, ultra } => {
                            format!("32 Bit ({coarse}, {fine}, {finest}, {ultra})")
                        }
                    }),
                },
            ],
            children: Default::default(),
        }
    }
}
