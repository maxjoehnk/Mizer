use grpc::{ServerHandlerContext, ServerRequestSingle, ServerResponseUnarySink};

use mizer_runtime::RuntimeApi;

use crate::protos::{ControlPosition, GetLayoutsRequest, Layout, LayoutControl, Layouts, LayoutsApi, ControlSize};
use protobuf::SingularPtrField;

pub struct LayoutsApiImpl {
    runtime: RuntimeApi,
}

impl LayoutsApiImpl {
    pub fn new(runtime: RuntimeApi) -> Self {
        Self { runtime }
    }
}

impl LayoutsApi for LayoutsApiImpl {
    fn get_layouts(
        &self,
        _: ServerHandlerContext,
        _: ServerRequestSingle<GetLayoutsRequest>,
        resp: ServerResponseUnarySink<Layouts>,
    ) -> grpc::Result<()> {
        let layouts = self
            .runtime
            .layouts()
            .into_iter()
            .map(Layout::from)
            .collect::<Vec<_>>();
        let mut result = Layouts::new();
        result.set_layouts(layouts.into());

        resp.finish(result)
    }
}

impl From<mizer_layouts::Layout> for Layout {
    fn from(layout: mizer_layouts::Layout) -> Self {
        Layout {
            id: layout.id,
            controls: layout
                .controls
                .into_iter()
                .map(LayoutControl::from)
                .collect(),
            ..Default::default()
        }
    }
}

impl From<mizer_layouts::ControlConfig> for LayoutControl {
    fn from(config: mizer_layouts::ControlConfig) -> Self {
        LayoutControl {
            node: config.node.0,
            position: SingularPtrField::some(config.position.into()),
            size: SingularPtrField::some(config.size.into()),
            ..Default::default()
        }
    }
}

impl From<mizer_layouts::ControlPosition> for ControlPosition {
    fn from(position: mizer_layouts::ControlPosition) -> Self {
        ControlPosition {
            x: position.x,
            y: position.y,
            ..Default::default()
        }
    }
}

impl From<mizer_layouts::ControlSize> for ControlSize {
    fn from(size: mizer_layouts::ControlSize) -> Self {
        ControlSize {
            width: size.width,
            height: size.height,
            ..Default::default()
        }
    }
}
