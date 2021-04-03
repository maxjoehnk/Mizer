use std::process::Command;

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    std::fs::create_dir_all(".fixtures").unwrap();

    // TODO: replace wget with rust native download
    Command::new("wget")
        .args(&[
            "https://open-fixture-library.org/download.aglight",
            "-O",
            ".fixtures/fixtures.json",
        ])
        .output()
        .expect("failed to download fixture library");
}
