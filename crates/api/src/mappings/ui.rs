use crate::proto::ui::*;
use mizer_ui_api::table;

impl From<table::TableData> for TabularData {
    fn from(value: table::TableData) -> Self {
        Self {
            columns: value.columns.into_iter()
                .map(|c| c.label.into_owned())
                .collect(),
            rows: value.rows.into_iter()
                .map(Row::from)
                .collect(),
        }
    }
}

impl From<table::TableRow> for Row {
    fn from(row: table::TableRow) -> Self {
        Self {
            id: row.id,
            cells: row.cells.into_iter().map(|c| c.content.to_string()).collect(),
            children: row.children.into_iter().map(Row::from).collect(),
        }
    }
}
