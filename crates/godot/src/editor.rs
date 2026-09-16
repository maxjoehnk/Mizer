use libgodot::*;
use mizer_godot_ui as _;

fn main() -> anyhow::Result<()> {
    let mut runtime = GodotRuntimeHandle::new(&GodotOptions::new("crates/godot").with_rendering_driver("vulkan").with_editor()).map_err(|_| anyhow::anyhow!("Failed to create Godot runtime"))?;

    runtime.start();

    loop {
        if runtime.iteration() {
            break;
        }
    }

    Ok(())
}
