use mizer_clock::SystemClock;
pub use mizer_execution_planner::*;
pub use mizer_pipeline::NodePreviewRef;
pub use node_metadata::NodeMetadataRef;

pub use self::api::*;
pub use self::coordinator::CoordinatorRuntime;
pub use self::views::LayoutsView;

pub type DefaultRuntime = CoordinatorRuntime<SystemClock>;

mod api;
pub mod commands;
mod context;
mod coordinator;
mod debug_ui;
mod node_metadata;
pub mod pipeline_access;
mod processor;
mod views;
