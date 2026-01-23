use std::hash::Hash;
use enum_iterator::{all, Sequence};
#[cfg(target_os = "linux")]
pub use hotkeys_linux::*;

#[cfg(target_os = "macos")]
pub use hotkeys_macos::*;

#[cfg(target_os = "windows")]
pub use hotkeys_windows::*;
use crate::HotkeyGroup;
use crate::hotkeys::Hotkeys;

mod hotkeys_linux;
mod hotkeys_windows;
mod hotkeys_macos;

pub fn get_hotkeys() -> Hotkeys {
    Hotkeys {
        global: get_all_hotkeys(get_global_hotkey),
        layouts: get_all_hotkeys(get_layout_hotkey),
        plan: get_all_hotkeys(get_plan_hotkey),
        programmer: get_all_hotkeys(get_programmer_hotkey),
        patch: get_all_hotkeys(get_patch_hotkey),
        nodes: get_all_hotkeys(get_nodes_hotkey),
        sequencer: get_all_hotkeys(get_sequencer_hotkey),
        effects: get_all_hotkeys(get_effects_hotkey),
        media: get_all_hotkeys(get_media_hotkey),
    }
}

fn get_all_hotkeys<T: Copy + Sequence + Hash + PartialEq + Eq, M: Fn(T) -> &'static str>(
    map: M,
) -> HotkeyGroup<T> {
    all::<T>()
        .map(|hotkey| (hotkey, map(hotkey).to_string()))
        .collect()
}
