use std::collections::HashMap;
use std::sync::atomic::AtomicBool;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use mizer_clock::ClockSnapshot;
use mizer_layouts::Layout;
use mizer_message_bus::MessageBus;
use mizer_node::{NodePath, NodeSetting};
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
    pub read_node_metadata: Arc<AtomicBool>,
    pub read_node_settings: Arc<NonEmptyPinboard<Vec<NodePath>>>,
    pub node_settings_bus: MessageBus<HashMap<NodePath, Vec<NodeSetting>>>
}
