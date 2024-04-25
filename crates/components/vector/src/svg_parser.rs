use std::sync::Arc;
use usvg::fontdb;

use vello::Scene;

use crate::VectorData;

pub fn parse_svg(svg: &[u8]) -> anyhow::Result<VectorData> {
    let mut fontdb = fontdb::Database::new();
    fontdb.load_system_fonts();
    let svg_tree = usvg::Tree::from_data(svg, &usvg::Options::default(), &fontdb)?;
    let mut scene = Scene::new();
    vello_svg::render_tree_with(&mut scene, &svg_tree, &usvg::Transform::default(), &mut vello_svg::default_error_handler)?;

    Ok(VectorData(Arc::new(scene)))
}
