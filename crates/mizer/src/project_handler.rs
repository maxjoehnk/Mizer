use mizer_module::{LoadProjectContext, ProjectHandler, ProjectHandlerContext, SaveProjectContext};
use mizer_project_files::HandlerContext;

pub(crate) trait ErasedProjectHandler {
    fn new_project(&mut self, context: &mut crate::mizer::NewProjectContext) -> anyhow::Result<()>;
    fn load_project(&mut self, context: &mut HandlerContext) -> anyhow::Result<()>;
    fn save_project(&self, context: &mut HandlerContext) -> anyhow::Result<()>;
}

impl<T: ProjectHandler> ErasedProjectHandler for T {
    fn new_project(&mut self, context: &mut crate::mizer::NewProjectContext) -> anyhow::Result<()> {
        let mut context = ContextWrapper::new(self, context);
        T::new_project(self, &mut context)
    }

    fn load_project(&mut self, context: &mut HandlerContext) -> anyhow::Result<()> {
        let mut context = ContextWrapper::new(self, context);
        T::load_project(self, &mut context)
    }

    fn save_project(&self, context: &mut HandlerContext) -> anyhow::Result<()> {
        let mut context = ContextWrapper::new(self, context);
        T::save_project(self, &mut context)
    }
}

struct ContextWrapper<'a, TContext> {
    module: &'static str,
    context: &'a mut TContext,
}

impl<'a, TContext> ContextWrapper<'a, TContext> {
    fn new(handler: &impl ProjectHandler, context: &'a mut TContext) -> Self {
        Self {
            module: handler.get_name(),
            context,
        }
    }
}

impl<'a, TContext: ProjectHandlerContext> ProjectHandlerContext for ContextWrapper<'a, TContext> {
    fn try_get<T: 'static>(&self) -> Option<&T> {
        self.context.try_get()
    }

    fn try_get_mut<T: 'static>(&mut self) -> Option<&mut T> {
        self.context.try_get_mut()
    }

    fn report_issue(&mut self, issue: impl Into<String>) {
        self.context.report_issue(issue)
    }
}

impl<'a, TContext: LoadProjectContext> LoadProjectContext for ContextWrapper<'a, TContext> {
    fn read_file<T: serde::de::DeserializeOwned>(&self, filename: &str) -> anyhow::Result<T> {
        self.context.read_file(&format!("{}/{filename}", self.module))
    }
}

impl<'a, TContext: SaveProjectContext> SaveProjectContext for ContextWrapper<'a, TContext> {
    fn write_file<T: serde::Serialize>(&mut self, filename: &str, content: T) -> anyhow::Result<()> {
        self.context.write_file(&format!("{}/{filename}", self.module), content)
    }
}
