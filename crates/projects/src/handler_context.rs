use crate::project_file::{ProjectArchive, ProjectFile};
use crate::versioning::{migrate, Migrations};
use mizer_console::ConsoleCategory;
use mizer_module::{LoadProjectContext, ProjectHandlerContext, SaveProjectContext};
use serde::de::DeserializeOwned;
use serde::Serialize;
use std::fs::File;
use std::io::Write;
use std::path::Path;
use zip::unstable::LittleEndianWriteExt;

#[derive(Default)]
pub struct HandlerContext {
    archive: ProjectArchive,
}

impl HandlerContext {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn open(path: impl AsRef<Path>) -> anyhow::Result<Self> {
        let mut file = ProjectFile::open(path.as_ref())?;
        migrate(&mut file)?;
        let archive = match file {
            ProjectFile::Archive(archive) => archive,
            _ => return Err(anyhow::anyhow!("Invalid project file")),
        };

        Ok(Self { archive })
    }

    pub fn save(mut self, path: impl AsRef<Path>) -> anyhow::Result<()> {
        {
            let mut writer = self.archive.write()?;
            writer.write_file("VERSION")?;
            writer.write_u32_le(Migrations::latest_version())?;
        }
        let mut file = File::create(path.as_ref())?;
        file.write_all(&self.archive.0)?;

        Ok(())
    }
}

impl ProjectHandlerContext for HandlerContext {
    fn report_issue(&mut self, issue: impl Into<String>) {
        mizer_console::error!(ConsoleCategory::Projects, "{}", issue.into());
    }
}

impl LoadProjectContext for HandlerContext {
    fn read_file<T: DeserializeOwned>(&self, filename: &str) -> anyhow::Result<T> {
        tracing::trace!("Reading file {}", filename);
        let mut file = self.archive.read()?;
        let mut file = file.read_file(&format!("{filename}.json"))?;
        let content = serde_json::from_reader(&mut file)?;

        Ok(content)
    }
}

impl SaveProjectContext for HandlerContext {
    fn write_file<T: Serialize>(&mut self, filename: &str, content: T) -> anyhow::Result<()> {
        tracing::trace!("Writing file {}", filename);
        let mut writer = self.archive.write()?;
        writer.write_file(&format!("{filename}.json"))?;
        serde_json::to_writer(writer, &content)?;

        Ok(())
    }
}
