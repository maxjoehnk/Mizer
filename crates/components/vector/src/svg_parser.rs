use std::sync::Arc;
use usvg::fontdb;
use vello_svg::usvg;

use crate::VectorData;
use vello::Scene;

pub fn parse_svg(svg: &[u8]) -> anyhow::Result<VectorData> {
    let mut fontdb = fontdb::Database::new();
    fontdb.load_system_fonts();
    let svg_tree = usvg::Tree::from_data(
        svg,
        &usvg::Options {
            fontdb: Arc::new(fontdb),
            ..Default::default()
        },
    )?;
    let mut scene = Scene::new();
    vello_svg::append_tree(&mut scene, &svg_tree);

    Ok(VectorData(Arc::new(scene)))
}
