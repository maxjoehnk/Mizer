use mizer_project_files::load_project_file;
use test_case::test_case;

#[test_case("pixels"; "pixels")]
#[test_case("video"; "video")]
#[test_case("artnet"; "artnet")]
#[test_case("sacn"; "sacn")]
fn test_load_project(project: &str) {
    let path = format!("{}/../examples/{}.yml", env!("CARGO_MANIFEST_DIR"), project);

    let _ = load_project_file(&path).unwrap();
}
