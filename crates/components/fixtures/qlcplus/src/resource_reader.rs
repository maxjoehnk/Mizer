use cached::proc_macro::cached;
use cached::UnboundCache;
use std::fs::File;
use std::io::Read;
use std::path::Path;
use std::sync::Arc;
use mizer_fixtures::channels::FixtureImage;

pub struct ResourceReader<'a>(&'a Path);

impl<'a> ResourceReader<'a> {
    pub fn new(path: &'a Path) -> Self {
        Self(path)
    }

    pub fn read_gobo(&self, filename: &str) -> Option<FixtureImage> {
        let path = self.0.join("gobos").join(filename);

        read_gobo_image(&path, filename)
    }
}

// TODO: this should probably be bounded.
#[cached(
    type = "UnboundCache<String, Option<FixtureImage>>",
    create = r#"{ UnboundCache::new() }"#,
    convert = r#"{ filename.to_string() }"#
)]
fn read_gobo_image(path: &Path, filename: &str) -> Option<FixtureImage> {
    if !path.exists() {
        return None;
    }
    if filename.ends_with(".svg") {
        read_svg(path).ok()
    } else {
        read_raster(path).ok()
    }
}

fn read_svg(path: &Path) -> anyhow::Result<FixtureImage> {
    let mut buffer = String::new();
    let mut file = File::open(path)?;
    file.read_to_string(&mut buffer)?;

    Ok(FixtureImage::Svg(Arc::new(buffer)))
}

fn read_raster(path: &Path) -> anyhow::Result<FixtureImage> {
    let mut buffer = Vec::new();
    let mut file = File::open(path)?;
    file.read_to_end(&mut buffer)?;

    Ok(FixtureImage::Raster(Arc::new(buffer)))
}
