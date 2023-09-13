pub use mizer_debug_ui::*;

#[cfg(not(feature = "active"))]
pub type DebugUiImpl = mizer_debug_ui::noop::NoopDebugUi;

#[cfg(feature = "active")]
pub type DebugUiImpl = mizer_debug_ui_egui::EguiDebugUi;
