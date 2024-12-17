use mizer_project_files::{HandlerContext, Project};
use test_case::test_case;

#[test_case("artnet"; "artnet")]
#[test_case("effects"; "effects")]
#[test_case("fixture"; "fixture")]
#[test_case("history"; "history")]
#[test_case("inputs"; "inputs")]
#[test_case("laser"; "laser")]
#[test_case("media"; "media")]
#[test_case("media_v2"; "media_v2")]
#[test_case("midi"; "midi")]
#[test_case("mqtt"; "mqtt")]
#[test_case("operations"; "operations")]
#[test_case("osc"; "osc")]
#[test_case("pixels"; "pixels")]
#[test_case("presets"; "presets")]
#[test_case("sacn"; "sacn")]
#[test_case("sequencer"; "sequencer")]
#[test_case("video"; "video")]
fn test_load_project(project: &str) {
    let path = format!(
        "{}/../../examples/{}.yml",
        env!("CARGO_MANIFEST_DIR"),
        project
    );
    
    let _ = HandlerContext::open(path).unwrap();
}
