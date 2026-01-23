use crate::Languages;

#[cfg(target_os = "windows")]
pub fn get_system_language() -> Option<Languages> {
    use windows_sys::Win32::Globalization::*;

    let mut locale_name: [u16; 85] = [0; 85];
    let locale = unsafe {
        let result = GetUserDefaultLocaleName(locale_name.as_mut_ptr(), locale_name.len() as i32);

        if result == 0 {
            return None;
        }

        if let Some(null_pos) = locale_name.iter().position(|&c| c == 0) {
            let slice = &locale_name[..null_pos];
            String::from_utf16(slice).ok()
        } else {
            String::from_utf16(&locale_name).ok()
        }
    }?;

    let locale = locale.replace("_", "-");

    Some(locale.into())
}

#[cfg(any(target_os = "linux", target_os = "macos"))]
pub fn get_system_language() -> Option<Languages> {
    let locale = std::env::var("LANG")
        .or_else(|_| std::env::var("LC_ALL"))
        .or_else(|_e| std::env::var("LC_CTYPE"))
        .or_else(|_e| std::env::var("LANGUAGE"))
        .ok()?;

    let locale = locale.split('.').next()?.replace("_", "-");

    Some(locale.into())
}

impl From<String> for Languages {
    fn from(value: String) -> Self {
        match &value[..2] {
            "de" => Self::German,
            _ => Self::English,
        }
    }
}
