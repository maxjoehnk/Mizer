use fs_extra::dir::CopyOptions;
use std::fs::File;
use std::path::{Path, PathBuf};
use temp_dir::TempDir;
use zip::ZipArchive;

fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    let target_path = Path::new(".fixtures");
    if target_path.exists() {
        return;
    }
    std::fs::create_dir_all(target_path).unwrap();

    let download_dir = TempDir::new().unwrap();

    let archive_file_path = download(download_dir.path());
    extract_source(download_dir.path(), &archive_file_path);

    let resources_folder_path = get_resources_dir(download_dir.path());

    copy_resources(target_path, &resources_folder_path);
}

fn download(download_dir: &Path) -> PathBuf {
    let mut archive =
        ureq::get("https://github.com/mcallegari/qlcplus/archive/refs/heads/master.zip")
            .call()
            .unwrap()
            .into_reader();
    let archive_file_path = download_dir.join("master.zip");
    let mut archive_file = File::create(&archive_file_path).unwrap();
    std::io::copy(&mut archive, &mut archive_file).unwrap();
    archive_file_path
}

fn extract_source(download_dir: &Path, archive_file_path: &Path) {
    let mut archive_file = File::open(archive_file_path).unwrap();

    let mut archive = ZipArchive::new(&mut archive_file).unwrap();

    archive.extract(download_dir).unwrap();
}

fn copy_resources(target_path: &Path, resources_folder_path: &Path) {
    fs_extra::copy_items(
        &[
            resources_folder_path.join("fixtures"),
            resources_folder_path.join("gobos"),
        ],
        target_path,
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

fn get_resources_dir(download_dir: &Path) -> PathBuf {
    download_dir.join("qlcplus-master").join("resources")
}
