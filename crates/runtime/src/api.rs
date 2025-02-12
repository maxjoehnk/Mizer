use std::sync::atomic::AtomicBool;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_clock::ClockSnapshot;
use mizer_layouts::Layout;
use mizer_node::NodeCommentArea;
use mizer_plan::Plan;
use mizer_status_bus::StatusBus;

use crate::LayoutsView;

#[derive(Clone)]
pub struct RuntimeAccess {
    pub layouts: Arc<NonEmptyPinboard<Vec<Layout>>>,
    pub plans: Arc<NonEmptyPinboard<Vec<Plan>>>,
    // TODO: make broadcast
    pub clock_recv: flume::Receiver<ClockSnapshot>,
    pub clock_snapshot: Arc<NonEmptyPinboard<ClockSnapshot>>,
    pub layouts_view: LayoutsView,
    pub status_bus: StatusBus,
    pub read_node_settings: Arc<AtomicBool>,
}
