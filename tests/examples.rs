use std::path::PathBuf;

use mizer::{build_runtime, Flags};
use test_case::test_case;

#[test_case("artnet"; "artnet")]
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
#[test_case("sequence"; "sequence")]
#[test_case("sequencer"; "sequencer")]
#[test_case("video"; "video")]
#[tokio::test]
async fn test_build_project_pipeline(project: &str) {
    let handle = tokio::runtime::Handle::current();
    let flags = Flags {
        join: false,
        generate_graph: false,
        file: Some(PathBuf::from(format!("examples/{}.yml", project))),
        disable_media_api: true,
        disable_grpc_api: true,
        headless: true,
        ..Default::default()
    };

    build_runtime(handle, flags).unwrap();
}
