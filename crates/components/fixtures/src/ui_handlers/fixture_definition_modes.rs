use crate::definition::{
    FixtureDefinition,
};
use mizer_ui_api::table::*;
use crate::channels::{DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode};

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
        let rows = data.modes.into_iter().map(Self::build_row).collect();

        Ok(TableData { columns, rows })
    }
}

impl FixtureDefinitionModesTable {
    fn build_row(mode: FixtureChannelMode) -> TableRow {
        let dmx_channels = mode.channel_count() as u64;
        TableRow {
            id: mode.name.to_string(),
            cells: vec![
                TableCell {
                    content: TableCellContent::Text(mode.name.to_string()),
                },
                TableCell {
                    content: TableCellContent::Uint(dmx_channels),
                },
            ],
            children: mode.channels.into_iter().map(Self::build_channel).collect(),
        }
    }

    fn build_channel((channel, definition): (FixtureChannel, FixtureChannelDefinition)) -> TableRow {
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
