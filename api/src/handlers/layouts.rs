use crate::models::layouts::*;
use crate::models::nodes::node;
use crate::RuntimeApi;
use mizer_command_executor::*;
use mizer_node::NodePath;
use mizer_runtime::LayoutsView;

#[derive(Clone)]
pub struct LayoutsHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> LayoutsHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    pub fn get_layouts(&self) -> Layouts {
        Layouts {
            layouts: self
                .runtime
                .layouts()
                .into_iter()
                .map(Layout::from)
                .collect::<Vec<_>>(),
            ..Default::default()
        }
    }

    pub fn add_layout(&self, name: String) -> Layouts {
        self.runtime.run_command(AddLayoutCommand { name }).unwrap();

        self.get_layouts()
    }

    pub fn remove_layout(&self, id: String) -> Layouts {
        self.runtime
            .run_command(RemoveLayoutCommand { id })
            .unwrap();

        self.get_layouts()
    }

    pub fn rename_layout(&self, id: String, name: String) -> Layouts {
        self.runtime
            .run_command(RenameLayoutCommand { id, name })
            .unwrap();

        self.get_layouts()
    }

    pub fn remove_control(&self, layout_id: String, control_id: String) {
        log::debug!("Removing control {} in layout {}", control_id, layout_id);
        self.runtime
            .run_command(DeleteLayoutControlCommand {
                layout_id,
                control_id: control_id.into(),
            })
            .unwrap();
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
            .run_command(MoveLayoutControlCommand {
                layout_id,
                control_id,
                position,
            })
            .unwrap();
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
            .run_command(UpdateLayoutControlDecorationsCommand {
                layout_id,
                control_id,
                decorations,
            })
            .unwrap();
    }

    pub fn rename_control(&self, layout_id: String, control_id: String, name: String) {
        log::debug!(
            "Renaming control {} in layout {} to {}",
            control_id,
            layout_id,
            name
        );

        self.runtime
            .run_command(RenameLayoutControlCommand {
                layout_id,
                control_id,
                name,
            })
            .unwrap();
    }

    pub fn add_control(
        &self,
        layout_id: String,
        node_type: node::NodeType,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddLayoutControlWithNodeCommand {
            layout_id,
            node_type: node_type.into(),
            position: position.into(),
        })?;

        Ok(())
    }

    pub fn add_control_for_node(
        &self,
        layout_id: String,
        node_path: NodePath,
        position: ControlPosition,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(AddLayoutControlCommand {
            layout_id,
            path: node_path,
            position: position.into(),
        })?;

        Ok(())
    }

    pub fn read_fader_value(&self, node_path: NodePath) -> Option<f64> {
        match self.runtime.read_fader_value(node_path) {
            Ok(value) => Some(value),
            Err(err) => {
                tracing::error!("Error reading fader value: {:?}", err);
                None
            }
        }
    }

    #[tracing::instrument(skip(self))]
    pub fn layouts_view(&self) -> LayoutsView {
        self.runtime.layouts_view()
    }
}
