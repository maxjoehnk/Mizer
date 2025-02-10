use crate::project_file::{ProjectArchive, ProjectFile};
use crate::versioning::{migrate, MigrationResult, Migrations};
use mizer_console::ConsoleCategory;
use mizer_module::{LoadProjectContext, ProjectHandlerContext, ProjectLoadingError, SaveProjectContext};
use serde::de::DeserializeOwned;
use serde::Serialize;
use std::fs::File;
use std::io::Write;
use std::path::Path;
use zip::unstable::LittleEndianWriteExt;

pub struct HandlerContext<'a> {
    archive: ProjectArchive,
    warnings: &'a mut Vec<String>,
    migration_result: Option<MigrationResult>,
}

impl<'a> HandlerContext<'a> {
    pub fn new(warnings: &'a mut Vec<String>) -> Self {
        Self {
            archive: ProjectArchive::new(),
            warnings,
            migration_result: None,
        }
    }

    pub fn open(path: impl AsRef<Path>, warnings: &'a mut Vec<String>) -> Result<Self, ProjectLoadingError> {
        let mut file = ProjectFile::open(path.as_ref())?;
        let migration_result= match migrate(&mut file) {
            Ok(result) => Some(result),
            Err(err) => {
                return Err(ProjectLoadingError::MigrationIssue(err));
            }
        };
        let archive = match file {
            ProjectFile::Archive(archive) => archive,
            _ => return Err(ProjectLoadingError::InvalidFile),
        };

        Ok(Self { archive, warnings, migration_result })
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
    
    pub fn migration_result(&self) -> Option<(u32, u32)> {
        self.migration_result.map(|result| (result.from_version, result.to_version))
    }
}

impl<'a> ProjectHandlerContext for HandlerContext<'a> {
    fn report_issue(&mut self, issue: impl Into<String>) {
        let issue = issue.into();
        mizer_console::error!(ConsoleCategory::Projects, "{issue}");
        self.warnings.push(issue);
    }
}

impl<'a> LoadProjectContext for HandlerContext<'a> {
    fn read_file<T: DeserializeOwned>(&self, filename: &str) -> anyhow::Result<T> {
        tracing::trace!("Reading file {}", filename);
        let mut file = self.archive.read()?;
        let mut file = file.read_file(&format!("{filename}.json"))?;
        let content = serde_json::from_reader(&mut file)?;

        Ok(content)
    }
}

impl<'a> SaveProjectContext for HandlerContext<'a> {
    fn write_file<T: Serialize>(&mut self, filename: &str, content: T) -> anyhow::Result<()> {
        tracing::trace!("Writing file {}", filename);
        let mut writer = self.archive.write()?;
        writer.write_file(&format!("{filename}.json"))?;
        serde_json::to_writer(writer, &content)?;

        Ok(())
    }
}
