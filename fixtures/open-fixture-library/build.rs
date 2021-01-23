use std::process::Command;

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    // TODO: replace wget with rust native download
    Command::new("wget")
        .args(&[
            "https://open-fixture-library.org/download.aglight",
            "-O",
            ".fixtures.json",
        ])
        .output()
        .expect("failed to download fixture library");
}
