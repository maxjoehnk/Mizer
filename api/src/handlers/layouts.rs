use crate::RuntimeApi;
use crate::models::*;

#[derive(Clone)]
pub struct LayoutsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> LayoutsHandler<R> {
    pub fn new(runtime: R) -> Self {
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

    pub fn remove_control(&self, layout_id: String, control_id: String) {
        log::debug!("Removing control {} in layout {}", control_id, layout_id);
        self.runtime.delete_layout_control(layout_id, control_id);
    }

    pub fn move_control(&self, layout_id: String, control_id: String, position: ControlPosition) {
        let position = position.into();
        log::debug!("Moving control {} in layout {} to {:?}", control_id, layout_id, position);
        self.runtime.update_layout_control(layout_id, control_id, |control| control.position = position);
    }

    pub fn rename_control(&self, layout_id: String, control_id: String, name: String) {
        log::debug!("Renaming control {} in layout {} to {}", control_id, layout_id, name);
        self.runtime.update_layout_control(layout_id, control_id, |control| control.label = name.into());
    }
}
