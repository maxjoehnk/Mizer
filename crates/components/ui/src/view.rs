use std::fmt;
use std::sync::{Arc, RwLock};
use heck::ToSnakeCase;
use serde_derive::{Deserialize, Serialize};

#[derive(Clone, Default)]
pub struct ViewRegistry {
    views: Arc<RwLock<Vec<View>>>,
}

impl ViewRegistry {
    pub fn views(&self) -> Vec<View> {
        self.views.read().unwrap().clone()
    }

    pub fn clear_views(&self) {
        self.views.write().unwrap().clear();
    }

    pub fn add_views(&self, views: Vec<View>) {
        let mut registry = self.views.write().unwrap();
        registry.extend(views);
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
#[serde(rename_all = "snake_case")]
pub enum PanelType {
    Layout,
    Plan,
    NodeGraph,
    NodeProperties,
    NodePreview,
    SequenceList,
    SequenceProperties,
    FixtureList,
    GroupList,
    DimmerPresets,
    ShutterPresets,
    ColorPresets,
    PositionPresets,
    EffectList,
    EffectMovementPreview,
    EffectFrames,
    MediaList,
    MediaPreview,
    MediaMetadata,
    SurfaceList,
    SurfaceSections,
    SurfaceEditor,
    SurfaceProperties,
    TimecodeList,
    TimecodeEditor,
}

impl fmt::Display for PanelType {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let name = format!("{self:?}");
        let name = name.to_snake_case();

        write!(f, "{name}")
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
#[serde(rename_all = "snake_case")]
pub enum Icon {
    Layout,
    Plan,
    Nodes,
    Sequencer,
    Fixtures,
    Presets,
    Effects,
    Media,
    Surfaces,
    Timecode,
}

impl fmt::Display for Icon {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let name = format!("{self:?}");
        let name = name.to_snake_case();

        write!(f, "{name}")
    }
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct View {
    pub title: String,
    pub icon: Icon,
    pub child: ViewChild,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
#[serde(tag = "type", rename_all = "snake_case")]
pub enum ViewChild {
    Group(PanelGroup),
    Panel(Panel),
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
#[serde(tag = "direction", content = "children", rename_all = "snake_case")]
pub enum PanelGroup {
    Row(Vec<RowItem>),
    Column(Vec<ColumnItem>),
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct RowItem {
    pub width: Size,
    #[serde(flatten)]
    pub panel: ViewChild,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct ColumnItem {
    pub height: Size,
    #[serde(flatten)]
    pub panel: ViewChild,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
#[serde(rename_all = "snake_case")]
pub enum Size {
    Pixels(u32),
    Flex(u32),
    GridItems(f32),
    Fill,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Panel {
    pub panel_type: PanelType,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_layout_view_deserialization() {
        let json = serde_json::json!({
            "title": "Layout",
            "child": {
                "type": "panel",
                "panel_type": "layout"
            }
        });

        let view: View = serde_json::from_value(json).unwrap();

        assert_eq!(view.title, "Layout");
        assert_eq!(
            view.child,
            ViewChild::Panel(Panel {
                panel_type: PanelType::Layout
            })
        );
    }

    #[test]
    fn test_node_view_deserialization() {
        let json = serde_json::json!({
            "title": "Nodes",
            "icon": "nodes",
            "child": {
                "type": "group",
                "direction": "row",
                "children": [
                    {
                        "width": "fill",
                        "type": "panel",
                        "panel_type": "node_graph",
                    },
                    {
                        "width": {
                            "pixels": 302
                        },
                        "type": "group",
                        "direction": "column",
                        "children": [
                            {
                                "height": "fill",
                                "type": "panel",
                                "panel_type": "node_properties"
                            },
                            {
                                "height": {
                                    "pixels": 180
                                },
                                "type": "panel",
                                "panel_type": "node_preview"
                            }
                        ]
                    }
                ]
            }
        });

        let view: View = serde_json::from_value(json).unwrap();

        assert_eq!(view.title, "Nodes");
        assert_eq!(view.icon, Icon::Nodes);
        assert_eq!(
            view.child,
            ViewChild::Group(PanelGroup::Row(vec![
                RowItem {
                    width: Size::Fill,
                    panel: ViewChild::Panel(Panel {
                        panel_type: PanelType::NodeGraph
                    })
                },
                RowItem {
                    width: Size::Pixels(302),
                    panel: ViewChild::Group(PanelGroup::Column(vec![
                        ColumnItem {
                            height: Size::Fill,
                            panel: ViewChild::Panel(Panel {
                                panel_type: PanelType::NodeProperties
                            })
                        },
                        ColumnItem {
                            height: Size::Pixels(180),
                            panel: ViewChild::Panel(Panel {
                                panel_type: PanelType::NodePreview
                            })
                        }
                    ]))
                }
            ]))
        );
    }

    #[test]
    fn test_sequencer_view_deserialization() {
        let json = serde_json::json!({
            "title": "Sequencer",
            "icon": "sequencer",
            "child": {
                "type": "group",
                "direction": "column",
                "children": [
                    {
                        "height": {
                            "flex": 1
                        },
                        "type": "panel",
                        "panel_type": "sequence_list",
                    },
                    {
                        "height": {
                            "flex": 1
                        },
                        "type": "panel",
                        "panel_type": "sequence_properties"
                    }
                ]
            }
        });

        let view: View = serde_json::from_value(json).unwrap();

        assert_eq!(view.title, "Sequencer");
        assert_eq!(view.icon, Icon::Sequencer);
        assert_eq!(
            view.child,
            ViewChild::Group(PanelGroup::Column(vec![
                ColumnItem {
                    height: Size::Flex(1),
                    panel: ViewChild::Panel(Panel {
                        panel_type: PanelType::SequenceList
                    })
                },
                ColumnItem {
                    height: Size::Flex(1),
                    panel: ViewChild::Panel(Panel {
                        panel_type: PanelType::SequenceProperties
                    })
                }
            ]))
        );
    }

    #[test]
    fn test_presets_view_deserialization() {
        let json = serde_json::json!({
            "title": "Presets",
            "icon": "presets",
            "child": {
                "type": "group",
                "direction": "column",
                "children": [
                    {
                        "height": {
                            "grid_items": 2
                        },
                        "type": "panel",
                        "panel_type": "group_list",
                    },
                    {
                        "height": {
                            "grid_items": 2
                        },
                        "type": "panel",
                        "panel_type": "dimmer_presets",
                    },
                    {
                        "height": {
                            "grid_items": 2
                        },
                        "type": "panel",
                        "panel_type": "shutter_presets",
                    },
                    {
                        "height": {
                            "grid_items": 2
                        },
                        "type": "panel",
                        "panel_type": "color_presets",
                    },
                    {
                        "height": {
                            "grid_items": 2
                        },
                        "type": "panel",
                        "panel_type": "position_presets",
                    }
                ]
            }
        });

        let view: View = serde_json::from_value(json).unwrap();

        assert_eq!(view.title, "Presets");
        assert_eq!(view.icon, Icon::Presets);
        assert_eq!(
            view.child,
            ViewChild::Group(PanelGroup::Column(vec![
                ColumnItem {
                    height: Size::GridItems(2.),
                    panel: ViewChild::Panel(Panel {
                        panel_type: PanelType::GroupList
                    })
                },
                ColumnItem {
                    height: Size::GridItems(2.),
                    panel: ViewChild::Panel(Panel {
                        panel_type: PanelType::DimmerPresets
                    })
                },
                ColumnItem {
                    height: Size::GridItems(2.),
                    panel: ViewChild::Panel(Panel {
                        panel_type: PanelType::ShutterPresets
                    })
                },
                ColumnItem {
                    height: Size::GridItems(2.),
                    panel: ViewChild::Panel(Panel {
                        panel_type: PanelType::ColorPresets
                    })
                },
                ColumnItem {
                    height: Size::GridItems(2.),
                    panel: ViewChild::Panel(Panel {
                        panel_type: PanelType::PositionPresets
                    })
                }
            ]))
        );
    }
}
