use std::path::PathBuf;
use std::sync::Arc;

use rhai::{Array, Engine};

use crate::profile::{
    Control, ControlBuilder, ControlStep, ControlStepVariant, Group, Page, StepsBuilder,
};

pub fn get_pages(script: impl Into<PathBuf>) -> anyhow::Result<Vec<Page>> {
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
        .register_fn("add", |page: &mut Page, cb: ControlBuilder| {
            page.add_control(cb.build())
        })
        .register_fn("+=", |page: &mut Page, cb: ControlBuilder| {
            page.add_control(cb.build())
        })
        .register_type::<Group>()
        .register_fn("create_group", Group::new)
        .register_fn("add", Group::add_control)
        .register_fn("+=", Group::add_control)
        .register_fn("add", |group: &mut Group, cb: ControlBuilder| {
            group.add_control(cb.build())
        })
        .register_fn("+=", |group: &mut Group, cb: ControlBuilder| {
            group.add_control(cb.build())
        })
        .register_type::<Control>()
        .register_fn("control", Control::new)
        .register_fn("id", Control::id)
        .register_fn("input", Control::input)
        .register_fn("output", Control::output)
        .register_type::<ControlBuilder>()
        .register_fn("note", |c: ControlBuilder, note: i64| c.note(note as u8))
        .register_fn("cc", |c: ControlBuilder, note: i64| c.cc(note as u8))
        .register_fn("rgb", ControlBuilder::rgb)
        .register_fn("channel", |c: ControlBuilder, channel: i64| {
            c.channel(channel as u8)
        })
        .register_fn("range", |c: ControlBuilder, from: i64, to: i64| {
            c.range(from as u8, to as u8)
        })
        .register_fn("output", |c: ControlBuilder| c.build().output())
        .register_fn("input", |c: ControlBuilder| c.build().input())
        .register_fn(
            "step",
            |mut c: ControlBuilder, value: i64, label: String| {
                c.steps.push(ControlStep::Single(ControlStepVariant {
                    value: value as u8,
                    label: Arc::new(label),
                }));
                c
            },
        )
        .register_fn(
            "steps",
            |mut c: ControlBuilder, label: String, builder: StepsBuilder| {
                c.steps.push(ControlStep::Group {
                    label: Arc::new(label),
                    steps: builder.build(),
                });
                c
            },
        )
        .register_type::<StepsBuilder>()
        .register_fn("create_steps", StepsBuilder::new)
        .register_fn("step", |c: &mut StepsBuilder, value: i64, label: String| {
            c.add(ControlStepVariant {
                value: value as u8,
                label: Arc::new(label),
            })
        });

    let ast = engine.compile_file(script.into())?;
    let pages: Array = engine.eval_ast(&ast)?;
    let pages = pages.into_iter().map(|page| page.cast()).collect();

    Ok(pages)
}
