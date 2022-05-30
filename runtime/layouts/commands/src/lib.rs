pub use add_layout::*;
pub use add_layout_control::*;
pub use delete_layout_control::*;
pub use move_layout_control::*;
pub use remove_layout::*;
pub use rename_layout::*;
pub use rename_layout_control::*;
pub use update_layout_control_decorations::*;

use mizer_layouts::{ControlConfig, Layout, LayoutStorage};

mod add_layout;
mod add_layout_control;
mod delete_layout_control;
mod move_layout_control;
mod remove_layout;
mod rename_layout;
mod rename_layout_control;
mod update_layout_control_decorations;

pub(crate) fn update_layout<Cb: FnOnce(&mut Layout) -> anyhow::Result<()>>(
    layout_storage: &LayoutStorage,
    layout_id: &str,
    update: Cb,
) -> anyhow::Result<()> {
    let mut layouts = layout_storage.read();
    let layout = get_layout(&mut layouts, layout_id)?;
    update(layout)?;
    layout_storage.set(layouts);

    Ok(())
}

pub(crate) fn get_layout<'a>(
    layouts: &'a mut Vec<Layout>,
    layout_id: &str,
) -> anyhow::Result<&'a mut Layout> {
    layouts
        .iter_mut()
        .find(|layout| layout.id == layout_id)
        .ok_or_else(|| anyhow::anyhow!("Layout {} does not exist", layout_id))
}

pub(crate) fn get_control<'a>(
    layouts: &'a mut Vec<Layout>,
    layout_id: &str,
    control_id: &str,
) -> anyhow::Result<&'a mut ControlConfig> {
    let layout = get_layout(layouts, layout_id)?;
    layout
        .controls
        .iter_mut()
        .find(|c| c.node == control_id)
        .ok_or_else(|| {
            anyhow::anyhow!(
                "Control {} does not exist in layout {}",
                control_id,
                layout_id
            )
        })
}
