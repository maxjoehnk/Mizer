use fs_extra::dir::CopyOptions;
use std::fs::File;
use std::path::Path;
use temp_dir::TempDir;
use zip::ZipArchive;

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    let target_path = Path::new(".fixtures");

    if target_path.exists() {
        return;
    }

    std::fs::create_dir_all(&target_path).unwrap();

    let download_dir = TempDir::new().unwrap();

    let mut archive =
        ureq::get("https://github.com/mcallegari/qlcplus/archive/refs/heads/master.zip")
            .call()
            .unwrap()
            .into_reader();

    let archive_file_path = download_dir.path().join("master.zip");
    let mut archive_file = File::create(&archive_file_path).unwrap();
    std::io::copy(&mut archive, &mut archive_file).unwrap();

    let mut archive_file = File::open(&archive_file_path).unwrap();

    let mut archive = ZipArchive::new(&mut archive_file).unwrap();

    archive.extract(download_dir.path()).unwrap();

    let fixtures_folder_path = download_dir
        .path()
        .join("qlcplus-master")
        .join("resources")
        .join("fixtures");
    let fixture_folders = std::fs::read_dir(fixtures_folder_path).unwrap();
    let fixture_folders = fixture_folders
        .filter_map(|folder| folder.ok())
        .filter(|entry| {
            entry
                .metadata()
                .ok()
                .map(|metadata| metadata.is_dir())
                .unwrap_or_default()
        })
        .map(|entry| entry.path())
        .collect::<Vec<_>>();

    fs_extra::copy_items(
        &fixture_folders,
        &target_path,
        &CopyOptions {
            skip_exist: true,
            overwrite: false,
            copy_inside: true,
            depth: 2,
            ..Default::default()
        },
    )
    .unwrap();
}
