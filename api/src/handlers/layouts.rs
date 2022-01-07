use crate::models::*;
use crate::RuntimeApi;
use mizer_node::NodePath;

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
        log::debug!(
            "Moving control {} in layout {} to {:?}",
            control_id,
            layout_id,
            position
        );
        self.runtime
            .update_layout_control(layout_id, control_id, |control| control.position = position);
    }

    pub fn update_control(
        &self,
        layout_id: String,
        control_id: String,
        decorations: ControlDecorations,
    ) {
        let decorations = decorations.into();
        log::debug!(
            "Updating control {} in layout {} with {:?}",
            control_id,
            layout_id,
            decorations
        );
        self.runtime
            .update_layout_control(layout_id, control_id, |control| {
                control.decoration = decorations
            });
    }

    pub fn rename_control(&self, layout_id: String, control_id: String, name: String) {
        log::debug!(
            "Renaming control {} in layout {} to {}",
            control_id,
            layout_id,
            name
        );
        self.runtime
            .update_layout_control(layout_id, control_id, |control| control.label = name.into());
    }

    pub fn add_control(
        &self,
        layout_id: String,
        node_type: Node_NodeType,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        let node = self
            .runtime
            .add_node(node_type.into(), mizer_node::NodeDesigner::default())?;
        let size = Self::get_default_size_for_node_type(node_type);
        self.runtime
            .add_layout_control(layout_id, node.path, position.into(), size.into());

        Ok(())
    }

    pub fn add_control_for_node(
        &self,
        layout_id: String,
        node_path: NodePath,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        if let Some(node) = self.runtime.get_node(&node_path) {
            let size = Self::get_default_size_for_node_type(node.node_type().into());
            self.runtime
                .add_layout_control(layout_id, node_path, position.into(), size.into());
        }

        Ok(())
    }

    pub fn read_fader_value(&self, node_path: NodePath) -> Option<f64> {
        self.runtime.read_fader_value(node_path).ok()
    }

    fn get_default_size_for_node_type(node_type: Node_NodeType) -> ControlSize {
        match node_type {
            Node_NodeType::Fader => ControlSize {
                height: 4,
                width: 1,
                ..Default::default()
            },
            Node_NodeType::Button => ControlSize {
                height: 1,
                width: 1,
                ..Default::default()
            },
            Node_NodeType::Sequencer => ControlSize {
                height: 1,
                width: 1,
                ..Default::default()
            },
            _ => ControlSize::default(),
        }
    }
}
