use mizer_module::*;
use mizer_project_files::HandlerContext;

pub(crate) trait ErasedProjectHandler {
    fn new_project(
        &mut self,
        context: &mut crate::mizer::NewProjectContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()>;
    fn load_project(
        &mut self,
        context: &mut HandlerContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()>;
    fn save_project(
        &self,
        context: &mut HandlerContext,
        injector: &dyn InjectDyn,
    ) -> anyhow::Result<()>;
}

impl<T: ProjectHandler> ErasedProjectHandler for T {
    fn new_project(
        &mut self,
        context: &mut crate::mizer::NewProjectContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let mut context = ContextWrapper::new(self, context);
        T::new_project(self, &mut context, injector)
    }

    fn load_project(
        &mut self,
        context: &mut HandlerContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let mut context = ContextWrapper::new(self, context);
        T::load_project(self, &mut context, injector)
    }

    fn save_project(
        &self,
        context: &mut HandlerContext,
        injector: &dyn InjectDyn,
    ) -> anyhow::Result<()> {
        let mut context = ContextWrapper::new(self, context);
        T::save_project(self, &mut context, injector)
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
    fn report_issue(&mut self, issue: impl Into<String>) {
        self.context.report_issue(issue)
    }
}

impl<'a, TContext: LoadProjectContext> LoadProjectContext for ContextWrapper<'a, TContext> {
    fn read_file<T: serde::de::DeserializeOwned>(&self, filename: &str) -> anyhow::Result<T> {
        self.context
            .read_file(&format!("{}/{filename}", self.module))
    }
}

impl<'a, TContext: SaveProjectContext> SaveProjectContext for ContextWrapper<'a, TContext> {
    fn write_file<T: serde::Serialize>(
        &mut self,
        filename: &str,
        content: T,
    ) -> anyhow::Result<()> {
        self.context
            .write_file(&format!("{}/{filename}", self.module), content)
    }
}
