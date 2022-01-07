fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    std::fs::create_dir_all(".fixtures").unwrap();

    let mut fixtures = ureq::get("https://open-fixture-library.org/download.aglight")
        .call()
        .unwrap()
        .into_reader();

    let mut file = std::fs::File::create(".fixtures/fixtures.json").unwrap();

    std::io::copy(&mut fixtures, &mut file).unwrap();
}
