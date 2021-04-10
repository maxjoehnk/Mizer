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
}
