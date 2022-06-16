use nativeshell_build::{
    AppBundleOptions, AsPath, BuildResult, Flutter, FlutterOptions, MacOSBundle,
};

fn build_flutter() -> BuildResult<()> {
    Flutter::build(FlutterOptions::default())?;

    if cfg!(target_os = "macos") {
        let options = AppBundleOptions {
            bundle_name: "Mizer.app".into(),
            bundle_display_name: "Mizer".into(),
            icon_file: "icons/AppIcon.icns".into(),
            executable_path: "mizer".into(),
            bundle_identifier: "live.mizer".into(),
            ..Default::default()
        };
        let resources = MacOSBundle::build(options)?;
        resources.mkdir("icons")?;
        resources.link("resources/mac_icon.icns", "icons/AppIcon.icns")?;
    }

    Ok(())
}

fn main() {
    if let Err(error) = build_flutter() {
        panic!("\n** Build failed with error **\n\n{}", error);
    }
}
