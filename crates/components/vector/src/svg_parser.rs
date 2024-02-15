use std::sync::Arc;

use usvg::TreeParsing;
use vello::Scene;

use crate::VectorData;

pub fn parse_svg(svg: &[u8]) -> anyhow::Result<VectorData> {
    let svg_tree = usvg::Tree::from_data(svg, &usvg::Options::default())?;
    let mut scene = Scene::new();
    vello_svg::render_tree_with(&mut scene, &svg_tree, vello_svg::default_error_handler)?;

    Ok(VectorData(Arc::new(scene)))
}
