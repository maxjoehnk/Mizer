use nativeshell_build::{AppBundleOptions, BuildResult, Flutter, FlutterOptions, MacOSBundle};

fn build_flutter() -> BuildResult<()> {
    Flutter::build(FlutterOptions::default())?;

    if cfg!(target_os = "macos") {
        let options = AppBundleOptions {
            bundle_name: "Mizer.app".into(),
            bundle_display_name: "Mizer".into(),
            icon_file: "AppIcon.icns".into(),
            executable_path: "mizer".into(),
            bundle_identifier: "live.mizer".into(),
            info_plist_template: Some("resources/Info.plist".into()),
            ..Default::default()
        };
        let resources = MacOSBundle::build(options)?;
        resources.mkdir("icons")?;
    }

    Ok(())
}

fn main() {
    if let Err(error) = build_flutter() {
        panic!("\n** Build failed with error **\n\n{}", error);
    }
}
