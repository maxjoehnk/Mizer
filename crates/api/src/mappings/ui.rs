use crate::proto::ui::*;
use mizer_ui_api::{table, view};

impl From<table::TableData> for TabularData {
    fn from(value: table::TableData) -> Self {
        Self {
            columns: value
                .columns
                .into_iter()
                .map(|c| c.label.into_owned())
                .collect(),
            rows: value.rows.into_iter().map(Row::from).collect(),
        }
    }
}

impl From<table::TableRow> for Row {
    fn from(row: table::TableRow) -> Self {
        Self {
            id: row.id,
            cells: row
                .cells
                .into_iter()
                .map(|c| c.content.to_string())
                .collect(),
            children: row.children.into_iter().map(Row::from).collect(),
        }
    }
}

impl From<view::View> for View {
    fn from(view: view::View) -> Self {
        Self {
            title: view.title,
            icon: view.icon.to_string(),
            child: Some(ViewChild {
                child: Some(view.child.into()),
                width: None,
                height: None,
            }),
        }
    }
}

impl From<view::ViewChild> for view_child::Child {
    fn from(child: view::ViewChild) -> Self {
        match child {
            view::ViewChild::Panel(panel) => view_child::Child::Panel(panel.into()),
            view::ViewChild::Group(group) =>
                view_child::Child::Group(group.into()),
        }
    }
}

impl From<view::RowItem> for ViewChild {
    fn from(item: view::RowItem) -> Self {
        ViewChild {
            child: Some(item.panel.into()),
            width: Some(item.width.into()),
            height: None,
        }
    }
}

impl From<view::ColumnItem> for ViewChild {
    fn from(item: view::ColumnItem) -> Self {
        ViewChild {
            child: Some(item.panel.into()),
            height: Some(item.height.into()),
            width: None,
        }
    }
}

impl From<view::PanelGroup> for PanelGroup {
    fn from(group: view::PanelGroup) -> Self {
        match group {
            view::PanelGroup::Row(items) => {
                Self {
                    direction: panel_group::Direction::Horizontal as i32,
                    children: items.into_iter().map(ViewChild::from).collect(),
                }
            }
            view::PanelGroup::Column(items) => {
                Self {
                    direction: panel_group::Direction::Vertical as i32,
                    children: items.into_iter().map(ViewChild::from).collect(),
                }
            }
        }
    }
}

impl From<view::Panel> for Panel {
    fn from(panel: view::Panel) -> Self {
        Self {
            panel_type: panel.panel_type.to_string(),
        }
    }
}

impl From<view::Size> for Size {
    fn from(size: view::Size) -> Self {
        let size = match size {
            view::Size::Fill => size::Size::Fill(Fill {}),
            view::Size::Pixels(pixels) => size::Size::Pixels(Pixels { pixels }),
            view::Size::Flex(flex) => size::Size::Flex(Flex { flex }),
            view::Size::GridItems(count) => size::Size::GridItems(GridItems { count }),
        };

        Self {
            size: Some(size)
        }
    }
}
