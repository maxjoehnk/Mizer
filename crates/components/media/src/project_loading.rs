use mizer_module::{LoadProjectContext, ProjectHandler, ProjectHandlerContext, SaveProjectContext};
use crate::MediaServer;

impl ProjectHandler for MediaServer {
    fn get_name(&self) -> &'static str {
        "media"
    }

    fn new_project(&mut self, _context: &mut impl ProjectHandlerContext) -> anyhow::Result<()> {
        self.clear();
        
        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext) -> anyhow::Result<()> {
        self.clear();
        let files = context.read_file("files")?;
        self.import_files(files)?;
        let tags = context.read_file("tags")?;
        self.import_tags(tags)?;
        let watched_folders = context.read_file("watched_folders")?;
        self.set_import_paths(watched_folders);
        
        Ok(())
        
    }

    fn save_project(&self, context: &mut impl SaveProjectContext) -> anyhow::Result<()> {
        context.write_file("files", self.get_media()?)?;
        context.write_file("tags", self.get_tags()?)?;
        context.write_file("watched_folders", self.get_import_paths())?;
        
        Ok(())
    }
}
