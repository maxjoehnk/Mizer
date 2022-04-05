use cached::proc_macro::cached;
use cached::UnboundCache;
use mizer_fixtures::definition::GoboImage;
use std::fs::File;
use std::io::Read;
use std::path::Path;

pub struct ResourceReader<'a>(&'a Path);

impl<'a> ResourceReader<'a> {
    pub fn new(path: &'a Path) -> Self {
        Self(path)
    }

    pub fn read_gobo(&self, filename: &str) -> Option<GoboImage> {
        let path = self.0.join("gobos").join(filename);

        read_gobo_image(&path, filename)
    }
}

// TODO: this should probably be bounded.
#[cached(
    type = "UnboundCache<String, Option<GoboImage>>",
    create = r#"{ UnboundCache::new() }"#,
    convert = r#"{ filename.to_string() }"#
)]
fn read_gobo_image(path: &Path, filename: &str) -> Option<GoboImage> {
    if !path.exists() {
        return None;
    }
    if filename.ends_with(".svg") {
        read_svg(&path).ok()
    } else {
        read_raster(&path).ok()
    }
}

fn read_svg(path: &Path) -> anyhow::Result<GoboImage> {
    let mut buffer = String::new();
    let mut file = File::open(path)?;
    file.read_to_string(&mut buffer)?;

    Ok(GoboImage::Svg(buffer))
}

fn read_raster(path: &Path) -> anyhow::Result<GoboImage> {
    let mut buffer = Vec::new();
    let mut file = File::open(path)?;
    file.read_to_end(&mut buffer)?;

    Ok(GoboImage::Raster(Box::new(buffer)))
}
