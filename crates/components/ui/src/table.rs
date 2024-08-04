use std::borrow::Cow;
use std::fmt::{Display, Formatter};

pub trait TableHandler {
    type Data;
    
    fn get_table(&self, data: Self::Data) -> anyhow::Result<TableData>;
}

#[derive(Debug, Clone)]
pub struct TableData {
    pub columns: Vec<TableColumn>,
    pub rows: Vec<TableRow>,
}

#[derive(Debug, Clone)]
pub struct TableColumn {
    pub label: Cow<'static, str>,
}

#[derive(Debug, Clone)]
pub struct TableRow {
    pub id: String,
    pub cells: Vec<TableCell>,
    pub children: Vec<TableRow>,
}

#[derive(Debug, Clone)]
pub struct TableCell {
    pub content: TableCellContent,
}

impl TableCell {
    pub fn empty() -> Self {
        Self {
            content: TableCellContent::Empty,
        }
    }
}

#[derive(Debug, Clone)]
pub enum TableCellContent {
    Empty,
    Text(String),
    Uint(u64),
}

impl Display for TableCellContent {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Empty => f.write_str(""),
            Self::Text(text) => f.write_str(text),
            Self::Uint(value) => f.write_fmt(format_args!("{}", value)),
        }
    }
}