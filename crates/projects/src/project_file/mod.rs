pub(crate) use self::archive_file::ProjectArchive;
use crate::SHOWFILE_EXTENSION;
use indexmap::IndexMap;
use serde::{Deserialize, Serialize};
use std::fs::File;
use std::io::Read;
use std::path::Path;
use zip::unstable::{LittleEndianReadExt, LittleEndianWriteExt};
use mizer_module::ProjectLoadingError;

mod archive_file;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ProjectFileType {
    Yaml,
    Zip,
}

impl TryFrom<&Path> for ProjectFileType {
    type Error = ProjectLoadingError;

    fn try_from(value: &Path) -> Result<Self, Self::Error> {
        match value.extension().and_then(|ext| ext.to_str()) {
            Some("yaml") | Some("yml") => Ok(Self::Yaml),
            Some(SHOWFILE_EXTENSION) => Ok(Self::Zip),
            _ => Err(ProjectLoadingError::UnsupportedFileType),
        }
    }
}

pub(crate) enum ProjectFile {
    Yaml(Vec<u8>),
    Archive(ProjectArchive),
}

impl ProjectFile {
    pub fn open(path: &Path) -> Result<Self, ProjectLoadingError> {
        let file_type = ProjectFileType::try_from(path)?;
        if !path.exists() {
            return Err(ProjectLoadingError::MissingFile);
        }
        let mut file = File::open(path)?;
        let mut file_content = Vec::new();
        file.read_to_end(&mut file_content)?;
        match file_type {
            ProjectFileType::Yaml => Ok(Self::Yaml(file_content)),
            ProjectFileType::Zip => Ok(Self::Archive(ProjectArchive(file_content))),
        }
    }

    #[profiling::function]
    pub(crate) fn get_version(&self) -> anyhow::Result<u32> {
        match self {
            Self::Yaml(file) => {
                let project_file: ProjectVersion = serde_yaml::from_slice(file)?;

                Ok(project_file.version)
            }
            Self::Archive(archive) => {
                let mut reader = archive.read()?;
                let mut file = reader.read_file("VERSION")?;
                let version = file.read_u32_le()?;

                Ok(version)
            }
        }
    }

    #[profiling::function]
    pub(crate) fn write_version(&mut self, version: u32) -> anyhow::Result<()> {
        match self {
            Self::Yaml(content) => {
                let mut project_file: ProjectVersionWithContent = serde_yaml::from_slice(content)?;
                project_file.version = version;
                *content = serde_yaml::to_vec(&project_file)?;
            }
            Self::Archive(archive) => {
                let mut writer = archive.write()?;
                writer.write_file("VERSION")?;
                writer.write_u32_le(version)?;
            }
        }

        Ok(())
    }

    pub(crate) fn as_yaml(&mut self) -> Option<&mut Vec<u8>> {
        match self {
            Self::Yaml(content) => Some(content),
            _ => None,
        }
    }

    pub(crate) fn as_archive(&mut self) -> Option<&mut ProjectArchive> {
        match self {
            Self::Archive(content) => Some(content),
            _ => None,
        }
    }
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
struct ProjectVersion {
    #[serde(default)]
    pub version: u32,
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
struct ProjectVersionWithContent {
    #[serde(default)]
    pub version: u32,
    #[serde(flatten)]
    content: IndexMap<String, serde_yaml::Value>,
}
