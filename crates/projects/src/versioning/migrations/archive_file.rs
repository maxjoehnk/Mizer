use crate::Project;
use crate::project_file::{ProjectArchive, ProjectFile};
use crate::versioning::ProjectMigration;

const ARCHIVE_VERSION: u32 = 10;

#[derive(Clone, Copy)]
pub struct ArchiveFile;

impl ProjectMigration for ArchiveFile {
    fn version(&self) -> u32 {
        ARCHIVE_VERSION
    }


    fn migrate(&self, project_file: &mut ProjectFile) -> anyhow::Result<()> {
        let file_content = project_file.as_yaml()
            .ok_or_else(|| anyhow::anyhow!("Trying to convert non yaml project file to new version"))?;
        let project: Project = serde_yaml::from_slice(&file_content)?;

        let archive = ProjectArchive::try_from(project)?;
        *project_file = ProjectFile::Archive(archive);

        Ok(())
    }
}

impl TryFrom<Project> for ProjectArchive {
    type Error = anyhow::Error;
    
    fn try_from(project: Project) -> Result<Self, Self::Error> {
        let mut archive = ProjectArchive::default();
        {
            let mut writer = archive.write()?;
            writer.write_file("playback.json")?;
            serde_json::to_writer(&mut writer, &project.playback)?;
            writer.write_file("fixtures/patch.json")?;
            serde_json::to_writer(&mut writer, &project.fixtures)?;
            writer.write_file("fixtures/groups.json")?;
            serde_json::to_writer(&mut writer, &project.groups)?;
            writer.write_file("fixtures/presets.json")?;
            serde_json::to_writer(&mut writer, &project.presets)?;
            writer.write_file("sequencer/sequences.json")?;
            serde_json::to_writer(&mut writer, &project.sequences)?;
            writer.write_file("effects/effects.json")?;
            serde_json::to_writer(&mut writer, &project.effects)?;
            writer.write_file("timecodes/timecodes.json")?;
            serde_json::to_writer(&mut writer, &project.timecodes)?;
            writer.write_file("pipeline/nodes.json")?;
            serde_json::to_writer(&mut writer, &project.nodes)?;
            writer.write_file("pipeline/channels.json")?;
            serde_json::to_writer(&mut writer, &project.channels)?;
            writer.write_file("layouts/layouts.json")?;
            serde_json::to_writer(&mut writer, &project.layouts)?;
            writer.write_file("plans/plans.json")?;
            serde_json::to_writer(&mut writer, &project.plans)?;
            writer.write_file("surfaces/surfaces.json")?;
            serde_json::to_writer(&mut writer, &project.surfaces)?;
            writer.write_file("connections/connections.json")?;
            serde_json::to_writer(&mut writer, &project.connections)?;
            writer.write_file("media/media.json")?;
            serde_json::to_writer(&mut writer, &project.media)?;
        }
        
        Ok(archive)
    }
}
