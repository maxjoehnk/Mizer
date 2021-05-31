use mizer_project_files::Project;
use test_case::test_case;

#[test_case("artnet"; "artnet")]
#[test_case("fixture"; "fixture")]
#[test_case("laser"; "laser")]
#[test_case("pixels"; "pixels")]
#[test_case("sacn"; "sacn")]
#[test_case("sequence"; "sequence")]
#[test_case("video"; "video")]
#[test_case("inputs"; "inputs")]
#[test_case("osc"; "osc")]
#[test_case("midi"; "midi")]
fn test_load_project(project: &str) {
    let path = format!(
        "{}/../../examples/{}.yml",
        env!("CARGO_MANIFEST_DIR"),
        project
    );

    let _ = Project::load_file(&path).unwrap();
}
