use mizer_runtime::RuntimeApi;
use crate::models::*;

#[derive(Clone)]
pub struct LayoutsHandler {
    runtime: RuntimeApi,
}

impl LayoutsHandler {
    pub fn new(runtime: RuntimeApi) -> Self {
        Self { runtime }
    }

    pub fn get_layouts(&self) -> Layouts {
        let layouts = self
            .runtime
            .layouts()
            .into_iter()
            .map(Layout::from)
            .collect::<Vec<_>>();
        let mut result = Layouts::new();
        result.set_layouts(layouts.into());

        result
    }

    pub fn add_layout(&self, name: String) -> Layouts {
        self.runtime.add_layout(name);

        self.get_layouts()
    }

    pub fn remove_layout(&self, id: String) -> Layouts {
        self.runtime.remove_layout(id);

        self.get_layouts()
    }

    pub fn rename_layout(&self, id: String, name: String) -> Layouts {
        self.runtime.rename_layout(id, name);

        self.get_layouts()
    }
}
