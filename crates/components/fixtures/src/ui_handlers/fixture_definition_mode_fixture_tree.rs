use crate::definition::{
    AxisGroup, ColorGroup, FixtureControl, FixtureControlChannel, FixtureControlType,
    FixtureControls, FixtureMode, SubFixtureControlChannel,
};
use itertools::Itertools;
use mizer_ui_api::table::*;

pub struct FixtureDefinitionTreeTable;

impl TableHandler for FixtureDefinitionTreeTable {
    type Data = FixtureMode;

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
            .sub_fixtures
            .into_iter()
            .map(|children| TableRow {
                id: children.id.to_string(),
                cells: vec![
                    TableCell {
                        content: TableCellContent::Text(children.name),
                    },
                    TableCell::empty(),
                    TableCell::empty(),
                ],
                children: Self::build_sub_controls(&children.controls),
            })
            .chain(Self::build_controls(&data.controls))
            .collect();

        Ok(TableData { columns, rows })
    }
}

impl FixtureDefinitionTreeTable {
    fn build_controls(controls: &FixtureControls<FixtureControlChannel>) -> Vec<TableRow> {
        let mut rows = Vec::default();
        if let Some(channel) = &controls.intensity {
            rows.push(basic_control("Intensity", channel));
        }
        if let Some(channel) = &controls.shutter {
            rows.push(basic_control("Shutter", channel));
        }
        if let Some(channel) = &controls.iris {
            rows.push(basic_control("Iris", channel));
        }
        if let Some(channel) = &controls.focus {
            rows.push(basic_control("Focus", channel));
        }
        if let Some(channel) = &controls.zoom {
            rows.push(basic_control("Zoom", channel));
        }
        if let Some(channel) = &controls.frost {
            rows.push(basic_control("Frost", channel));
        }
        if let Some(channel) = &controls.prism {
            rows.push(basic_control("Prism", channel));
        }
        if let Some(channel) = &controls.pan {
            rows.push(movement_control("Pan", channel));
        }
        if let Some(channel) = &controls.tilt {
            rows.push(movement_control("Tilt", channel));
        }
        if let Some(channel) = &controls.color_mixer {
            rows.push(TableRow {
                id: "Color Mixer".to_string(),
                cells: vec![
                    TableCell {
                        content: TableCellContent::Text("Color Mixer".to_string()),
                    },
                    TableCell {
                        content: TableCellContent::Text(match channel {
                            ColorGroup::Rgb {
                                red,
                                green,
                                blue,
                                white,
                                amber,
                            } => vec![
                                Some(red),
                                Some(green),
                                Some(blue),
                                white.as_ref(),
                                amber.as_ref(),
                            ]
                            .into_iter()
                            .flatten()
                            .map(control_channel)
                            .join(", "),
                            ColorGroup::Cmy {
                                cyan,
                                magenta,
                                yellow,
                            } => format!(
                                "C: {}, M: {}, Y: {}",
                                control_channel(cyan),
                                control_channel(magenta),
                                control_channel(yellow)
                            ),
                        }),
                    },
                    TableCell {
                        content: TableCellContent::Text(
                            if matches!(channel, ColorGroup::Rgb { .. }) {
                                "RGB"
                            } else {
                                "CMY"
                            }
                            .to_string(),
                        ),
                    },
                ],
                children: Default::default(),
            });
        }
        if let Some(channel) = &controls.color_wheel {
            rows.push(TableRow {
                id: "Color Wheel".to_string(),
                cells: vec![
                    TableCell {
                        content: TableCellContent::Text("Color Wheel".to_string()),
                    },
                    TableCell {
                        content: TableCellContent::Text(control_channel(&channel.channel)),
                    },
                    TableCell {
                        content: TableCellContent::Text(
                            channel.colors.iter().map(|c| &c.name).join(", "),
                        ),
                    },
                ],
                children: Default::default(),
            })
        }
        for channel in &controls.generic {
            rows.push(TableRow {
                id: channel.label.clone(),
                cells: vec![
                    TableCell {
                        content: TableCellContent::Text(channel.label.clone()),
                    },
                    TableCell {
                        content: TableCellContent::Text(control_channel(&channel.channel)),
                    },
                    TableCell::empty(),
                ],
                children: Default::default(),
            });
        }

        rows
    }

    fn build_sub_controls(controls: &FixtureControls<SubFixtureControlChannel>) -> Vec<TableRow> {
        let mut rows = Vec::default();
        if let Some(channel) = &controls.intensity {
            rows.push(basic_sub_control("Intensity", channel));
        }
        if let Some(channel) = &controls.shutter {
            rows.push(basic_sub_control("Shutter", channel));
        }
        if let Some(channel) = &controls.iris {
            rows.push(basic_sub_control("Iris", channel));
        }
        if let Some(channel) = &controls.focus {
            rows.push(basic_sub_control("Focus", channel));
        }
        if let Some(channel) = &controls.zoom {
            rows.push(basic_sub_control("Zoom", channel));
        }
        if let Some(channel) = &controls.frost {
            rows.push(basic_sub_control("Frost", channel));
        }
        if let Some(channel) = &controls.prism {
            rows.push(basic_sub_control("Prism", channel));
        }
        if let Some(channel) = &controls.pan {
            rows.push(movement_sub_control("Pan", channel));
        }
        if let Some(channel) = &controls.tilt {
            rows.push(movement_sub_control("Tilt", channel));
        }
        if let Some(channel) = &controls.color_mixer {
            rows.push(TableRow {
                id: "Color Mixer".to_string(),
                cells: vec![
                    TableCell {
                        content: TableCellContent::Text("Color Mixer".to_string()),
                    },
                    TableCell {
                        content: TableCellContent::Text(match channel {
                            ColorGroup::Rgb {
                                red,
                                green,
                                blue,
                                white,
                                amber,
                            } => vec![
                                Some(format!("R: {}", sub_control_channel(red))),
                                Some(format!("G: {}", sub_control_channel(green))),
                                Some(format!("B: {}", sub_control_channel(blue))),
                                white
                                    .as_ref()
                                    .map(|white| format!("W: {}", sub_control_channel(white))),
                                amber
                                    .as_ref()
                                    .map(|amber| format!("A: {}", sub_control_channel(amber))),
                            ]
                            .into_iter()
                            .flatten()
                            .join(", "),
                            ColorGroup::Cmy {
                                cyan,
                                magenta,
                                yellow,
                            } => format!(
                                "C: {}, M: {}, Y: {}",
                                sub_control_channel(cyan),
                                sub_control_channel(magenta),
                                sub_control_channel(yellow)
                            ),
                        }),
                    },
                    TableCell {
                        content: TableCellContent::Text(
                            if matches!(channel, ColorGroup::Rgb { .. }) {
                                "RGB"
                            } else {
                                "CMY"
                            }
                            .to_string(),
                        ),
                    },
                ],
                children: Default::default(),
            });
        }
        if let Some(channel) = &controls.color_wheel {
            rows.push(TableRow {
                id: "Color Wheel".to_string(),
                cells: vec![
                    TableCell {
                        content: TableCellContent::Text("Color Wheel".to_string()),
                    },
                    TableCell {
                        content: TableCellContent::Text(sub_control_channel(&channel.channel)),
                    },
                    TableCell {
                        content: TableCellContent::Text(
                            channel.colors.iter().map(|c| &c.name).join(", "),
                        ),
                    },
                ],
                children: Default::default(),
            })
        }
        for channel in &controls.generic {
            rows.push(TableRow {
                id: channel.label.clone(),
                cells: vec![
                    TableCell {
                        content: TableCellContent::Text(channel.label.clone()),
                    },
                    TableCell {
                        content: TableCellContent::Text(sub_control_channel(&channel.channel)),
                    },
                    TableCell::empty(),
                ],
                children: Default::default(),
            });
        }

        rows
    }
}

fn basic_control(name: &str, control: &FixtureControlChannel) -> TableRow {
    TableRow {
        id: name.to_string(),
        cells: vec![
            TableCell {
                content: TableCellContent::Text(name.to_string()),
            },
            TableCell {
                content: TableCellContent::Text(control_channel(control)),
            },
            TableCell::empty(),
        ],
        children: Default::default(),
    }
}

fn basic_sub_control(name: &str, control: &SubFixtureControlChannel) -> TableRow {
    TableRow {
        id: name.to_string(),
        cells: vec![
            TableCell {
                content: TableCellContent::Text(name.to_string()),
            },
            TableCell {
                content: TableCellContent::Text(sub_control_channel(control)),
            },
            TableCell::empty(),
        ],
        children: Default::default(),
    }
}

fn movement_control(name: &str, group: &AxisGroup<FixtureControlChannel>) -> TableRow {
    TableRow {
        id: name.to_string(),
        cells: vec![
            TableCell {
                content: TableCellContent::Text(name.to_string()),
            },
            TableCell {
                content: TableCellContent::Text(control_channel(&group.channel)),
            },
            TableCell {
                content: if let Some(angle) = group.angle {
                    TableCellContent::Text(format!("{}° - {}°", angle.from, angle.to))
                } else {
                    TableCellContent::Empty
                },
            },
        ],
        children: Default::default(),
    }
}

fn movement_sub_control(name: &str, group: &AxisGroup<SubFixtureControlChannel>) -> TableRow {
    TableRow {
        id: name.to_string(),
        cells: vec![
            TableCell {
                content: TableCellContent::Text(name.to_string()),
            },
            TableCell {
                content: TableCellContent::Text(sub_control_channel(&group.channel)),
            },
            TableCell {
                content: if let Some(angle) = group.angle {
                    TableCellContent::Text(format!("{}° - {}°", angle.from, angle.to))
                } else {
                    TableCellContent::Empty
                },
            },
        ],
        children: Default::default(),
    }
}

fn control_channel(channel: &FixtureControlChannel) -> String {
    match channel {
        FixtureControlChannel::Channel(channel) => channel.to_string(), // TODO: show dmx address
        FixtureControlChannel::Delegate => "Delegate".to_string(),
        FixtureControlChannel::VirtualDimmer => "Virtual Dimmer".to_string(),
    }
}

fn sub_control_channel(channel: &SubFixtureControlChannel) -> String {
    match channel {
        SubFixtureControlChannel::Channel(channel) => channel.to_string(), // TODO: show dmx address
        SubFixtureControlChannel::VirtualDimmer => "Virtual Dimmer".to_string(),
    }
}
