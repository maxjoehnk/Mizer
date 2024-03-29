use std::path::PathBuf;

use test_case::test_case;
use tracing::Level;

use mizer::{build_runtime, Flags};

#[test_case("artnet"; "artnet")]
#[test_case("audio"; "audio")]
#[test_case("demo"; "demo")]
#[test_case("effects"; "effects")]
#[test_case("fixture"; "fixture")]
#[test_case("history"; "history")]
#[test_case("inputs"; "inputs")]
#[test_case("laser"; "laser")]
#[test_case("media"; "media")]
#[test_case("midi"; "midi")]
#[test_case("mqtt"; "mqtt")]
#[test_case("operations"; "operations")]
#[test_case("osc"; "osc")]
#[test_case("pixels"; "pixels")]
#[test_case("plan"; "plan")]
#[test_case("plan_screen"; "plan_screen")]
#[test_case("presets"; "presets")]
#[test_case("sacn"; "sacn")]
#[test_case("sequencer"; "sequencer")]
#[test_case("timecode"; "timecode")]
#[test_case("video"; "video")]
fn test_build_project_pipeline(project: &str) {
    std::env::set_var("MIZER_IMPORT_PATH", "../../");
    let _ = tracing::subscriber::set_global_default(
        tracing_subscriber::fmt()
            .with_max_level(Level::TRACE)
            .with_test_writer()
            .finish(),
    );
    let runtime = tokio::runtime::Runtime::new().unwrap();
    let _guard = runtime.enter();
    let handle = runtime.handle().clone();
    let flags = Flags {
        join: false,
        generate_graph: false,
        file: Some(PathBuf::from(format!("../../examples/{}.yml", project))),
        headless: true,
        ..Default::default()
    };

    build_runtime(handle, flags).unwrap();
}
