use std::path::{Path, PathBuf};

use mizer_api::handlers::Handlers;
use crate::plugin::MizerPlugin;

mod plugin;

pub fn run(handlers: Handlers) {
    let mut args = Vec::with_capacity(3);

    if let Ok(observatory_port) = std::env::var("DART_OBSERVATORY_PORT") {
        args.push("--disable-service-auth-codes".to_string());
        args.push(format!("--observatory-port={}", observatory_port));
    }

    if let Ok(snapshot) = std::env::var("FLUTTER_AOT_SNAPSHOT") {
        if Path::new(&snapshot).exists() {
            args.push(format!("--aot-shared-library-name={}", snapshot));
        }
    }

    let mut desktop = flutter_glfw::init().unwrap();
    let assets_path = PathBuf::from(env!("FLUTTER_ASSET_DIR"));
    let window = desktop.create_window(&flutter_glfw::window::WindowArgs {
        height: 200,
        width: 200,
        mode: flutter_glfw::window::WindowMode::Windowed,
        title: "Mizer"
    }, assets_path, Vec::default()).unwrap();
    window.add_plugin(MizerPlugin::new(handlers));
    window.run(None, None).unwrap();
}
