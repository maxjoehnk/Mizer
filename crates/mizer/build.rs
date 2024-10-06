fn main() {
    #[cfg(target_os = "windows")]
    add_resources_to_executable();
}

#[cfg(target_os = "windows")]
fn add_resources_to_executable() {
    convert_icon();

    let mut res = winresource::WindowsResource::new();
    res.set_language(winapi::um::winnt::MAKELANGID(
        winapi::um::winnt::LANG_ENGLISH,
        winapi::um::winnt::SUBLANG_ENGLISH_US,
    ));
    res.set_icon("icon.ico");
    res.compile().unwrap();
}

#[cfg(target_os = "windows")]
fn convert_icon() {
    let png_icon = std::fs::File::open("../../assets/icon@512.png").unwrap();
    let png_image = ico::IconImage::read_png(png_icon).unwrap();

    let mut icon = ico::IconDir::new(ico::ResourceType::Icon);
    icon.add_entry(ico::IconDirEntry::encode(&png_image).unwrap());

    let ico_file = std::fs::File::create("icon.ico").unwrap();
    icon.write(ico_file).unwrap();
}
