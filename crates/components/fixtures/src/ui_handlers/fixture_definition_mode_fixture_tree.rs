use indexmap::IndexMap;
use itertools::Itertools;
use mizer_ui_api::table::*;
use crate::channels::{DmxChannels, FixtureChannel, FixtureChannelDefinition, FixtureChannelMode};

pub struct FixtureDefinitionTreeTable;

impl TableHandler for FixtureDefinitionTreeTable {
    type Data = FixtureChannelMode;

    fn get_table(&self, data: Self::Data) -> anyhow::Result<TableData> {
        let columns = vec![
            TableColumn {
                label: "Name".into(),
            },
            TableColumn {
                label: "Label".into(),
            },
            TableColumn {
                label: "DMX".into(),
            },
            TableColumn {
                label: "Highlight".into(),
            },
            TableColumn {
                label: "Default".into(),
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
                    TableCell::empty(),
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
    fn build_controls(controls: &IndexMap<FixtureChannel, FixtureChannelDefinition>) -> Vec<TableRow> {
        controls.iter()
            .sorted_by_key(|(_, channel)| channel.first_address())
            .map(|(channel, definition)| {
                TableRow {
                    id: channel.to_string(),
                    cells: vec![
                        TableCell {
                            content: TableCellContent::Text(channel.to_string()),
                        },
                        TableCell {
                            content: TableCellContent::Text(match definition.label.as_ref() {
                                Some(label) => label.to_string(),
                                None => "None".to_string(),
                            }),
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
                        TableCell {
                            content: TableCellContent::Text(match definition.highlight {
                                Some(highlight) => highlight.to_string(),
                                None => "None".to_string(),
                            }),
                        },
                        TableCell {
                            content: TableCellContent::Text(match definition.default {
                                Some(default) => default.to_string(),
                                None => "None".to_string(),
                            })
                        },
                        TableCell::empty(),
                    ],
                    children: Default::default(),
                }
            })
            .collect()
    }
}
