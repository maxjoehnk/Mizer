fn main() {
    #[cfg(target_os = "windows")]
    add_resources_to_executable();
}

#[cfg(target_os = "windows")]
fn add_resources_to_executable() {
    let mut res = winresource::WindowsResource::new();
    res.set_language(winapi::um::winnt::MAKELANGID(
        winapi::um::winnt::LANG_ENGLISH,
        winapi::um::winnt::SUBLANG_ENGLISH_US,
    ));
    res.set_icon("icon.ico");
    res.compile().unwrap();
}
