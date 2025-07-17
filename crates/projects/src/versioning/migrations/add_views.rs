use indexmap::IndexMap;
use serde::{Deserialize, Serialize};
use serde_json::json;
use serde_yaml::Value;

use crate::versioning::migrations::ProjectFileMigration;

#[derive(Clone, Copy)]
pub struct AddViews;

impl ProjectFileMigration for AddViews {
    const VERSION: usize = 7;

    fn migrate(&self, project_file: &mut String) -> anyhow::Result<()> {
        profiling::scope!("AddViews::migrate");
        let mut project: ProjectConfig = serde_yaml::from_str(project_file)?;
        project.add_views();

        *project_file = serde_yaml::to_string(&project)?;

        Ok(())
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct ProjectConfig {
    #[serde(default)]
    views: Vec<serde_json::Value>,
    #[serde(flatten)]
    other: IndexMap<String, Value>,
}

impl ProjectConfig {
    fn add_views(&mut self) {
        self.views.push(json!({
            "title": "Layout",
            "icon": "layout",
            "child": {
                "type": "panel",
                "panel_type": "layout"
            }
        }));
        self.views.push(json!({
            "title": "2D Plan",
            "icon": "plan",
            "child": {
                "type": "panel",
                "panel_type": "plan"
            }
        }));
        self.views.push(json!({
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
        }));
        self.views.push(json!({
            "title": "Sequencer",
            "icon": "sequencer",
            "child": {
                "type": "group",
                "direction": "column",
                "children": [
                    {
                        "height": "fill",
                        "type": "panel",
                        "panel_type": "sequence_list",
                    },
                    {
                        "height": "fill",
                        "type": "panel",
                        "panel_type": "sequence_properties",
                    }
                ]
            }
        }));
        self.views.push(json!({
            "title": "Fixtures",
            "icon": "fixtures",
            "child": {
                "type": "panel",
                "panel_type": "fixture_list"
            }
        }));
        self.views.push(json!({
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
        }));
        self.views.push(json!({
            "title": "Effects",
            "icon": "effects",
            "child": {
                "type": "group",
                "direction": "column",
                "children": [
                {
                    "height": "fill",
                    "type": "panel",
                    "panel_type": "effect_list",
                },
                {
                    "height": {
                    "grid_items": 5
                },
                    "type": "group",
                    "direction": "row",
                    "children": [
                    {
                        "width": {
                            "grid_items": 5,
                        },
                        "type": "panel",
                        "panel_type": "effect_movement_preview"
                    },
                    {
                        "width": "fill",
                        "type": "panel",
                        "panel_type": "effect_frames"
                    }
                    ]
                }
                ]
            }
        }));
        self.views.push(json!({
            "title": "Media",
            "icon": "media",
            "child": {
                "type": "group",
                "direction": "row",
                "children": [
                    {
                        "width": { "flex": 2 },
                        "type": "panel",
                        "panel_type": "media_list",
                    },
                    {
                        "width": { "flex": 1 },
                        "type": "group",
                        "direction": "column",
                        "children": [
                            {
                                "height": { "flex": 1 },
                                "type": "panel",
                                "panel_type": "media_preview"
                            },
                            {
                                "height": { "flex": 2 },
                                "type": "panel",
                                "panel_type": "media_metadata"
                            },
                        ]
                    }
                ]
            }
        }));
        self.views.push(json!({
            "title": "Surfaces",
            "icon": "surfaces",
            "child": {
                "type": "group",
                "direction": "row",
                "children": [
                    {
                        "type": "group",
                        "direction": "column",
                        "width": {
                            "flex": 1
                        },
                        "children": [
                            {
                                "height": "fill",
                                "type": "panel",
                                "panel_type": "surface_list"
                            },
                            {
                                "height": "fill",
                                "type": "panel",
                                "panel_type": "surface_sections"
                            }
                        ]
                    },
                    {
                        "type": "panel",
                        "panel_type": "surface_editor",
                        "width": {
                            "flex": 4
                        },
                    },
                    {
                        "type": "panel",
                        "panel_type": "surface_properties",
                        "width": {
                            "flex": 1
                        },
                    }
                ]
            }
        }));
        self.views.push(json!({
            "title": "Timecode",
            "icon": "timecode",
            "child": {
                "type": "group",
                "direction": "column",
                "children": [
                    {
                        "height": {
                            "flex": 1
                        },
                        "type": "panel",
                        "panel_type": "timecode_list",
                    },
                    {
                        "height": {
                            "flex": 2
                        },
                        "type": "panel",
                        "panel_type": "timecode_editor",
                    }
                ]
            }
        }));
    }
}
