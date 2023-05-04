pub use handle::{DebugUiDrawHandle, TextureMap};

#[cfg(feature = "compile")]
pub use egui_impl::DebugUi;

#[cfg(feature = "compile")]
mod egui_impl;
mod handle;
