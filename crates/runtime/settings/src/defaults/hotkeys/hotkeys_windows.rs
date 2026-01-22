use crate::hotkeys::*;

pub fn get_global_hotkey(hotkey: GlobalHotkey) -> &'static str {
    match hotkey {
        GlobalHotkey::LayoutView => "f1",
        GlobalHotkey::PlanView => "f2",
        GlobalHotkey::NodesView => "f3",
        GlobalHotkey::SequencerView => "f4",
        GlobalHotkey::ProgrammerView => "f5",
        GlobalHotkey::PresetsView => "f6",
        GlobalHotkey::EffectsView => "f7",
        GlobalHotkey::MediaView => "f8",
        GlobalHotkey::SurfacesView => "f9",
        GlobalHotkey::FixturePatchView => "f10",
        GlobalHotkey::DmxOutputView => "f11",
        GlobalHotkey::ConnectionsView => "f12",
        GlobalHotkey::SessionView => "",
        GlobalHotkey::HistoryView => "",
        GlobalHotkey::TimecodeView => "",
        GlobalHotkey::PreferencesView => "",
        GlobalHotkey::ProgrammerPane => "shift+p",
        GlobalHotkey::SelectionPane => "shift+s",
        GlobalHotkey::ConsolePane => "shift+c",
        GlobalHotkey::Undo => "ctrl+z",
        GlobalHotkey::Redo => "ctrl+shift+z",
        GlobalHotkey::Open => "ctrl+o",
        GlobalHotkey::Save => "ctrl+s",
        GlobalHotkey::SaveAs => "ctrl+shift+s",
    }
}

pub fn get_layout_hotkey(hotkey: LayoutHotkey) -> &'static str {
    match hotkey {
        LayoutHotkey::AddLayout => "alt+a",
    }
}

pub fn get_plan_hotkey(hotkey: PlanHotkey) -> &'static str {
    match hotkey {
        PlanHotkey::Store => "insert",
        PlanHotkey::Highlight => "home",
        PlanHotkey::Clear => "backspace",
    }
}

pub fn get_programmer_hotkey(hotkey: ProgrammerHotkey) -> &'static str {
    match hotkey {
        ProgrammerHotkey::SelectAll => "ctrl+a",
        ProgrammerHotkey::Clear => "backspace",
        ProgrammerHotkey::Store => "insert",
        ProgrammerHotkey::Highlight => "home",
        ProgrammerHotkey::AssignGroup => "ctrl+g",
        ProgrammerHotkey::Next => "next",
        ProgrammerHotkey::Prev => "prev",
        ProgrammerHotkey::Shuffle => "ctrl+r",
    }
}

pub fn get_patch_hotkey(hotkey: PatchHotkey) -> &'static str {
    match hotkey {
        PatchHotkey::AddFixture => "alt+a",
        PatchHotkey::SelectAll => "ctrl+a",
        PatchHotkey::Clear => "backspace",
        PatchHotkey::Delete => "delete",
        PatchHotkey::AssignGroup => "ctrl+g",
    }
}

pub fn get_nodes_hotkey(hotkey: NodeHotkey) -> &'static str {
    match hotkey {
        NodeHotkey::AddNode => "alt+a",
        NodeHotkey::DuplicateNode => "ctrl+d",
        NodeHotkey::GroupNodes => "ctrl+g",
        NodeHotkey::DeleteNode => "delete",
        NodeHotkey::RenameNode => "ctrl+r",
    }
}

pub fn get_sequencer_hotkey(hotkey: SequencerHotkey) -> &'static str {
    match hotkey {
        SequencerHotkey::AddSequence => "alt+a",
        SequencerHotkey::Delete => "delete",
        SequencerHotkey::Duplicate => "ctrl+d",
        SequencerHotkey::GoForward => "ctrl+g",
        SequencerHotkey::GoBackward => "ctrl+shift+g",
        SequencerHotkey::Stop => "alt+s",
    }
}

pub fn get_effects_hotkey(hotkey: EffectsHotkey) -> &'static str {
    match hotkey {
        EffectsHotkey::AddEffect => "alt+a",
        EffectsHotkey::Delete => "delete",
    }
}

pub fn get_media_hotkey(hotkey: MediaHotkey) -> &'static str {
    match hotkey {
        MediaHotkey::AddMedia => "alt+a",
        MediaHotkey::Delete => "delete",
    }
}
