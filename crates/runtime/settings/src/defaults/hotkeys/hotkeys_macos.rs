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
        GlobalHotkey::Undo => "cmd+z",
        GlobalHotkey::Redo => "cmd+shift+z",
        GlobalHotkey::Open => "cmd+o",
        GlobalHotkey::Save => "cmd+s",
        GlobalHotkey::SaveAs => "cmd+shift+s",
    }
}

pub fn get_layout_hotkey(hotkey: LayoutHotkey) -> &'static str {
    match hotkey {
        LayoutHotkey::AddLayout => "alt+a",
    }
}

pub fn get_plan_hotkey(hotkey: PlanHotkey) -> &'static str {
    match hotkey {
        PlanHotkey::Store => "cmd+r",
        PlanHotkey::Highlight => "cmd+h",
        PlanHotkey::Clear => "backspace",
    }
}

pub fn get_programmer_hotkey(hotkey: ProgrammerHotkey) -> &'static str {
    match hotkey {
        ProgrammerHotkey::SelectAll => "cmd+a",
        ProgrammerHotkey::Clear => "backspace",
        ProgrammerHotkey::Store => "cmd+r",
        ProgrammerHotkey::Highlight => "cmd+h",
        ProgrammerHotkey::AssignGroup => "cmd+g",
        ProgrammerHotkey::Next => "next",
        ProgrammerHotkey::Prev => "prev",
        ProgrammerHotkey::Shuffle => "cmd+shift+r",
    }
}

pub fn get_patch_hotkey(hotkey: PatchHotkey) -> &'static str {
    match hotkey {
        PatchHotkey::AddFixture => "alt+a",
        PatchHotkey::SelectAll => "cmd+a",
        PatchHotkey::Clear => "backspace",
        PatchHotkey::Delete => "cmd+backspace",
        PatchHotkey::AssignGroup => "cmd+g",
    }
}

pub fn get_nodes_hotkey(hotkey: NodeHotkey) -> &'static str {
    match hotkey {
        NodeHotkey::AddNode => "alt+a",
        NodeHotkey::DuplicateNode => "cmd+d",
        NodeHotkey::GroupNodes => "cmd+g",
        NodeHotkey::DeleteNode => "cmd+backspace",
        NodeHotkey::RenameNode => "cmd+r",
    }
}

pub fn get_sequencer_hotkey(hotkey: SequencerHotkey) -> &'static str {
    match hotkey {
        SequencerHotkey::AddSequence => "alt+a",
        SequencerHotkey::Delete => "cmd+backspace",
        SequencerHotkey::Duplicate => "cmd+d",
        SequencerHotkey::GoForward => "cmd+g",
        SequencerHotkey::GoBackward => "cmd+shift+g",
        SequencerHotkey::Stop => "alt+s",
    }
}

pub fn get_effects_hotkey(hotkey: EffectsHotkey) -> &'static str {
    match hotkey {
        EffectsHotkey::AddEffect => "alt+a",
        EffectsHotkey::Delete => "cmd+backspace",
    }
}

pub fn get_media_hotkey(hotkey: MediaHotkey) -> &'static str {
    match hotkey {
        MediaHotkey::AddMedia => "alt+a",
        MediaHotkey::Delete => "cmd+backspace",
    }
}
