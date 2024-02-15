use std::fmt;
use std::sync::Arc;

pub use self::module::VectorModule;
pub use self::renderer::VectorWgpuRenderer;
pub use self::svg_parser::parse_svg;

mod module;
mod renderer;
mod svg_parser;

#[derive(Clone)]
pub struct VectorData(Arc<vello::Scene>);

impl fmt::Debug for VectorData {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct(stringify!(VectorData)).finish()
    }
}

impl PartialEq for VectorData {
    fn eq(&self, other: &Self) -> bool {
        self.0.encoding().path_data == other.0.encoding().path_data
    }
}

impl Default for VectorData {
    fn default() -> Self {
        Self(Arc::new(vello::Scene::new()))
    }
}
