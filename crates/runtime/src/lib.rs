use mizer_clock::SystemClock;

pub use self::api::*;
pub use self::coordinator::CoordinatorRuntime;
pub use self::views::LayoutsView;
pub use mizer_execution_planner::*;
pub use node_metadata::NodeMetadataRef;

pub type DefaultRuntime = CoordinatorRuntime<SystemClock>;

mod api;
pub mod commands;
mod coordinator;
#[cfg(feature = "debug-ui")]
mod debug_ui;
mod node_metadata;
pub mod pipeline_access;
mod processor;
mod views;
