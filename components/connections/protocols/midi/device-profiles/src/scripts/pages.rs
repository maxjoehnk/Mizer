use crate::profile::{Control, Page, Group};
use crate::scripts::ScriptError;
use rhai::{Array, Engine};
use std::path::PathBuf;

pub fn get_pages(script: impl Into<PathBuf>) -> Result<Vec<Page>, ScriptError> {
    let mut engine = Engine::new();

    engine
        .set_max_expr_depths(0, 0)
        .set_max_operations(0)
        .register_type::<Page>()
        .register_fn("create_page", Page::new)
        .register_fn("add", Page::add_group)
        .register_fn("+=", Page::add_group)
        .register_fn("add", Page::add_control)
        .register_fn("+=", Page::add_control)
        .register_type::<Group>()
        .register_fn("create_group", Group::new)
        .register_fn("add", Group::add_control)
        .register_fn("+=", Group::add_control)
        .register_type::<Control>()
        .register_fn("note", |name, note: i64| Control::note(name, note as u8))
        .register_fn("cc", |name, note: i64| Control::cc(name, note as u8))
        .register_fn("channel", |c: Control, channel: i64| {
            Control::channel(c, channel as u8)
        })
        .register_fn("range", |c: Control, from: i64, to: i64| {
            Control::range(c, from as u8, to as u8)
        })
        .register_fn("output_range", |c: Control, from: i64, to: i64| {
            Control::output_range(c, from as u8, to as u8)
        })
        .register_fn("id", Control::id)
        .register_fn("output", Control::output);

    let ast = engine.compile_file(script.into())?;
    let pages: Array = engine.eval_ast(&ast)?;
    let pages = pages.into_iter().map(|page| page.cast()).collect();

    Ok(pages)
}
