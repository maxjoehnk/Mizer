use std::collections::HashMap;
use std::sync::atomic::AtomicBool;
use std::sync::Arc;

use dashmap::DashMap;
use pinboard::NonEmptyPinboard;

use mizer_clock::ClockSnapshot;
use mizer_layouts::Layout;
use mizer_node::{
    NodeDesigner, NodeLink, NodeMetadata, NodePath, NodeSetting, PipelineNode, PortId,
    PortMetadata,
};
use mizer_plan::Plan;
use mizer_status_bus::StatusBus;

use crate::LayoutsView;

#[derive(Clone)]
pub struct RuntimeAccess {
    pub nodes: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    pub designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    pub settings: Arc<NonEmptyPinboard<HashMap<NodePath, Vec<NodeSetting>>>>,
    pub metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>,
    pub ports: Arc<DashMap<NodePath, Vec<(PortId, PortMetadata)>>>,
    pub links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
    pub layouts: Arc<NonEmptyPinboard<Vec<Layout>>>,
    pub plans: Arc<NonEmptyPinboard<Vec<Plan>>>,
    // TODO: make broadcast
    pub clock_recv: flume::Receiver<ClockSnapshot>,
    pub clock_snapshot: Arc<NonEmptyPinboard<ClockSnapshot>>,
    pub layouts_view: LayoutsView,
    pub status_bus: StatusBus,
    pub read_node_settings: Arc<AtomicBool>,
}
