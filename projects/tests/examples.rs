use mizer_project_files::load_project;

#[test]
fn load_pixels() {
    let _ = load_project(include_str!("../../examples/pixels.yml")).unwrap();
}

#[test]
fn load_video() {
    let _ = load_project(include_str!("../../examples/video.yml")).unwrap();
}

#[test]
fn load_artnet() {
    let _ = load_project(include_str!("../../examples/artnet.yml")).unwrap();
}
