use std::collections::HashMap;
use std::hash::Hash;
use enum_iterator::Sequence;
use facet::Facet;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize, Facet)]
pub struct Hotkeys {
    pub global: HotkeyGroup<GlobalHotkey>,
    pub layouts: HotkeyGroup<LayoutHotkey>,
    pub plan: HotkeyGroup<PlanHotkey>,
    pub programmer: HotkeyGroup<ProgrammerHotkey>,
    pub patch: HotkeyGroup<PatchHotkey>,
    pub nodes: HotkeyGroup<NodeHotkey>,
    pub sequencer: HotkeyGroup<SequencerHotkey>,
    pub effects: HotkeyGroup<EffectsHotkey>,
    pub media: HotkeyGroup<MediaHotkey>,
}

pub type HotkeyGroup<T> = HashMap<T, String>;

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum GlobalHotkey {
    LayoutView,
    PlanView,
    NodesView,
    SequencerView,
    ProgrammerView,
    PresetsView,
    EffectsView,
    MediaView,
    SurfacesView,
    FixturePatchView,
    DmxOutputView,
    ConnectionsView,
    SessionView,
    HistoryView,
    TimecodeView,
    PreferencesView,
    ProgrammerPane,
    SelectionPane,
    ConsolePane,
    Undo,
    Redo,
    Open,
    Save,
    SaveAs,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum LayoutHotkey {
    AddLayout,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum PlanHotkey {
    Store,
    Highlight,
    Clear,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum ProgrammerHotkey {
    SelectAll,
    Clear,
    Store,
    Highlight,
    AssignGroup,
    Next,
    Prev,
    Shuffle
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum NodeHotkey {
    AddNode,
    DuplicateNode,
    GroupNodes,
    DeleteNode,
    RenameNode
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum PatchHotkey {
    AddFixture,
    SelectAll,
    Clear,
    Delete,
    AssignGroup
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum SequencerHotkey {
    AddSequence,
    Delete,
    Duplicate,
    GoForward,
    GoBackward,
    Stop
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum EffectsHotkey {
    AddEffect,
    Delete
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq, Hash, Sequence, Facet)]
#[repr(C)]
#[facet(rename_all = "snake_case")]
#[serde(rename_all = "snake_case")]
pub enum MediaHotkey {
    AddMedia,
    Delete
}
