use std::sync::Arc;

use usvg::TreeParsing;
use vello::{Scene, SceneBuilder};

use crate::VectorData;

pub fn parse_svg(svg: &[u8]) -> anyhow::Result<VectorData> {
    let svg_tree = usvg::Tree::from_data(svg, &usvg::Options::default())?;
    let mut scene = Scene::new();
    let mut scene_builder = SceneBuilder::for_scene(&mut scene);
    vello_svg::render_tree_with(
        &mut scene_builder,
        &svg_tree,
        vello_svg::default_error_handler,
    )?;

    Ok(VectorData(Arc::new(scene)))
}
