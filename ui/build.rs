use std::path::Path;
use std::process::Command;
use flutter_tools::*;

fn main() {
    println!("cargo:rerun-if-changed=lib");
    println!("cargo:rerun-if-changed=pubspec.yaml");
    println!("cargo:rerun-if-changed=pubspec.lock");
    let flutter = Flutter::auto_detect().unwrap();
    let engine_version = flutter.engine_version().unwrap();
    let target = std::env::var("TARGET").unwrap();
    let out_dir = std::env::var("OUT_DIR").unwrap();
    let out_dir = Path::new(&out_dir);
    let build_dir = out_dir.parent().unwrap().parent().unwrap().parent().unwrap();
    let build = get_build();

    let engine = Engine::new(engine_version, target.clone(), build);

    println!("{:?}", flutter.root_path());

    fetch_engine(build_dir, &target, &engine);

    bundle(&flutter, build, build_dir);
    aot(&engine, out_dir);
}

fn get_build() -> Build {
    match std::env::var("PROFILE").unwrap().as_str() {
        "release" => Build::Release,
        "debug" => Build::Debug,
        _ => unimplemented!("no flutter engine build for the given profile"),
    }
}

fn fetch_engine(build_dir: &Path, target_triple: &str, engine: &Engine) {
    engine.download().unwrap();
    let engine_path = build_dir
        .join("deps")
        .join(engine.library_name());

    println!("engine_path: {:?}", engine_path);

    if !engine_path.exists() {
        std::fs::create_dir_all(engine_path.parent().unwrap()).expect("can't create out dir for engine");
        std::fs::copy(engine.library_path(), &engine_path).expect("can't copy prebuilt engine");

        if target_triple == "x86_64-pc-windows-msvc" {
            let from_dir = engine.library_path().parent().unwrap().to_owned();
            let to_dir = engine_path.parent().unwrap();
            for file in &[
                "flutter_engine.dll.lib",
                "flutter_engine.dll.exp",
                "flutter_engine.dll.pdb",
            ] {
                std::fs::copy(from_dir.join(file), to_dir.join(file)).expect("can't copy prebuilt engine files");
            }
        }
    }
}

fn aot(engine: &Engine, build_dir: &Path) {
    let host_engine_dir = engine.engine_dir();
    let target_engine_dir = engine.engine_dir();
    let snapshot = build_dir.join("kernel_snapshot.dill");

    let status = Command::new(engine.dart().unwrap())
        .arg(
            host_engine_dir
                .join("gen")
                .join("frontend_server.dart.snapshot"),
        )
        .arg("--sdk-root")
        .arg(host_engine_dir.join("flutter_patched_sdk"))
        .arg("--target=flutter")
        .arg("--aot")
        .arg("--tfa")
        .arg("-Ddart.vm.product=true")
        .arg("--packages")
        .arg(".packages")
        .arg("--output-dill")
        .arg(&snapshot)
        .arg(Path::new("lib").join("main.dart"))
        .status()
        .expect("Success");

    if status.code() != Some(0) {
        panic!("Flutter aot build failed");
    }

    let gen_snapshot = [
        "gen_snapshot",
        "gen_snapshot_x64",
        "gen_snapshot_x86",
        "gen_snapshot_host_targeting_host",
        "gen_snapshot.exe",
    ]
        .iter()
        .map(|bin| target_engine_dir.join(bin))
        .find(|path| path.exists())
        .expect("gen snapshot not found");

    let snapshot_path = build_dir.join("app.so");
    println!("cargo:rustc-env=FLUTTER_AOT_SNAPSHOT={}", snapshot_path.display());
    let status = Command::new(gen_snapshot)
        // .arg("--causal_async_stacks")
        .arg("--deterministic")
        .arg("--snapshot_kind=app-aot-elf")
        .arg("--strip")
        .arg(format!("--elf={}", snapshot_path.display()))
        .arg(&snapshot)
        .status()
        .expect("Success");

    if status.code() != Some(0) {
        panic!("Flutter aot snapshot build failed");
    }
}

pub fn bundle(flutter: &Flutter, build: Build, build_dir: &Path) {
    let flag = match build {
        Build::Debug => "--debug",
        Build::Release => "--release",
        Build::Profile => "--profile",
    };
    let assets_dir = build_dir.join("flutter_assets");
    println!("cargo:rustc-env=FLUTTER_ASSET_DIR={}", assets_dir.display());
    let status = Command::new(flutter.root_path().join("bin").join("flutter"))
        .arg("build")
        .arg("bundle")
        .arg(flag)
        .arg("--track-widget-creation")
        .arg("--asset-dir")
        .arg(assets_dir)
        .arg("--depfile")
        .arg(build_dir.join("snapshot_blob.bin.d"))
        .arg("--target")
        .arg("lib/main.dart")
        .status()
        .expect("flutter build bundle");
    if status.code() != Some(0) {
        panic!("Flutter bundle bundle failed");
    }
}
